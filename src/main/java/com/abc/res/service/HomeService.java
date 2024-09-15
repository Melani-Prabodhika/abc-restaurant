package com.abc.res.service;

import com.abc.res.dao.QueryDao;
import com.abc.res.dao.QueryDaoImpl;
import com.abc.res.model.CommonMsgModel;
import com.abc.res.model.QueryModel;

import javax.servlet.http.HttpServletRequest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.regex.Pattern;

public class HomeService {

    private static HomeService homeService;

    private HomeService() {}

    public static synchronized HomeService getHomeService() {
        if (homeService == null) {
            homeService = new HomeService();
        }
        return homeService;
    }

    private QueryDao getQueryDao() {
        return new QueryDaoImpl();
    }

    public CommonMsgModel addQuery(QueryModel queryModel, HttpServletRequest req) throws SQLException, NoSuchAlgorithmException, ClassNotFoundException {
        // Patterns for validation
        Pattern emailPattern = Pattern.compile("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$");
        Pattern phonePattern = Pattern.compile("[^\\d+]");

        if (queryModel.getCustomerName().length() > 100 || queryModel.getCustomerName().isEmpty()) {
            return new CommonMsgModel("Invalid Customer Name", false, null);
        } else if (!emailPattern.matcher(queryModel.getEmail()).matches()) {
            return new CommonMsgModel("Invalid E-mail", false, null);
        } else if (queryModel.getCustomerContact().length() > 15 || queryModel.getCustomerContact().length() < 6 || phonePattern.matcher(queryModel.getCustomerContact()).find()) {
            return new CommonMsgModel("Invalid Phone Number", false, null);
        } else if (queryModel.getCustomerWhatsapp().length() > 15 || queryModel.getCustomerWhatsapp().length() < 6 || phonePattern.matcher(queryModel.getCustomerWhatsapp()).find()) {
            return new CommonMsgModel("Invalid Whatsapp Number", false, null);
        }else if(queryModel.getSubject().length() > 200) {
            return new CommonMsgModel("Invalid Subject!", false, null);
        }else if(queryModel.getMessage().length() > 500) {
            return new CommonMsgModel("Invalid Message!", false, null);
        } else {
            boolean isSuccess = getQueryDao().addQuery(queryModel, req);
            if (isSuccess) {
                return new CommonMsgModel("Your message was sent successfully! You will get a reply within 36 hours.", true, null);
            } else {
                return new CommonMsgModel("Failed to send message.", false, null);
            }
        }
    }
}

