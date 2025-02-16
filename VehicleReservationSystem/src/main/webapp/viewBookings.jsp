<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bookings List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Background Image */
        body {
            background-image: url('https://images5.alphacoders.com/958/958461.jpg'); /* Use a taxi car image */
            background-size: cover;
            background-position: center;
            font-family: 'Arial', sans-serif;
            color: white;
            padding: 20px;
            animation: fadeIn 1.5s ease-out;
        }

        h1 {
            text-align: center;
            color: #ffdf00; /* Yellow color to stand out */
            font-size: 3rem;
            margin-bottom: 30px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5); /* Shadow effect */
            animation: fadeInUp 1.5s ease-out;
        }

        table {
            width: 100%;
            margin-top: 30px;
            background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent background */
            border-radius: 10px;
            padding: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            color: white;
        }

        th {
            background-color: #ff5733; /* Orange background for table headers */
            color: white;
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .delete-btn {
            color: #e74c3c;
            text-decoration: none;
            font-weight: bold;
        }

        .delete-btn:hover {
            color: #c0392b;
            text-decoration: underline;
        }

        /* Animations */
        @keyframes fadeIn {
            0% {
                opacity: 0;
            }
            100% {
                opacity: 1;
            }
        }

        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Hover Effect for Table Rows */
        tr {
            transition: background-color 0.3s ease;
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: scale(1.02);
            transition: transform 0.3s ease;
        }
        
    </style>
</head>
<body>

    <h1>Bookings List</h1>

    <div class="container">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Order Number</th>
                    <th>Customer Name</th>
                    <th>Address</th>
                    <th>Phone</th>
                    <th>Destination</th>
                    <th>Fare</th>
                    <th>Booking Date</th>
                    <th>Pickup Location</th>
                    <th>Vehicle Type</th>
                    <th>Tax</th>
                    <th>Total Fare</th>
                    <th>Booking Time</th>
                    <th>Car Model</th>
                    <th>License Plate</th>
                    <th>Driver Name</th>
                    <th>Driver Phone</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ResultSet rs = (ResultSet) request.getAttribute("bookings");
                    try {
                        while (rs != null && rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("booking_id") %></td>
                    <td><%= rs.getString("order_number") %></td>
                    <td><%= rs.getString("customer_name") %></td>
                    <td><%= rs.getString("address") %></td>
                    <td><%= rs.getString("phone") %></td>
                    <td><%= rs.getString("destination") %></td>
                    <td><%= rs.getDouble("fare") %></td>
                    <td><%= rs.getString("booking_date") %></td>
                    <td><%= rs.getString("pickup_location") %></td>
                    <td><%= rs.getString("vehicle_type") %></td>
                    <td><%= rs.getDouble("tax") %></td>
                    <td><%= rs.getDouble("total_fare") %></td>
                    <td><%= rs.getString("booking_time") %></td>
                    <td><%= rs.getString("car_model") %></td>
                    <td><%= rs.getString("license_plate") %></td>
                    <td><%= rs.getString("driver_name") %></td>
                    <td><%= rs.getString("driver_phone") %></td>
                    <td>
                        <a href="DeleteBookingServlet?bookingId=<%= rs.getInt("booking_id") %>" class="delete-btn" onclick="return confirm('Are you sure you want to delete this booking?');">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("Error retrieving data: " + e.getMessage());
                    } finally {
                        if (rs != null) {
                            try {
                                rs.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
    
</body>
</html>
