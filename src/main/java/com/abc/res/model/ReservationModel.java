package com.abc.res.model;

import com.google.gson.annotations.SerializedName;
import java.time.LocalDate;
import java.time.LocalTime;

public class ReservationModel {

    @SerializedName("res_id")
    private int reservationId;

    @SerializedName("user_name")
    private String name;

    @SerializedName("user_email")
    private String customerEmail;

    @SerializedName("phone")
    private String customerPhone;

    @SerializedName("reservation_date")
    private LocalDate reservationDate;

    @SerializedName("reservation_time")
    private LocalTime reservationTime;

    @SerializedName("number_of_people")
    private int numberOfPeople;

    @SerializedName("message")
    private String message;

    @SerializedName("reservation_type")
    private String reservationType;

    @SerializedName("status")
    private String status;

    @SerializedName("created_at")
    private LocalDate createdAt;

    @SerializedName("branch_id")
    private int branchId;

    private String branchName;

    // Parameterized constructor
    public ReservationModel(int reservationId, String name, String contactNumber, String email, LocalDate reservationDate,
                            LocalTime reservationTime, int numberOfPeople, String reservationType,
                            int branchId, String message, LocalDate createdAt, String branchName) {

        this.reservationId = reservationId;
        this.name = name;
        this.customerPhone = contactNumber;
        this.customerEmail = email;
        this.reservationDate = reservationDate;
        this.reservationTime = reservationTime;
        this.numberOfPeople = numberOfPeople;
        this.reservationType = reservationType;
        this.branchId = branchId;
        this.branchName = branchName;
        this.message = message;
        this.createdAt = createdAt;
    }

    public ReservationModel() {

    }


    // Getters and Setters
    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return customerEmail;
    }

    public void setEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getContactNumber() {
        return customerPhone;
    }

    public void setContactNumber(String contactNumber) {
        this.customerPhone = contactNumber;
    }

    public LocalDate getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(LocalDate reservationDate) {
        this.reservationDate = reservationDate;
    }

    public LocalTime getReservationTime() {
        return reservationTime;
    }

    public void setReservationTime(LocalTime reservationTime) {
        this.reservationTime = reservationTime;
    }

    public int getNumberOfPeople() {
        return numberOfPeople;
    }

    public void setNumberOfPeople(int numberOfPeople) {
        this.numberOfPeople = numberOfPeople;
    }

    public String getReservationType() {
        return reservationType;
    }

    public void setReservationType(String reservationType) {
        this.reservationType = reservationType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "ReservationModel{" +
                "reservationId=" + reservationId +
                ", name='" + name + '\'' +
                ", customerEmail='" + customerEmail + '\'' +
                ", customerPhone='" + customerPhone + '\'' +
                ", reservationDate=" + reservationDate +
                ", reservationTime=" + reservationTime +
                ", numberOfPeople=" + numberOfPeople +
                ", reservationType='" + reservationType + '\'' +
                ", branchId=" + branchId +
                ", branchName='" + branchName + '\'' +
                ", message='" + message + '\'' +
                '}';
    }
}
