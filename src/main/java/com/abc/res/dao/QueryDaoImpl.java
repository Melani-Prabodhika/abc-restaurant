package com.abc.res.dao;

import com.abc.res.model.QueryModel;
import com.abc.res.utils.database.DBConnectionFactory;

import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class QueryDaoImpl implements QueryDao {

    // Helper method to get a new database connection
    private Connection getDbConnection() throws ClassNotFoundException, SQLException {
        return new DBConnectionFactory().getConnection();
    }

    // Method to add a new query
    public boolean addQuery(QueryModel queryModel, HttpServletRequest req) throws SQLException, ClassNotFoundException {
        String query = "INSERT INTO query (cus_name, cus_contact, cus_whatsapp, email, subject, message) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = getDbConnection();
             PreparedStatement statement = con.prepareStatement(query)) {
            statement.setString(1, queryModel.getCustomerName());
            statement.setString(2, queryModel.getCustomerContact());
            statement.setString(3, queryModel.getCustomerWhatsapp());
            statement.setString(4, queryModel.getEmail());
            statement.setString(5, queryModel.getSubject());
            statement.setString(6, queryModel.getMessage());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        }
    }

    // Method to fetch all queries
    public List<QueryModel> getAllQueries() {
        List<QueryModel> queries = new ArrayList<>();
        String sql = "SELECT * FROM query";
        try (Connection con = getDbConnection();
             PreparedStatement statement = con.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {

            while (rs.next()) {
                QueryModel query = new QueryModel(
                        rs.getInt("q_id"),
                        rs.getString("cus_name"),
                        rs.getString("cus_contact"),
                        rs.getString("cus_whatsapp"),
                        rs.getString("email"),
                        rs.getString("subject"),
                        rs.getString("message"),
                        rs.getString("status"),
                        rs.getDate("c_date")
                );
                queries.add(query);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return queries;
    }

    // Method to get a query by ID
    public QueryModel getQueryById(int queryId) {
        String queryString = "SELECT * FROM query WHERE q_id = ?";
        try (Connection con = getDbConnection();
             PreparedStatement stmt = con.prepareStatement(queryString)) {
            stmt.setInt(1, queryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new QueryModel(
                            rs.getInt("q_id"),
                            rs.getString("cus_name"),
                            rs.getString("cus_contact"),
                            rs.getString("cus_whatsapp"),
                            rs.getString("email"),
                            rs.getString("subject"),
                            rs.getString("message"),
                            rs.getString("status"),
                            rs.getDate("c_date")
                    );
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Method to update a query status
    public boolean updateQueryStatus(int queryId, String newStatus) {
        String queryString = "UPDATE query SET status = ? WHERE q_id = ?";
        try (Connection con = getDbConnection();
             PreparedStatement stmt = con.prepareStatement(queryString)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, queryId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

}
