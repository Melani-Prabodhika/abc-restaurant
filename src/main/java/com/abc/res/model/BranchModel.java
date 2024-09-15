package com.abc.res.model;

public class BranchModel {
    private int branchId;
    private String branchName;
    private String address;
    private String contactNumber;

    // Default constructor
    public BranchModel() {
    }

    // Parameterized constructor
    public BranchModel(int branchId, String branchName, String address, String contactNumber) {
        this.branchId = branchId;
        this.branchName = branchName;
        this.address = address;
        this.contactNumber = contactNumber;
    }

    // Getters and Setters
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String location) {
        this.address = address;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    @Override
    public String toString() {
        return "Branch{" +
                "branchId=" + branchId +
                ", branchName='" + branchName + '\'' +
                ", address='" + address + '\'' +
                ", contactNumber='" + contactNumber + '\'' +
                '}';
    }
}
