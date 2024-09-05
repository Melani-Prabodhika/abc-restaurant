package com.abc.res.utils.database;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnectionFactory {
    public static Connection getConnection() throws SQLException {
        return DBConnection.getInstance().getConnection();
    }

    public static void closeConnection() {
        DBConnection.getInstance().closeConnection();
    }

}
