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
                    // Set attributes for use in JSP
                    request.setAttribute("orderNumber", rs.getString("order_number"));
                    request.setAttribute("name", rs.getString("customer_name"));
                    request.setAttribute("pickupLocation", rs.getString("pickup_location"));
                    request.setAttribute("destination", rs.getString("destination"));
                    request.setAttribute("vehicleType", rs.getString("vehicle_type"));
                    request.setAttribute("date", rs.getString("booking_date"));
                    request.setAttribute("time", rs.getString("booking_time"));
                    request.setAttribute("fare", rs.getDouble("fare"));
                    request.setAttribute("tax", rs.getDouble("tax"));
                    request.setAttribute("totalFare", rs.getDouble("total_fare"));
                    request.setAttribute("paymentMethod", rs.getString("payment_method"));
                    request.setAttribute("carModel", rs.getString("car_model"));
                    request.setAttribute("carLicensePlate", rs.getString("car_license_plate"));
                    request.setAttribute("driverName", rs.getString("driver_name"));
                    request.setAttribute("driverPhone", rs.getString("driver_phone"));

                    request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "No booking found with this Order Number.");
                    request.getRequestDispatcher("manageBooking.jsp").forward(request, response);
                }
            } else if ("cancel".equals(action)) {
                // Cancel Booking - Delete the booking from the database
                String deleteSql = "DELETE FROM Bookings WHERE order_number = ?";
                PreparedStatement deletePs = con.prepareStatement(deleteSql);
                deletePs.setString(1, orderNumber);
                int rowsDeleted = deletePs.executeUpdate();

                if (rowsDeleted > 0) {
                    request.setAttribute("successMessage", "Booking has been successfully canceled.");
                } else {
                    request.setAttribute("errorMessage", "Failed to cancel the booking. Please check the Order Number.");
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
