package com.abc.res.dao;

import com.abc.res.model.MenuItemModel;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

public interface MenuItemDao {

    public List<MenuItemModel> getAllMenuItems() throws SQLException, ClassNotFoundException, NoSuchAlgorithmException;

}