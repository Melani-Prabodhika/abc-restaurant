package com.abc.res.dao;

import com.abc.res.model.ReservationModel;
import com.abc.res.model.User;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.List;

public interface UserDao {

    public List<User> getAllCustomers() throws SQLException, ClassNotFoundException;

    public List<User> getAllStaff(int branch_id) throws SQLException, ClassNotFoundException;

}
