<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Boolean darkMode = (Boolean) session.getAttribute("darkMode");
    if (darkMode == null) {
        darkMode = false;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: <%= darkMode ? "#121212" : "#f4f4f4" %>;
            color: <%= darkMode ? "#ffffff" : "#000000" %>;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background-color: <%= darkMode ? "#1e1e1e" : "#2c3e50" %>;
            padding-top: 30px;
            box-shadow: 4px 0px 10px rgba(0, 0, 0, 0.2);
        }

        .sidebar a {
            color: white;
            padding: 15px 20px;
            text-decoration: none;
            font-size: 1.2rem;
            display: block;
            transition: background-color 0.3s ease;
        }

        .sidebar a:hover {
            background-color: <%= darkMode ? "#444" : "#2980b9" %>;
            border-radius: 5px;
        }

        .main-content {
            margin-left: 260px;
            padding: 20px;
            overflow: auto;
        }

        .notification-card {
            background-color: <%= darkMode ? "#1e1e1e" : "rgba(255, 255, 255, 0.9)" %>;
            color: <%= darkMode ? "#ffffff" : "#000000" %>;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }
    </style>
</head>
<body>

<!-- Sidebar Navigation -->
    <div class="sidebar">
        <a href="user.jsp" class="active">Dashboard</a>
        <a href="manageBooking.jsp">Manage Bookings</a>
        <a href="profile.jsp">Manage Profile</a>
        <a href="Settings.jsp">Settings</a>
            <a href="printBill.jsp">Print Bill</a> <!-- Added Print Bill Option -->
            <a href="notification.jsp" class="active">Notifications</a>
                <a href="logout.jsp">Logout</a> <!-- Added Logout Option -->
                    <a href="contact.jsp">Contact Us</a> <!-- Added Contact Us Option -->
                
            
        
    </div>

    <div class="main-content">
        <h2>Notifications</h2>
        <div class="notification-card">
            <h5>No Currently Available Messages</h5>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
