package com.abc.res.controller;

import com.abc.res.model.CommonMsgModel;
import com.abc.res.model.OrderItemModel;
import com.abc.res.model.OrderModel;
import com.abc.res.model.QueryModel;
import com.abc.res.service.OrderService;
import com.abc.res.service.StripeService;
import com.google.gson.*;
import com.google.gson.reflect.TypeToken;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/order/*")
public class OrderController extends HttpServlet {


    private Gson gson;
    private OrderService orderService;
    private StripeService stripeService;

    @Override
    public void init() throws ServletException {
        super.init();
        orderService = new OrderService();
        stripeService = new StripeService();
        gson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd HH:mm:ss")
                .create();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid path");
            return;
        }

        String[] splits = pathInfo.split("/");
        if (splits.length != 2) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid path");
            return;
        }

        String action = splits[1];
        switch (action) {
            case "confirm":
                req.getRequestDispatcher("/WEB-INF/view/user/customer/order.jsp").forward(req, resp);
                break;
            case "confirmation":
                orderConfirmation(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void orderConfirmation(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String orderId = req.getParameter("id");
        String payment_intent_id = req.getParameter("payment_intent");

        if (orderId == null || orderId.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID is required");
            return;
        }

        try {
            boolean success = orderService.updateOrderPaymentStatus(Integer.parseInt(orderId), "paid", "preparing", payment_intent_id);

            if (!success) {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update order status");
                return;
            }


            resp.sendRedirect("/profile");
        } catch (NumberFormatException e) {
            System.out.println("Controller Invalid Order ID: " + orderId);
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Order ID");
        }
        catch (Exception e) {
            System.out.println("Controller Unexpected error when retrieving order: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unexpected error occurred");
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if ("/submit".equals(pathInfo)) {
            submitOrder(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void submitOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        CommonMsgModel message;
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();

        try {
            // Read JSON data from request body
            BufferedReader reader = req.getReader();
            JsonObject jsonObject = JsonParser.parseReader(reader).getAsJsonObject();

            // Create and populate OrderModel
            OrderModel order = new OrderModel();
            order.setUserId(jsonObject.get("user_id").getAsInt());
            order.setCustomerContact(jsonObject.get("contactNumber").getAsString());
            order.setDeliveryMethod(jsonObject.get("deliveryMethod").getAsString());
            order.setDeliveryAddress(jsonObject.get("address").getAsString());
            order.setBranchId(jsonObject.get("branch_id").getAsInt());

            // Extract order items
            JsonArray itemsArray = jsonObject.getAsJsonArray("orderItems");
            List<OrderItemModel> orderItems = new ArrayList<>();
            for (JsonElement itemElement : itemsArray) {
                JsonObject itemObject = itemElement.getAsJsonObject();
                OrderItemModel item = new OrderItemModel();
                item.setMenuItemId(itemObject.get("menuItemId").getAsInt());
                item.setName(itemObject.get("name").getAsString());
                item.setPrice(BigDecimal.valueOf(itemObject.get("price").getAsDouble()));
                item.setQuantity(itemObject.get("quantity").getAsInt());
                orderItems.add(item);
            }
            order.setOrderItems(orderItems);

            // Calculate total amount
            BigDecimal totalAmount = orderItems.stream()
                    .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            order.setTotalAmount(totalAmount);

            int orderId = orderService.createOrder(order);
            if (orderId == 0) {
                throw new Exception("Failed to submit order.");
            }

            String clientSecret = stripeService.createPaymentIntent(totalAmount, orderId);

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("success", true);
            responseData.put("orderId", orderId);
            responseData.put("clientSecret", clientSecret);

            out.print(gson.toJson(responseData));
        } catch (Exception e) {
            message = new CommonMsgModel("Something went wrong.", false, null);
            out.print(new Gson().toJson(message.toJsonObject()));
            e.printStackTrace();
        } finally {
            out.flush();
        }
    }
}
