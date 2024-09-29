package com.abc.res.service;

import com.abc.res.dao.OrderDao;
import com.abc.res.dao.OrderDaoImpl;
import com.abc.res.model.OrderModel;
import com.mysql.cj.AbstractQuery;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

public class OrderService {
    private OrderDao orderDao;

    public OrderService() {
        this.orderDao = new OrderDaoImpl();
    }

    public int createOrder(OrderModel order) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException, IllegalArgumentException {

        // Save the order
        int res = orderDao.saveOrder(order);

        if (res == 0) {
            throw new SQLException("Failed to save the order");
        }

        return res;
    }

    public boolean updateOrderPaymentStatus(int orderId, String paymentStatus, String status, String paymentIntentId) throws SQLException, ClassNotFoundException, IllegalArgumentException {
        if (orderId <= 0) {
            throw new IllegalArgumentException("Invalid order ID");
        }

        if (status == null || status.trim().isEmpty()) {
            throw new IllegalArgumentException("Payment status cannot be empty");
        }

        boolean updated = orderDao.updateOrderPaymentStatus(orderId, paymentStatus, status, paymentIntentId);

        if (!updated) {
            throw new IllegalArgumentException("Failed to update payment status");
        }

        return true;
    }

    public List<OrderModel> getAllOrdersByUserId(int userId) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException {
        return orderDao.getOrdersByUserId(userId);
    }

    public List<OrderModel> getAllPendingOrders(int branchId) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException {
        return orderDao.getAllPendingOrders(branchId);
    }

    public List<OrderModel> getAllOtherOrders(int branchId) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException {
        return orderDao.getAllOtherOrders(branchId);
    }
}
