package com.abc.res.dao;

import com.abc.res.model.User;
import com.abc.res.utils.database.DBConnectionFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {

    private Connection getDbConnection() throws ClassNotFoundException, SQLException {
        return new DBConnectionFactory().getConnection();
    }

    @Override
    public List<User> getAllCustomers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM user WHERE ut_id = 3";

        try (Connection con = getDbConnection();
             PreparedStatement statement = con.prepareStatement(query)) {

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    User user = new User(
                            rs.getInt("ut_id"),
                            rs.getString("user_name"),
                            rs.getString("contact_no"),
                            rs.getString("email"),
                            rs.getString("address")
                    );
                    user.setUserId(rs.getInt("user_id"));
                    user.setStatus(rs.getString("status"));
                    user.setBranchId(rs.getInt("branch_id"));
                    Timestamp regDateTimestamp = rs.getTimestamp("reg_date");
                    user.setRegDate(regDateTimestamp != null ? new Date(regDateTimestamp.getTime()) : null);
                    users.add(user);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // Handle exceptions appropriately
        }
        System.out.println("Dao" + users);
        return users;
    }

    @Override
    public List<User> getAllStaff(int branchId) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM user WHERE ut_id != 3 AND branch_id = ?";

        try (Connection con = getDbConnection();
             PreparedStatement statement = con.prepareStatement(sql)) {
                statement.setInt(1, branchId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    User user = new User(
                            rs.getInt("ut_id"),
                            rs.getString("user_name"),
                            rs.getString("contact_no"),
                            rs.getString("email"),
                            rs.getString("address")
                    );
                    user.setUserId(rs.getInt("user_id"));
                    user.setStatus(rs.getString("status"));
                    user.setBranchId(rs.getInt("branch_id"));
                    Timestamp regDateTimestamp = rs.getTimestamp("reg_date");
                    user.setRegDate(regDateTimestamp != null ? new Date(regDateTimestamp.getTime()) : null);
                    users.add(user);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); // Handle exceptions appropriately
        }
        return users;
    }

//    @Override
//    public boolean updateUserStatus(int userId, String newStatus) {
//        String sql = "UPDATE user SET status = ? WHERE user_id = ?";
//
//        try (Connection conn = getDbConnection();
//             PreparedStatement pstmt = conn.prepareStatement(sql)) {
//
//            pstmt.setString(1, newStatus);
//            pstmt.setInt(2, userId);
//            int rowsUpdated = pstmt.executeUpdate();
//            return rowsUpdated > 0; // Return true if at least one row was updated
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace(); // Handle exceptions appropriately
//            return false;
//        }
//    }
}
