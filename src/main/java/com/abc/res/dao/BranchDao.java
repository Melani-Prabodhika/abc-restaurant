package com.abc.res.dao;

import com.abc.res.model.BranchModel;
import com.abc.res.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BranchDao {

    public List<BranchModel> getAllBranches() {
        List<BranchModel> branches = new ArrayList<>();
        try (Connection connection = DBConnectionFactory.getConnection()) {
            String sql = "SELECT branch_id, branch_name FROM branch WHERE status = \"act\";";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                BranchModel branch = new BranchModel();
                branch.setBranchId(resultSet.getInt("branch_id"));
                branch.setBranchName(resultSet.getString("branch_name"));
                branches.add(branch);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return branches;
    }
}

