package com.abc.res.service;

import com.abc.res.dao.UserDao;
import com.abc.res.dao.UserDaoImpl;
import com.abc.res.model.CommonMsgModel;
import com.abc.res.model.User;

import javax.servlet.http.HttpServletRequest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;
import java.util.regex.Pattern;

public class UserService {

    private static UserService userService;

    public UserService() {}

    public static synchronized UserService getUserService() {
        if (userService == null) {
            userService = new UserService();
        }
        return userService;
    }

    private UserDao getUserDao() {
        return new UserDaoImpl();
    }

    public List<User> getAllCustomers() {
        try {
            List<User> customers = getUserDao().getAllCustomers();
            return customers;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<User> getAllStaff(int BranchId) {
        try {
            List<User> users = getUserDao().getAllStaff(BranchId);
            System.out.println("service: " + users);
            return users;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }

}

