<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.reservation.utils.DBConnection" %>

<%
    String email = (String) session.getAttribute("userEmail");
    if (email == null) {
        response.sendRedirect("login.jsp"); // Redirect if not logged in
        return;
    }

    String name = "";
    String phone = "";
    String address = "";
    String nic = "";

    try (Connection con = DBConnection.getConnection()) {
        String sql = "SELECT name, phone, address, nic FROM Customers WHERE email=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            phone = rs.getString("phone");
            address = rs.getString("address");
            nic = rs.getString("nic");
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
    <title>Manage Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <h2 class="text-center">Manage Your Profile</h2>

    <%-- Show Success or Error Message --%>
    <% String message = (String) request.getAttribute("message"); %>
    <% if (message != null) { %>
        <div class="alert alert-success text-center">
            <%= message %>
        </div>
    <% } %>

    <form action="ProfileServlet" method="post">
        <div class="mb-3">
            <label>Name:</label>
            <input type="text" name="name" class="form-control" value="<%= name %>" required>
        </div>

        <div class="mb-3">
            <label>Phone:</label>
            <input type="text" name="phone" class="form-control" value="<%= phone %>" required>
        </div>

        <div class="mb-3">
            <label>Address:</label>
            <input type="text" name="address" class="form-control" value="<%= address %>" required>
        </div>

        <div class="mb-3">
            <label>NIC:</label>
            <input type="text" name="nic" class="form-control" value="<%= nic %>" required>
        </div>

        <div class="mb-3">
            <label>Email (Read-Only):</label>
            <input type="email" name="email" class="form-control" value="<%= email %>" readonly>
        </div>

        <button type="submit" class="btn btn-primary">Update Profile</button>
    </form>
    <br>
    <a href="user.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
