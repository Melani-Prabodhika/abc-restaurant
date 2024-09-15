package com.abc.res.model;

import com.google.gson.annotations.SerializedName;
import java.util.Date;

public class QueryModel {

    @SerializedName("q_id")
    private int queryId;

    @SerializedName("cus_name")
    private String customerName;

    @SerializedName("cus_contact")
    private String customerContact;

    @SerializedName("cus_whatsapp")
    private String customerWhatsapp;

    @SerializedName("email")
    private String email;

    @SerializedName("subject")
    private String subject;

    @SerializedName("message")
    private String message;

    @SerializedName("status")
    private String status;

    @SerializedName("c_date")
    private Date createdDate;

    // Constructor
    public QueryModel(int queryId, String customerName, String customerContact,
                      String customerWhatsapp, String email, String subject,
                      String message, String status, Date createdDate) {
        this.queryId = queryId;
        this.customerName = customerName;
        this.customerContact = customerContact;
        this.customerWhatsapp = customerWhatsapp;
        this.email = email;
        this.subject = subject;
        this.message = message;
    }

    public QueryModel() {

    }

    // Getters and Setters
    public int getQueryId() {
        return queryId;
    }

    public void setQueryId(int queryId) {
        this.queryId = queryId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerContact() {
        return customerContact;
    }

    public void setCustomerContact(String customerContact) {
        this.customerContact = customerContact;
    }

    public String getCustomerWhatsapp() {
        return customerWhatsapp;
    }

    public void setCustomerWhatsapp(String customerWhatsapp) {
        this.customerWhatsapp = customerWhatsapp;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }
}
