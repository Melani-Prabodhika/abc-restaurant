package com.abc.res.model;

import com.google.gson.annotations.SerializedName;

public class LoginModel {
    @SerializedName("email")
    String email;

    @SerializedName("password")
    String password;

    @SerializedName("status")
    String status;


    public void setEmail(String email) {
        this.email = email;
    }
    public String getEmail() {
        return email;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    public String getPassword() {
        return password;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    public String getStatus() {
        return status;
    }
}
