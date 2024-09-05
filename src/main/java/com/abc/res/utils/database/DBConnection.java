package com.abc.res.utils.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/abc_restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    private static DBConnection instance;
    private Connection connection;

    private DBConnection() {
        // The connection is not created in the constructor
    }

    public static DBConnection getInstance() {
        if (instance == null) {
            synchronized (DBConnection.class) {
                if (instance == null) {
                    instance = new DBConnection();
                }
            }
        }
        return instance;
    }

    public Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                connection.setAutoCommit(true);  // Ensure autocommit is on
            } catch (ClassNotFoundException e) {
                throw new SQLException("Database driver not found", e);
            }
        }
        return connection;
    }

    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
