package com.abc.res.controller;

import com.abc.res.model.CommonMsgModel;
import com.abc.res.model.LoginModel;
import com.abc.res.model.User;
import com.abc.res.service.AuthService;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

import static com.abc.res.utils.data_mapper.DataMapper.getDataMapper;

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
            case "logout":
                logoutUser(req, res);
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
                loginUser(req, res);
                break;
            case "register":
                registerUser(req, res);
                break;
            default:
                res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action type.");
        }
    }

    void logoutUser(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        HttpSession session = req.getSession(false);

        if (session.getAttribute("user_id") != null) {
            session.invalidate();
            res.sendRedirect(req.getContextPath() + "/");
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
                address
        );
        user.setPassword(password);

        try {
            boolean result = getAuthService().registerUser(user);
            if (result) {
                sendJsonResponse(response, true, "User registered successfully", "/auth?action=login");
            } else {
                sendJsonResponse(response, false, "Failed to register user", null);
            }
        } catch (Exception e) {
            sendJsonResponse(response, false, "An error occurred: " + e.getMessage(), null);
        }
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message, String returnUrl) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"success\":" + success + ",\"message\":\"" + message + "\" " + (returnUrl != null ? ",\"returnUrl\":\"" + returnUrl + "\"" : "") + "}");
        out.flush();
    }

    private  void loginUser(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            LoginModel loginModel = new LoginModel();
            loginModel.setEmail(email);
            loginModel.setPassword(password);

            String returnUrl = getAuthService().loginUser(loginModel, req);

            if (returnUrl != null) {
                sendJsonResponse(res, true, "Login successful", returnUrl);
            } else {
                sendJsonResponse(res, false, "Invalid email or password", null);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
