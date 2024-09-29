package com.abc.res.dao;

import com.abc.res.model.OrderItemModel;
import com.abc.res.model.OrderModel;
import com.abc.res.utils.database.DBConnectionFactory;

import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDaoImpl implements OrderDao {

    // Helper method to get a new database connection
    private Connection getDbConnection() throws ClassNotFoundException, SQLException {
        return new DBConnectionFactory().getConnection();
    }

    @Override
    public int saveOrder(OrderModel order) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException {
        Connection con = getDbConnection();
        String sql = "INSERT INTO `orders`(user_id, amount, delivery_method, address, contact_no, branch_id) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement statement = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, order.getUserId());
            statement.setBigDecimal(2, order.getTotalAmount());
            statement.setString(3, order.getDeliveryMethod());
            statement.setString(4, order.getDeliveryAddress());
            statement.setString(5, order.getCustomerContact());
            statement.setInt(6, order.getBranchId());

            int affectedRows = statement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    order.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }

            saveOrderItems(order);
            return order.getId();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    private void saveOrderItems(OrderModel order) throws SQLException, ClassNotFoundException {

        Connection con = getDbConnection();
        String sql = "INSERT INTO `order_item`(order_id, menu_item_id, qty, price) VALUES (?, ?, ?, ?)";

        try (PreparedStatement statement = con.prepareStatement(sql)) {
            for (OrderItemModel orderItem : order.getOrderItems()) {
                statement.setInt(1, order.getId());
                statement.setInt(2, orderItem.getMenuItemId());
                statement.setInt(3, orderItem.getQuantity());
                statement.setBigDecimal(4, orderItem.getPrice());
                statement.addBatch();
            }

            statement.executeBatch();
        }

    }

    @Override
    public boolean updateOrderPaymentStatus(int orderId, String paymentStatus, String status, String paymentIntentId) throws SQLException, ClassNotFoundException {

        Connection con = getDbConnection();
        String sql = "UPDATE orders SET payment_status= ?, status = ?, payment_intent_id= ? WHERE order_id = ?";

        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setString(1, paymentStatus);
            statement.setString(2, status);
            statement.setString(3, paymentIntentId);
            statement.setInt(4, orderId);
            statement.executeUpdate();

            return true;
        } catch (SQLException e) {
            System.out.println("DAO updateOrderPaymentStatus Error occurred while updating order: " + e.getMessage());
            throw e;
        }
    }

    @Override
    public List<OrderModel> getOrdersByUserId(int userId) throws SQLException, ClassNotFoundException {
        Connection con = getDbConnection();
        List<OrderModel> orders = new ArrayList<>();
        String sql = "SELECT orders.*, user.user_name \n" +
                "FROM orders \n" +
                "JOIN user ON user.user_id = orders.user_id \n" +
                "WHERE orders.user_id = ?;\n";

        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    OrderModel order = new OrderModel();
                    order.setId(rs.getInt("order_id"));
                    order.setUserName(rs.getString("user_name"));
                    order.setTotalAmount(rs.getBigDecimal("amount"));
                    order.setOrderDate(rs.getString("order_date"));
                    order.setOrderStatus(rs.getString("status"));
                    order.setDeliveryMethod(rs.getString("delivery_method"));
                    order.setDeliveryAddress(rs.getString("address"));
                    order.setCustomerContact(rs.getString("contact_no"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setOrderItems(getOrderItems(order.getId()));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.out.println("DAO getAllOrders Error occurred while getting all orders: " + e.getMessage());
            throw e;
        }

        return orders;
    }

    private List<OrderItemModel> getOrderItems(int orderId) throws SQLException, ClassNotFoundException {
        Connection con = getDbConnection();
        String sql = "SELECT order_item.qty, order_item.price, menu_item.item_name\n" +
                "FROM order_item\n" +
                "LEFT JOIN menu_item ON order_item.menu_item_id = menu_item.mi_id\n" +
                "WHERE order_item.order_id = ?";
        List<OrderItemModel> orderItems = new ArrayList<>();

        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, orderId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    OrderItemModel orderItem = new OrderItemModel();
                    orderItem.setName(rs.getString("item_name"));
                    orderItem.setQuantity(rs.getInt("qty"));
                    orderItem.setPrice(rs.getBigDecimal("price"));
                    orderItems.add(orderItem);
                }
            }
        } catch (SQLException e) {
            System.out.println("DAO getOrderItems Error occurred while getting order items: " + e.getMessage());
            throw e;
        }

        return orderItems;
    }

    @Override
    public List<OrderModel> getAllPendingOrders(int BranchId) throws SQLException, ClassNotFoundException {
        Connection con = getDbConnection();
        List<OrderModel> orders = new ArrayList<>();
        String sql = "SELECT orders.*, user.user_name\n" +
                "FROM orders\n" +
                "INNER JOIN user ON user.user_id = orders.user_id\n" +
                "WHERE orders.branch_id = ? AND orders.status = 'pending';\n";

        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, BranchId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    OrderModel order = new OrderModel();
                    order.setId(rs.getInt("order_id"));
                    order.setUserName(rs.getString("user_name"));
                    order.setTotalAmount(rs.getBigDecimal("amount"));
                    order.setOrderDate(rs.getString("order_date"));
                    order.setOrderStatus(rs.getString("status"));
                    order.setDeliveryMethod(rs.getString("delivery_method"));
                    order.setDeliveryAddress(rs.getString("address"));
                    order.setCustomerContact(rs.getString("contact_no"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setOrderItems(getOrderItems(order.getId()));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.out.println("DAO getAllOrders Error occurred while getting all orders: " + e.getMessage());
            throw e;
        }
        return orders;
    }

    @Override
    public List<OrderModel> getAllOtherOrders(int BranchId) throws SQLException, ClassNotFoundException {
        Connection con = getDbConnection();
        List<OrderModel> orders = new ArrayList<>();
        String sql = "SELECT orders.*, user.user_name\n" +
                "FROM orders\n" +
                "INNER JOIN user ON user.user_id = orders.user_id\n" +
                "WHERE orders.branch_id = ? AND orders.status != 'pending';\n";

        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, BranchId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    OrderModel order = new OrderModel();
                    order.setId(rs.getInt("order_id"));
                    order.setUserName(rs.getString("user_name"));
                    order.setTotalAmount(rs.getBigDecimal("amount"));
                    order.setOrderDate(rs.getString("order_date"));
                    order.setOrderStatus(rs.getString("status"));
                    order.setDeliveryMethod(rs.getString("delivery_method"));
                    order.setDeliveryAddress(rs.getString("address"));
                    order.setCustomerContact(rs.getString("contact_no"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setOrderItems(getOrderItems(order.getId()));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.out.println("DAO getAllOrders Error occurred while getting all orders: " + e.getMessage());
            throw e;
        }
        return orders;
    }
}
