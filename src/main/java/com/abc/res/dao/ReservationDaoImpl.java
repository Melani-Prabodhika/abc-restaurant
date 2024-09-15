package com.abc.res.dao;

import com.abc.res.model.ReservationModel;
import com.abc.res.utils.database.DBConnectionFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class ReservationDaoImpl implements ReservationDao {

    private Connection getDbConnection() throws ClassNotFoundException, SQLException {
        return new DBConnectionFactory().getConnection();
    }

    @Override
    public boolean addReservation(ReservationModel reservationModel, HttpServletRequest req) throws SQLException, ClassNotFoundException {
        Connection con = getDbConnection();
        HttpSession session = req.getSession();
        int user_id = (int) session.getAttribute("user_id");

        String query = "INSERT INTO `reservation`(`cus_name`, `cus_email`, `cus_contact`, `date`, `time`, `count`, `message`, `type`, `branch_id`, `user_id`) VALUES (?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement statement = con.prepareStatement(query);

        statement.setString(1, reservationModel.getName());
        statement.setString(2, reservationModel.getEmail());
        statement.setString(3, reservationModel.getContactNumber());
        statement.setDate(4, java.sql.Date.valueOf(reservationModel.getReservationDate()));
        statement.setTime(5, java.sql.Time.valueOf(reservationModel.getReservationTime()));
        statement.setInt(6, reservationModel.getNumberOfPeople());
        statement.setString(7, reservationModel.getMessage());
        statement.setString(8, reservationModel.getReservationType());
        statement.setInt(9, reservationModel.getBranchId());
        statement.setInt(10, user_id);

        int rowsInserted = statement.executeUpdate();
        statement.close();
        con.close();

        return rowsInserted > 0;
    }

    @Override
    public List<ReservationModel> getAllReservations(int branchId) throws SQLException, ClassNotFoundException {
        List<ReservationModel> reservations = new ArrayList<>();
        Connection con = getDbConnection();
        String sql = "SELECT * FROM reservations WHERE branch_id = ?";

        try (PreparedStatement statement = con.prepareStatement(sql)) {
            statement.setInt(1, branchId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("res_id");
                    String customerName = rs.getString("cus_name");
                    String customerEmail = rs.getString("cus_email");
                    String customerPhone = rs.getString("cus_contact");
                    LocalDate reservationDate = rs.getDate("date").toLocalDate();
                    LocalTime reservationTime = rs.getTime("time").toLocalTime();
                    int numberOfPeople = rs.getInt("count");
                    String specialRequest = rs.getString("message");
                    String reservationType = rs.getString("type");
                    String status = rs.getString("status");
                    LocalDate createdAt = rs.getDate("c_date").toLocalDate();
                    String branchName = rs.getString("branch_name"); // If you have it, otherwise use a placeholder

                    // Ensure branchName is available; otherwise, use a placeholder
                    branchName = (branchName != null) ? branchName : "Unknown";

                    reservations.add(new ReservationModel(id, customerName, customerPhone, customerEmail, reservationDate,
                            reservationTime, numberOfPeople, reservationType, branchId, specialRequest, createdAt, branchName));
                }
            }
        } finally {
            con.close();
        }

        return reservations;
    }

    @Override
    public boolean updateReservationStatus(int reservationId, String status) throws SQLException, ClassNotFoundException {
        Connection con = getDbConnection();
        String sql = "UPDATE reservations SET status = ? WHERE res_id = ?";
        PreparedStatement statement = con.prepareStatement(sql);

        try {
            statement.setString(1, status);
            statement.setInt(2, reservationId);
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println("Error occurred while updating reservation status: " + e.getMessage());
            throw e;
        } finally {
            statement.close();
            con.close();
        }
    }
}
