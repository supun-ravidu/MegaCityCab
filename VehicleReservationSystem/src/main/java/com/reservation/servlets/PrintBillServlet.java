package com.reservation.servlets;

import com.reservation.utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/PrintBillServlet")
public class PrintBillServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderNumber = request.getParameter("orderNumber");

        if (orderNumber == null || orderNumber.trim().isEmpty()) {
            response.sendRedirect("printBill.jsp?error=Order number is required");
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            // SQL query to fetch booking details
            String sql = "SELECT booking_id, order_number, customer_name, address, phone, destination, fare, booking_date, pickup_location, vehicle_type, tax, total_fare, booking_time, car_model, car_type, car_license_plate, driver_name, driver_phone "
                       + "FROM Bookings WHERE order_number = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, orderNumber);
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                response.sendRedirect("printBill.jsp?error=Booking not found");
                return;
            }

            // Fetch booking details
            String customerName = rs.getString("customer_name");
            String address = rs.getString("address");
            String phone = rs.getString("phone");
            String destination = rs.getString("destination");
            double fare = rs.getDouble("fare");
            double tax = rs.getDouble("tax");
            double totalFare = rs.getDouble("total_fare");
            String bookingDate = rs.getString("booking_date");
            String pickupLocation = rs.getString("pickup_location");
            String vehicleType = rs.getString("vehicle_type");
            String bookingTime = rs.getString("booking_time");

            // Fetch car and driver details
            String carModel = rs.getString("car_model");
            String carLicensePlate = rs.getString("car_license_plate");
            String driverName = rs.getString("driver_name");
            String driverPhone = rs.getString("driver_phone");

            // Create an image to print the bill
            int width = 600;
            int height = 500;
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = image.createGraphics();
            g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g.setColor(Color.WHITE);
            g.fillRect(0, 0, width, height);
            g.setColor(Color.BLACK);
            g.setFont(new Font("Arial", Font.BOLD, 16));

            // Print bill details
            g.drawString("Booking Bill", 200, 30);
            g.setFont(new Font("Arial", Font.PLAIN, 14));
            g.drawString("Order Number: " + orderNumber, 20, 60);
            g.drawString("Customer Name: " + customerName, 20, 90);
            g.drawString("Address: " + address, 20, 120);
            g.drawString("Phone: " + phone, 20, 150);
            g.drawString("Destination: " + destination, 20, 180);
            g.drawString("Fare: Rs. " + fare, 20, 210);
            g.drawString("Tax: Rs. " + tax, 20, 240);
            g.drawString("Total Fare: Rs. " + totalFare, 20, 270);
            g.drawString("Booking Date: " + bookingDate, 20, 300);
            g.drawString("Pickup Location: " + pickupLocation, 20, 330);
            g.drawString("Vehicle Type: " + vehicleType, 20, 360);
            g.drawString("Booking Time: " + bookingTime, 20, 390);

            // Print car details
            g.setFont(new Font("Arial", Font.PLAIN, 12));
            g.drawString("Car Model: " + carModel, 20, 420);
            g.drawString("Car License Plate: " + carLicensePlate, 20, 440);

            // Print driver details
            g.drawString("Driver Name: " + driverName, 20, 460);
            g.drawString("Driver Phone: " + driverPhone, 20, 480);

            // Cleanup
            g.dispose();

            // Set the response type to JPEG for image download
            response.setContentType("image/jpeg");
            response.setHeader("Content-Disposition", "attachment; filename=booking_bill_" + orderNumber + ".jpg");

            OutputStream out = response.getOutputStream();
            javax.imageio.ImageIO.write(image, "JPEG", out);
            out.flush();
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("printBill.jsp?error=Error generating bill");
        }
    }
}
