package com.abc.res.controller;

import com.abc.res.model.*;
import com.abc.res.service.HomeService;
import com.abc.res.model.MenuItemModel;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/")
public class HomeController extends HttpServlet {

    private static HomeService getHomeService() {
        return HomeService.getHomeService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String requestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = requestURI.substring(contextPath.length());

        if (path.startsWith("/assets/")) {
            getServletContext().getNamedDispatcher("default").forward(req, res);
            return;
        }

        switch (path) {
            case "/about":
                req.setAttribute("pageTitle", "About");
                req.getRequestDispatcher("WEB-INF/view/web/about.jsp").forward(req, res);
                break;
            case "/menu1":
                req.setAttribute("pageTitle", "Menu");
                req.getRequestDispatcher("WEB-INF/view/web/menu.jsp").forward(req, res);
                break;
            case "/menu2":
                req.setAttribute("pageTitle", "Menu");
                handleMenu(req, res);
                break;
            case "/gallery":
                req.setAttribute("pageTitle", "Gallery");
                req.getRequestDispatcher("WEB-INF/view/web/gallery.jsp").forward(req, res);
                break;
            case "/contact":
                req.setAttribute("pageTitle", "Contact");
                req.getRequestDispatcher("WEB-INF/view/web/contact.jsp").forward(req, res);
                break;
            case "/order/confirm":
                req.setAttribute("pageTitle", "Order");
                req.getRequestDispatcher("/WEB-INF/view/user/customer/order.jsp").forward(req, res);
                break;
            default:
                req.setAttribute("pageTitle", "Home");
                handleHome(req, res);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String requestURI = req.getRequestURI();

        switch (requestURI) {
            case "/contact":
                handleContactPost(req, res);
                break;
            default:
                handleHome(req, res);
                break;
        }
    }

    private void handleHome(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("/").forward(req, res);
    }

    private void handleContactPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        CommonMsgModel message;
        res.setContentType("application/json");
        PrintWriter out = res.getWriter();

        try {
            // Create QueryModel instance
            QueryModel queryModel = new QueryModel();
            queryModel.setCustomerName(req.getParameter("name"));
            queryModel.setCustomerContact(req.getParameter("phone"));
            queryModel.setCustomerWhatsapp(req.getParameter("whatsapp"));
            queryModel.setEmail(req.getParameter("email"));
            queryModel.setSubject(req.getParameter("subject"));
            queryModel.setMessage(req.getParameter("message"));

            // Call service method to add the query
            message = getHomeService().addQuery(queryModel, req);

            // Write response as JSON
            out.println(new Gson().toJson(message));

        } catch (Exception e) {
            message = new CommonMsgModel("Something went wrong.", false, null);
            out.print(new Gson().toJson(message.toJsonObject()));
            e.printStackTrace();
        } finally {
            out.flush();
        }
    }

    private void handleMenu(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        List<MenuItemModel> menuItems = new ArrayList<MenuItemModel>();
        try {
            menuItems = getHomeService().getAllMenuItems();
            System.out.println("c" + menuItems);
            req.setAttribute("menuItems", menuItems);
        } catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e) {
            req.setAttribute("errorMessage", e.getMessage());
            e.printStackTrace();
        } finally {
            req.getRequestDispatcher("WEB-INF/view/user/customer/menu.jsp").forward(req, res);
        }
    }

}
