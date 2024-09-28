package com.abc.res.dao;

import com.abc.res.model.QueryModel;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.List;

public interface QueryDao {

    boolean addQuery(QueryModel queryModel, HttpServletRequest req) throws SQLException, ClassNotFoundException;

    public List<QueryModel> getAllQueries() throws SQLException, ClassNotFoundException;

    boolean updateQueryStatus(int queryId, String status) throws SQLException, ClassNotFoundException;
}


