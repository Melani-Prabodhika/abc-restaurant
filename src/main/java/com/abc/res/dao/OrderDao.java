package com.abc.res.dao;

import com.abc.res.model.OrderModel;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

public interface OrderDao {
    int saveOrder(OrderModel order) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException;

    boolean updateOrderPaymentStatus(int orderId, String paymentStatus, String status, String paymentIntentId) throws SQLException, ClassNotFoundException;

    List<OrderModel> getOrdersByUserId(int userId) throws SQLException, ClassNotFoundException;

    List<OrderModel> getAllPendingOrders(int BranchId) throws SQLException, ClassNotFoundException;

    List<OrderModel> getAllOtherOrders(int BranchId) throws SQLException, ClassNotFoundException;
}
