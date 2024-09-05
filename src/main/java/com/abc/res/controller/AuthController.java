package com.abc.res.controller;

import com.abc.res.model.User;
import com.abc.res.service.AuthService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/auth")
public class AuthController extends HttpServlet {

    private static AuthService getAuthService() {
        return AuthService.getAuthService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String actionType = req.getParameter("action");

        if (actionType == null) {
            // Handle the case where actionType is missing
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing action type.");
            return;
        }

        switch (actionType) {
            case "login":
                req.getRequestDispatcher("WEB-INF/view/web/login.jsp").forward(req, res);
                break;
            case "signup":
                req.getRequestDispatcher("WEB-INF/view/web/signup.jsp").forward(req, res);
                break;
            default:
                res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action type.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String actionType = req.getParameter("action");

        if (actionType == null) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing action type.");
            return;
        }

        switch (actionType) {
            case "login":
//                loginUser(req, res);
                break;
            case "register":
                registerUser(req, res);
                break;
            default:
                res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action type.");
        }
    }

    private void registerUser(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
        String userName = req.getParameter("name");
        String contactNo = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String password = req.getParameter("password");

        // Create a new User object
        User user = new User(
                3,
                userName,
                contactNo,
                email,
                address,
                password
        );

        try {
            boolean result = getAuthService().registerUser(user);
            if (result) {
                sendJsonResponse(response, true, "User registered successfully");
            } else {
                sendJsonResponse(response, false, "Failed to register user");
            }
        } catch (Exception e) {
            sendJsonResponse(response, false, "An error occurred: " + e.getMessage());
        }
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"success\":" + success + ",\"message\":\"" + message + "\"}");
        out.flush();
    }
}
