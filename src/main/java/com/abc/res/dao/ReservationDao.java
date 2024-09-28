package com.abc.res.dao;

import com.abc.res.model.ReservationModel;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.List;

public interface ReservationDao {
    public boolean addReservation(ReservationModel reservationModel, HttpServletRequest req) throws SQLException, ClassNotFoundException;

    public List<ReservationModel> getReservationByUserId(int userId) throws SQLException, ClassNotFoundException;

    public List<ReservationModel> getPendingReservations(int branch_id) throws SQLException, ClassNotFoundException;

    public List<ReservationModel> getConfirmReservations(int branch_id) throws SQLException, ClassNotFoundException;

    public List<ReservationModel> getRejectReservations(int branch_id) throws SQLException, ClassNotFoundException;

    public List<ReservationModel> getAllReservations(int branch_id) throws SQLException, ClassNotFoundException;

    public boolean updateReservationStatus(int i, String status) throws SQLException, ClassNotFoundException;
}

