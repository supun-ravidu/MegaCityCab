package com.reservation.models;

public class Car {
    private String carModel;
    private String carType;
    private String licensePlate;
    private int year;
    private String status;

    public Car() {}

    public Car(String carModel, String carType, String licensePlate, int year, String status) {
        this.carModel = carModel;
        this.carType = carType;
        this.licensePlate = licensePlate;
        this.year = year;
        this.status = status;
    }

    public String getCarModel() { return carModel; }
    public void setCarModel(String carModel) { this.carModel = carModel; }

    public String getCarType() { return carType; }
    public void setCarType(String carType) { this.carType = carType; }

    public String getLicensePlate() { return licensePlate; }
    public void setLicensePlate(String licensePlate) { this.licensePlate = licensePlate; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
