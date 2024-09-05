package com.abc.res.dao;

import com.abc.res.model.User;
import com.abc.res.utils.database.DBConnectionFactory;
import com.abc.res.utils.encrypter.HashPassword;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthDaoImpl implements AuthDao {

    private static HashPassword getEncrypter() {
        return new HashPassword();
    }

    @Override
    public boolean registerUser(User user) throws SQLException, NoSuchAlgorithmException {
        String sql = "INSERT INTO user (ut_id, user_name, contact_no, email, address, password) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, user.getUtId());
            statement.setString(2, user.getUserName());
            statement.setString(3, user.getContactNo());
            statement.setString(4, user.getEmail());
            statement.setString(5, user.getAddress());
            statement.setString(6, getEncrypter().hashPassword(user.getPassword()));

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    @Override
    public boolean getUserByEmail(String email) throws SQLException {
        String sql = "SELECT COUNT(*) AS user_count FROM user WHERE email = ?";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt("user_count");
                    return count > 0;
                }
            }
        }

        return false;
    }
}
