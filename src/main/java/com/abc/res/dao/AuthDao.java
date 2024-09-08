package com.abc.res.dao;

import com.abc.res.model.LoginModel;
import com.abc.res.model.User;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

public interface AuthDao {
    public boolean registerUser(User user) throws SQLException, NoSuchAlgorithmException;

    public boolean getUserByEmail(String email) throws SQLException;

    public User loginUser(LoginModel loginModel) throws SQLException, ClassNotFoundException, NoSuchAlgorithmException;
}
