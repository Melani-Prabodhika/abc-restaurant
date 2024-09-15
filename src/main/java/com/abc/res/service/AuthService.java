package com.abc.res.service;

import com.abc.res.dao.AuthDao;
import com.abc.res.dao.AuthDaoImpl;
import com.abc.res.model.LoginModel;
import com.abc.res.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.regex.Pattern;

public class AuthService {

    private static AuthService authService;

    public static synchronized AuthService getAuthService() {
        if (authService == null) {
            authService = new AuthService();
        }
        return authService;
    }

    private AuthDao getAuthDao() {
        return new AuthDaoImpl();
    }

    private void setUserSession(HttpServletRequest req, User user) {
        HttpSession session = req.getSession();
        session.setMaxInactiveInterval(60 * 60);
        session.setAttribute("user_id", user.getUserId());
        session.setAttribute("ut_id", user.getUtId());
        session.setAttribute("user_name", user.getUserName());
        session.setAttribute("contact_no", user.getContactNo());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("address", user.getAddress());
        session.setAttribute("status", user.getStatus());
        session.setAttribute("branch_id", user.getBranchId());
    }

    private String determineRedirectUrl(int ut_id, String contextPath) {
        return switch (ut_id) {
            case 1 -> contextPath + "/admin";
            case 2 -> contextPath + "/staff";
            default -> contextPath + "/";
        };
    }

    public boolean registerUser(User user) throws SQLException, NoSuchAlgorithmException {
        // Validate user data
        StringBuilder errorMessage = new StringBuilder();

        if (user.getUserName() == null || user.getUserName().trim().isEmpty()) {
            errorMessage.append("User name cannot be empty. ");
        }

        if (user.getContactNo() == null || !Pattern.matches("\\d{10}", user.getContactNo())) {
            errorMessage.append("Invalid phone number. ");
        }

        if (user.getEmail() == null || !Pattern.matches("^[A-Za-z0-9+_.-]+@(.+)$", user.getEmail())) {
            errorMessage.append("Invalid email address. ");
        }

        if (user.getAddress() == null || user.getAddress().trim().isEmpty()) {
            errorMessage.append("Address cannot be empty. ");
        }

        if (user.getPassword() == null || !Pattern.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$", user.getPassword())) {
            errorMessage.append("Invalid password. Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character. ");
        }

        if (!errorMessage.isEmpty()) {
            throw new IllegalArgumentException(errorMessage.toString().trim());
        }

        // Check if user already exists
        if (getAuthDao().getUserByEmail(user.getEmail())) {
            throw new IllegalArgumentException("A user with this email already exists");
        }

        // Save the user to the database
        boolean success = getAuthDao().registerUser(user);
        if (success) {

            return true;
        } else {
            return false;
        }
    }

    public String loginUser(LoginModel loginModel, HttpServletRequest req) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException {
        User user = getAuthDao().loginUser(loginModel);

        if(user != null) {
            setUserSession(req, user);
            String redirectUrl = determineRedirectUrl(user.getUtId(), req.getContextPath());
            return redirectUrl;
        } else {
            return null;
        }
    }
}
