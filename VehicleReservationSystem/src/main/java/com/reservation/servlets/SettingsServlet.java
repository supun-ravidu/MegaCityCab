package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SettingsServlet")
public class SettingsServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");  

        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve settings from the form
        boolean darkMode = request.getParameter("darkMode") != null;
        boolean notificationsEnabled = request.getParameter("notifications") != null;
        String vehiclePreference = request.getParameter("vehicle");
        String pickupLocation = request.getParameter("pickupLocation");

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            // Check if the user already has settings stored
            String checkSql = "SELECT * FROM UserSettings WHERE email=?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, email);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // Update existing settings
                String updateSql = "UPDATE UserSettings SET dark_mode=?, notifications=?, vehicle_preference=?, pickup_location=? WHERE email=?";
                PreparedStatement updatePs = con.prepareStatement(updateSql);
                updatePs.setBoolean(1, darkMode);
                updatePs.setBoolean(2, notificationsEnabled);
                updatePs.setString(3, vehiclePreference);
                updatePs.setString(4, pickupLocation);
                updatePs.setString(5, email);

                updatePs.executeUpdate();
            } else {
                // Insert new settings
                String insertSql = "INSERT INTO UserSettings (email, dark_mode, notifications, vehicle_preference, pickup_location) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement insertPs = con.prepareStatement(insertSql);
                insertPs.setString(1, email);
                insertPs.setBoolean(2, darkMode);
                insertPs.setBoolean(3, notificationsEnabled);
                insertPs.setString(4, vehiclePreference);
                insertPs.setString(5, pickupLocation);

                insertPs.executeUpdate();
            }

            // Store dark mode setting in session for real-time update across pages
            session.setAttribute("darkMode", darkMode);

            // Redirect back with success message
            request.setAttribute("message", "Settings updated successfully!");
            request.getRequestDispatcher("Settings.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Database error: " + e.getMessage());
            request.getRequestDispatcher("Settings.jsp").forward(request, response);
        }
    }
}
