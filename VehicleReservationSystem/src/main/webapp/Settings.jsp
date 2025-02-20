<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.reservation.utils.DBConnection" %>

<%
    String email = (String) session.getAttribute("userEmail");
    if (email == null) {
        response.sendRedirect("login.jsp"); // Redirect if not logged in
        return;
    }

    // Default settings (should be loaded from DB in real implementation)
    boolean darkMode = false;
    boolean notificationsEnabled = true;
    String vehiclePreference = "Car";
    String pickupLocation = "City Center";

    try (Connection con = DBConnection.getConnection()) {
        String sql = "SELECT dark_mode, notifications, vehicle_preference, pickup_location FROM UserSettings WHERE email=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            darkMode = rs.getBoolean("dark_mode");
            notificationsEnabled = rs.getBoolean("notifications");
            vehiclePreference = rs.getString("vehicle_preference");
            pickupLocation = rs.getString("pickup_location");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: <%= darkMode ? "#121212" : "#f8f9fa" %>;
            color: <%= darkMode ? "#ffffff" : "#000000" %>;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .card {
            background-color: <%= darkMode ? "#1e1e1e" : "#ffffff" %>;
            border: none;
            color: <%= darkMode ? "#ffffff" : "#000000" %>;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center">Settings</h2>

    <%-- Success message after saving settings --%>
    <% String message = (String) request.getAttribute("message"); %>
    <% if (message != null) { %>
        <div class="alert alert-success text-center">
            <%= message %>
        </div>
    <% } %>

    <form action="SettingsServlet" method="post">
        <!-- Dark Mode Toggle -->
        <div class="card p-3 mb-3">
            <h5>Appearance</h5>
            <label class="form-check-label">
                <input type="checkbox" name="darkMode" class="form-check-input" <%= darkMode ? "checked" : "" %>> Enable Dark Mode
            </label>
        </div>

        <!-- Notification Settings -->
        <div class="card p-3 mb-3">
            <h5>Notifications</h5>
            <label class="form-check-label">
                <input type="checkbox" name="notifications" class="form-check-input" <%= notificationsEnabled ? "checked" : "" %>> Enable Notifications
            </label>
        </div>

        <!-- Default Vehicle Preference -->
        <div class="card p-3 mb-3">
            <h5>Vehicle Preferences</h5>
            <label for="vehicle">Preferred Vehicle Type:</label>
            <select name="vehicle" id="vehicle" class="form-select">
                <option value="Car" <%= vehiclePreference.equals("Car") ? "selected" : "" %>>Car</option>
                <option value="SUV" <%= vehiclePreference.equals("SUV") ? "selected" : "" %>>SUV</option>
                <option value="Van" <%= vehiclePreference.equals("Van") ? "selected" : "" %>>Van</option>
                <option value="Bike" <%= vehiclePreference.equals("Bike") ? "selected" : "" %>>Bike</option>
            </select>
        </div>

        <!-- Preferred Pickup Location -->
        <div class="card p-3 mb-3">
            <h5>Pickup Location</h5>
            <input type="text" name="pickupLocation" class="form-control" value="<%= pickupLocation %>" required>
        </div>

        <button type="submit" class="btn btn-primary">Save Settings</button>
        <a href="user.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
