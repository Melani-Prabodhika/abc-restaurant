package com.abc.res.dao;

import com.abc.res.model.QueryModel;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.List;

public interface QueryDao {

    // Method to add a new query
    boolean addQuery(QueryModel queryModel, HttpServletRequest req) throws SQLException, ClassNotFoundException;

    // Method to fetch all queries
    List<QueryModel> getAllQueries() throws SQLException, ClassNotFoundException;

    // Method to update the status of a query
    boolean updateQueryStatus(int queryId, String status) throws SQLException, ClassNotFoundException;
}


