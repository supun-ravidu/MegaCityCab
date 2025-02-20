<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%
    ResultSet booking = (ResultSet) request.getAttribute("booking");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        /* Background Styling */
        body {
            background: url('https://source.unsplash.com/1600x900/?car,travel') no-repeat center center fixed;
            background-size: cover;
            color: white;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            transition: background 0.5s ease-in-out;
        }

        /* Glassmorphism Effect */
        .container-glass {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 30px;
            max-width: 600px;
            margin: auto;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            text-align: center;
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 30px;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
        }

        .btn {
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease-in-out, transform 0.3s ease;
        }

        .btn-secondary {
            background-color: #007bff;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #0056b3;
            transform: translateY(-3px);
        }

        /* Dark Mode */
        .dark-mode {
            background: #222 !important;
            color: white !important;
        }

        .dark-mode .container-glass {
            background: rgba(0, 0, 0, 0.3) !important;
        }

        .dark-mode .btn-secondary {
            background-color: #3498db !important;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container-glass {
                width: 90%;
            }

            h1 {
                font-size: 1.6rem;
            }
        }
    </style>
</head>
<body>

    <!-- Dark Mode Toggle -->
    <div class="container text-center mt-4">
        <button class="btn btn-warning" onclick="toggleDarkMode()">
            <i class="bi bi-moon-fill"></i> Toggle Dark Mode
        </button>
    </div>

    <div class="container-glass mt-4">
        <h1><i class="bi bi-file-earmark-check"></i> Booking Details</h1>

        <% if (booking != null) { %>
            <p><strong>Order Number:</strong> <%= booking.getString("order_number") %></p>
            <p><strong>Customer Name:</strong> <%= booking.getString("customer_name") %></p>
            <p><strong>Pickup Location:</strong> <%= booking.getString("pickup_location") %></p>
            <p><strong>Destination:</strong> <%= booking.getString("destination") %></p>
            <p><strong>Date:</strong> <%= booking.getString("booking_date") %></p>
            <p><strong>Time:</strong> <%= booking.getString("booking_time") %></p>
            <p><strong>Total Fare:</strong> <%= booking.getString("total_fare") %> LKR</p>
        <% } else { %>
            <p class="text-danger">No booking found.</p>
        <% } %>

        <a href="manageBooking.jsp" class="btn btn-secondary"><i class="bi bi-arrow-left-circle"></i> Back to Management</a>
    </div>

    <!-- JavaScript for Dark Mode -->
    <script>
        function toggleDarkMode() {
            document.body.classList.toggle("dark-mode");
            localStorage.setItem("darkMode", document.body.classList.contains("dark-mode") ? "enabled" : "disabled");
        }

        if (localStorage.getItem("darkMode") === "enabled") {
            document.body.classList.add("dark-mode");
        }
    </script>

    <!-- Bootstrap JS & Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
