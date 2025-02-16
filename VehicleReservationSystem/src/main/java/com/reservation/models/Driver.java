package com.reservation.models;

public class Driver {
    private String driverName;
    private String driverPhone;
    private String driverEmail;
    private String licenseNumber;
    private String licensePlate;
    private String status;

    public Driver() {}

    public Driver(String driverName, String driverPhone, String driverEmail, String licenseNumber, String licensePlate, String status) {
        this.driverName = driverName;
        this.driverPhone = driverPhone;
        this.driverEmail = driverEmail;
        this.licenseNumber = licenseNumber;
        this.licensePlate = licensePlate;
        this.status = status;
    }

    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }

    public String getDriverPhone() { return driverPhone; }
    public void setDriverPhone(String driverPhone) { this.driverPhone = driverPhone; }

    public String getDriverEmail() { return driverEmail; }
    public void setDriverEmail(String driverEmail) { this.driverEmail = driverEmail; }

    public String getLicenseNumber() { return licenseNumber; }
    public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }

    public String getLicensePlate() { return licensePlate; }
    public void setLicensePlate(String licensePlate) { this.licensePlate = licensePlate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
