<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.reservation.models.Driver" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Drivers</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Background Image */
        body {
            background-image: url('https://tse1.mm.bing.net/th?id=OIP.et4KU1CBW50TD_DDwO6r5wHaE6&pid=Api&P=0&h=220');
            background-size: cover;
            background-position: center;
            color: white;
            font-family: 'Arial', sans-serif;
            overflow-x: hidden;
        }

        /* Styling for table and container */
        .container {
            margin-top: 80px;
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            font-size: 36px;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.2);
            margin-bottom: 30px;
        }

        /* Table Styling */
        table {
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent background */
            border-radius: 8px;
            overflow: hidden;
            animation: slideIn 1s ease-out;
        }

        th, td {
            text-align: left;
            vertical-align: middle;
        }

        th {
            background-color: #f2f2f2;
            color: #2c3e50;
        }

        tr {
            transition: transform 0.3s ease-in-out;
        }

        tr:hover {
            transform: scale(1.05);
            background-color: #ecf0f1;
        }

        /* Button Styling */
        .btn-danger {
            background-color: #e74c3c;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        .btn-secondary {
            background-color: #34495e;
            border: none;
            transition: background-color 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #2c3e50;
        }

        /* Animation Effects */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes slideIn {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>List of Drivers</h1>
        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>Driver Name</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>License Number</th>
                    <th>License Plate</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="driver" items="${requestScope.drivers}">
                    <tr>
                        <td>${driver.driverName}</td>
                        <td>${driver.driverPhone}</td>
                        <td>${driver.driverEmail}</td>
                        <td>${driver.licenseNumber}</td>
                        <td>${driver.licensePlate}</td>
                        <td>${driver.status}</td>
                        <td>
                            <form action="DeleteDriverServlet" method="post">
                                <input type="hidden" name="licenseNumber" value="${driver.licenseNumber}">
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <br>
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>

    <!-- Bootstrap JS (Optional) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
