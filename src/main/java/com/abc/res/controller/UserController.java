package com.abc.res.controller;

import com.abc.res.dao.MenuItemDao;
import com.abc.res.model.*;
import com.abc.res.service.HomeService;
import com.abc.res.service.ReservationService;
import com.abc.res.service.UserService;
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

@WebServlet("/user/*")
public class UserController extends HttpServlet {

    private ReservationService reservationService;

    private HomeService homeService;

    private UserService userService;

    @Override
    public void init() throws ServletException {
        reservationService = new ReservationService();
        homeService = new HomeService();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String path = req.getPathInfo();

        if (path == null) {
            res.sendRedirect(req.getContextPath() + "/"); // Redirect to dashboard if no path is provided
            return;
        }

        switch (path) {
            case "/dashboard":
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
                break;

            case "/reservations/pending":
                req.setAttribute("pageTitle", "Pending Reservations");
                handlePendingReservationGet(req, res);
                break;

            case "/reservations/confirmed":
                req.setAttribute("pageTitle", "Confirmed Reservations");
                handleConfirmedReservationGet(req, res);
                break;

            case "/reservations/rejected":
                req.setAttribute("pageTitle", "Rejected Reservations");
                handleRejectedReservationGet(req, res);
                break;

            case "/orders/pending":
                req.setAttribute("pageTitle", "Pending Orders");
                req.getRequestDispatcher("/WEB-INF/view/user/admin/order/o_pending.jsp").forward(req, res);
                break;

            case "/orders/confirmed":
                req.setAttribute("pageTitle", "Confirmed Orders");
                req.getRequestDispatcher("/WEB-INF/view/user/admin/order/o_confirmed.jsp").forward(req, res);
                break;

            case "/orders/rejected":
                req.setAttribute("pageTitle", "Rejected Orders");
                req.getRequestDispatcher("/WEB-INF/view/user/admin/order/o_rejected.jsp").forward(req, res);
                break;

            case "/customers":
                req.setAttribute("pageTitle", "Customers");
                handleAllCustomersGet(req, res);
                break;

            case "/menu/add":
                req.setAttribute("pageTitle", "Add Menu Item");
                req.getRequestDispatcher("/WEB-INF/view/user/admin/menu_item/menu_form.jsp").forward(req, res);
                break;

            case "/menu/list":
                req.setAttribute("pageTitle", "Menu Item List");
                handleMenuGet(req, res);
                break;

            case "/staff/add":
                req.setAttribute("pageTitle", "Add Staff");
                req.getRequestDispatcher("/WEB-INF/view/user/admin/staff/staff_form.jsp").forward(req, res);
                break;

            case "/staff/list":
                req.setAttribute("pageTitle", "Staff List");
                handleAllStaffGet(req, res);
                break;

            case "/queries":
                req.setAttribute("pageTitle", "Queries");
                handleAllQueriesGet(req, res);
                break;

            default:
                res.sendRedirect(req.getContextPath() + "/");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        // Handle form submissions or other POST requests if needed
        PrintWriter out = res.getWriter();
        res.setContentType("application/json");

        CommonMsgModel message = new CommonMsgModel("Form submission not implemented yet.", false, null);
        out.println(new Gson().toJson(message));
        out.flush();
    }

    protected void handlePendingReservationGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer branchId = (Integer) session.getAttribute("branch_id");

        if (branchId == null) {
            res.sendRedirect("/");
            return;
        }

        List<ReservationModel> reservations = reservationService.getPendingReservations(branchId);
        System.out.println(reservations);
        req.setAttribute("reservations", reservations);
        req.getRequestDispatcher("/WEB-INF/view/user/admin/reservation/r_pending.jsp").forward(req, res);
    }

    protected void handleConfirmedReservationGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer branchId = (Integer) session.getAttribute("branch_id");

        if (branchId == null) {
            res.sendRedirect("/");
            return;
        }
        List<ReservationModel> reservations = reservationService.getConfirmReservations(branchId);
        System.out.println(reservations);
        req.setAttribute("reservations", reservations);
        req.getRequestDispatcher("/WEB-INF/view/user/admin/reservation/r_confirmed.jsp").forward(req, res);
    }

    protected void handleRejectedReservationGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer branchId = (Integer) session.getAttribute("branch_id");

        if (branchId == null) {
            res.sendRedirect("/");
            return;
        }

        List<ReservationModel> reservations = reservationService.getRejectReservations(branchId);
        System.out.println(reservations);
        req.setAttribute("reservations", reservations);
        req.getRequestDispatcher("/WEB-INF/view/user/admin/reservation/r_rejected.jsp").forward(req, res);
    }

    protected void handleAllQueriesGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        List<QueryModel> queries = homeService.getAllQueries();
        req.setAttribute("queries", queries);
        req.getRequestDispatcher("/WEB-INF/view/user/admin/queries.jsp").forward(req, res);
    }

    protected void handleAllStaffGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Integer branchId = (Integer) session.getAttribute("branch_id");

        if (branchId == null) {
            res.sendRedirect("/");
            return;
        }

        List<User> users = userService.getAllStaff(branchId);
        System.out.println(users);
        req.setAttribute("users", users);
        req.getRequestDispatcher("/WEB-INF/view/user/admin/staff/staff_list.jsp").forward(req, res);
    }

    protected void handleAllCustomersGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        List<User> customers = userService.getAllCustomers();
        req.setAttribute("customers", customers);
        req.getRequestDispatcher("/WEB-INF/view/user/admin/customer_list.jsp").forward(req, res);
    }

    private void handleMenuGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        List<MenuItemModel> menuItems = new ArrayList<MenuItemModel>();
        try {
            menuItems = homeService.getAllMenuItems();
            req.setAttribute("menuItems", menuItems);
        } catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e) {
            req.setAttribute("errorMessage", e.getMessage());
            e.printStackTrace();
        } finally {
            req.getRequestDispatcher("/WEB-INF/view/user/admin/menu_item/menu_list.jsp").forward(req, res);
        }
    }

}

