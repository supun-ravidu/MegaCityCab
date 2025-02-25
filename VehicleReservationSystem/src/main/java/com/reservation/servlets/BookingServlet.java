package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import com.reservation.models.Car;
import com.reservation.models.Driver;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String pickupLocation = request.getParameter("pickupLocation");
        String destination = request.getParameter("destination");
        String vehicleType = request.getParameter("vehicleType");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String paymentMethod = request.getParameter("paymentMethod"); // Retrieve payment method

        // Retrieve fare, tax, and total fare as strings and convert to double
        String fareString = request.getParameter("fare").replace(" LKR", "").trim();
        String taxString = request.getParameter("tax").replace(" LKR", "").trim();
        String totalFareString = request.getParameter("totalFare").replace(" LKR", "").trim();

        double fare = Double.parseDouble(fareString);
        double tax = Double.parseDouble(taxString);
        double totalFare = Double.parseDouble(totalFareString);

        // Generate Order Number automatically
        String orderNumber = "ORD" + System.currentTimeMillis();

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            // Fetch a random car
            String carSql = "SELECT * FROM Cars ORDER BY RAND() LIMIT 1";
            PreparedStatement carPs = con.prepareStatement(carSql);
            ResultSet carRs = carPs.executeQuery();
            Car selectedCar = null;
            if (carRs.next()) {
                selectedCar = new Car(
                        carRs.getString("car_model"),
                        carRs.getString("car_type"),
                        carRs.getString("license_plate"),
                        carRs.getInt("year"),
                        carRs.getString("status")
                );
            }

            // Fetch a random driver
            String driverSql = "SELECT * FROM Drivers ORDER BY RAND() LIMIT 1";
            PreparedStatement driverPs = con.prepareStatement(driverSql);
            ResultSet driverRs = driverPs.executeQuery();
            Driver selectedDriver = null;
            if (driverRs.next()) {
                selectedDriver = new Driver(
                        driverRs.getString("driver_name"),
                        driverRs.getString("phone"),
                        driverRs.getString("email"),
                        driverRs.getString("license_number"),
                        driverRs.getString("license_plate"),
                        driverRs.getString("status")
                );
            }

            // SQL query to insert booking details
            String sql = "INSERT INTO Bookings (order_number, customer_name, address, phone, pickup_location, destination, fare, booking_date, vehicle_type, tax, total_fare, booking_time, car_model, car_type, car_license_plate, driver_name, driver_phone, payment_method) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, orderNumber);
            ps.setString(2, name);
            ps.setString(3, address);
            ps.setString(4, phone);
            ps.setString(5, pickupLocation);
            ps.setString(6, destination);
            ps.setDouble(7, fare);
            ps.setString(8, date);
            ps.setString(9, vehicleType);
            ps.setDouble(10, tax);
            ps.setDouble(11, totalFare);
            ps.setString(12, time);
            ps.setString(13, selectedCar.getCarModel());
            ps.setString(14, selectedCar.getCarType());
            ps.setString(15, selectedCar.getLicensePlate());
            ps.setString(16, selectedDriver.getDriverName());
            ps.setString(17, selectedDriver.getDriverPhone());
            ps.setString(18, paymentMethod);  // Insert payment method

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                // Redirect to Booking Success page
                response.sendRedirect("bsuccess.jsp?orderNumber=" + orderNumber + 
                                      "&name=" + name + 
                                      "&destination=" + destination + 
                                      "&pickupLocation=" + pickupLocation + 
                                      "&vehicleType=" + vehicleType + 
                                      "&date=" + date + 
                                      "&time=" + time + 
                                      "&fare=" + fare + " LKR" + 
                                      "&tax=" + tax + " LKR" + 
                                      "&totalFare=" + totalFare + " LKR" + 
                                      "&carModel=" + selectedCar.getCarModel() + 
                                      "&carLicensePlate=" + selectedCar.getLicensePlate() + 
                                      "&driverName=" + selectedDriver.getDriverName() +
                                      "&driverPhone=" + selectedDriver.getDriverPhone() +
                                      "&paymentMethod=" + paymentMethod); // Pass payment method
            } else {
                request.setAttribute("errorMessage", "Error: Unable to process the booking.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}