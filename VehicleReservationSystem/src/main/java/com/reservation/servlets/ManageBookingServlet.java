package com.reservation.servlets;

import com.reservation.utils.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/ManageBookingServlet")
public class ManageBookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String orderNumber = request.getParameter("orderNumber");

        if (action == null || orderNumber == null || orderNumber.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Invalid request. Please enter a valid Order Number.");
            request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
            return;
        }

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            if ("view".equals(action)) {
                // View Booking Details
                String sql = "SELECT * FROM Bookings WHERE order_number = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, orderNumber);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    request.setAttribute("booking", rs);
                    request.getRequestDispatcher("viewBookingDetails.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "No booking found with this Order Number.");
                    request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
                }
            } else if ("update".equals(action)) {
                // Fetch parameters for update
                String pickupLocation = request.getParameter("pickupLocation");
                String destination = request.getParameter("destination");
                String date = request.getParameter("date");
                String time = request.getParameter("time");

                // Debugging statements
                System.out.println("Updating Booking for Order Number: " + orderNumber);
                System.out.println("Pickup Location: " + pickupLocation);
                System.out.println("Destination: " + destination);
                System.out.println("Date: " + date);
                System.out.println("Time: " + time);

                // Ensure required parameters are not null or empty
                if (pickupLocation == null || pickupLocation.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Pickup location cannot be empty.");
                    request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
                    return;
                }

                if (destination == null || destination.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Destination cannot be empty.");
                    request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
                    return;
                }

                if (date == null || date.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Date cannot be empty.");
                    request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
                    return;
                }

                if (time == null || time.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Time cannot be empty.");
                    request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
                    return;
                }

                // Update query
                String sql = "UPDATE Bookings SET pickup_location = ?, destination = ?, booking_date = ?, booking_time = ? WHERE order_number = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, pickupLocation);
                ps.setString(2, destination);
                ps.setString(3, date);
                ps.setString(4, time);
                ps.setString(5, orderNumber);

                int rowsUpdated = ps.executeUpdate();
                if (rowsUpdated > 0) {
                    request.setAttribute("successMessage", "Booking updated successfully!");
                } else {
                    request.setAttribute("errorMessage", "Failed to update booking. Please check your order number.");
                }
                request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
            } else if ("cancel".equals(action)) {
                // Cancel Booking
                String sql = "DELETE FROM Bookings WHERE order_number = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, orderNumber);

                int rowsDeleted = ps.executeUpdate();
                if (rowsDeleted > 0) {
                    request.setAttribute("successMessage", "Booking canceled successfully!");
                } else {
                    request.setAttribute("errorMessage", "Failed to cancel booking.");
                }
                request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Invalid action specified.");
                request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
