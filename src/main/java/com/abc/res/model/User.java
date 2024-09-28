package com.abc.res.model;

import java.util.Date;

public class User {
    private int userId;
    private int utId;
    private String userName;
    private String contactNo;
    private String email;
    private String address;
    private String password;
    private String status;
    private int branchId;
    private Date regDate;

    // Constructor
    public User(int utId, String userName, String contactNo, String email,
                String address) {
        this.utId = utId;
        this.userName = userName;
        this.contactNo = contactNo;
        this.email = email;
        this.address = address;
    }

    public User() {

    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getUtId() {
        return utId;
    }

    public void setUtId(int utId) {
        this.utId = utId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", utId=" + utId +
                ", userName='" + userName + '\'' +
                ", contactNo='" + contactNo + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                ", status='" + status + '\'' +
                ", branchId=" + branchId +
                ", regDate=" + regDate +
                '}';
    }
}

