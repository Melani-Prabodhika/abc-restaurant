package com.abc.res.controller;

import com.abc.res.model.OrderModel;
import com.abc.res.model.ReservationModel;
import com.abc.res.service.OrderService;
import com.abc.res.service.ReservationService;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    private ReservationService reservationService;
    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        reservationService = new ReservationService();
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            handleReservationGet(req, res);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        handleReservationPost(req, res);
    }

    private void handleReservationPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String reservationId = req.getParameter("reservationId");
        String status = req.getParameter("status");


        if (reservationId == null || status == null) {
            // Handle the case where reservationId or status is missing
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing reservation ID or status.");
            return;
        }

        boolean success = reservationService.updateReservationStatus(Integer.parseInt(reservationId), status);

        if (success) {
            sendJsonResponse(res, true, "Reservation status updated successfully.", null);
        } else {
            sendJsonResponse(res, false, "Failed to update reservation status.", null);
        }
    }

    protected void handleReservationGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, SQLException, NoSuchAlgorithmException, ClassNotFoundException {
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            // If user is not logged in, redirect to login page
            res.sendRedirect("/");
            return;
        }

        List<ReservationModel> reservations = reservationService.getReservationByUserId(userId);
        List<OrderModel> orders = orderService.getAllOrdersByUserId(userId);

        req.setAttribute("reservations", reservations);
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/WEB-INF/view/user/customer/profile.jsp").forward(req, res);
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message, String returnUrl) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"success\":" + success + ",\"message\":\"" + message + "\" " + (returnUrl != null ? ",\"returnUrl\":\"" + returnUrl + "\"" : "") + "}");
        out.flush();
    }
}

