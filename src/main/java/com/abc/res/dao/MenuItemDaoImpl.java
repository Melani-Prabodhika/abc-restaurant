package com.abc.res.dao;

import com.abc.res.model.MenuItemModel;
import com.abc.res.utils.database.DBConnectionFactory;

import java.math.BigDecimal;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuItemDaoImpl implements MenuItemDao {

    private Connection getDbConnection() throws ClassNotFoundException, SQLException {
        return new DBConnectionFactory().getConnection();
    }

    @Override
    public List<MenuItemModel>  getAllMenuItems() throws SQLException, ClassNotFoundException, NoSuchAlgorithmException {

        List<MenuItemModel> menuItems = new ArrayList<>();
        Connection con = getDbConnection();
        String sql = "SELECT * FROM menu_item";

        PreparedStatement statement = con.prepareStatement(sql);
        ResultSet rs = statement.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("mi_id");
            String item_name = rs.getString("item_name");
            String item_description = rs.getString("item_desc");
            BigDecimal price = rs.getBigDecimal("price");
            String item_type = rs.getString("item_type");
            menuItems.add(new MenuItemModel(id, item_name, item_description, price, item_type));
        }

        rs.close();
        statement.close();
        con.close();

        return menuItems;
    }
}