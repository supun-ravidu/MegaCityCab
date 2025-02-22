<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.reservation.models.Car" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Cars</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Background Image */
        body {
            background-image: url('https://images.unsplash.com/photo-1556122071-e404eaedb77f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dGF4aXxlbnwwfHwwfHx8MA%3D%3D'); /* Replace with your desired image URL */
            background-size: cover;
            background-position: center;
            color: white;
            font-family: 'Arial', sans-serif;
            padding: 50px 20px;
            animation: fadeIn 1.5s ease-out;
        }

        h1 {
            text-align: center;
            color: #ffdf00;
            font-size: 3rem;
            margin-bottom: 30px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
            animation: fadeInUp 1.5s ease-out;
        }

        table {
            width: 100%;
            margin-top: 20px;
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
        }

        tr:hover {
            background-color: rgba(255, 255, 255, 0.2);
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-delete:hover {
            background-color: #c0392b;
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
    </style>
</head>
<body>

    <h1>List of Cars</h1>

    <div class="container">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Car Model</th>
                    <th>Car Type</th>
                    <th>License Plate</th>
                    <th>Year</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="car" items="${requestScope.cars}">
                    <tr>
                        <td>${car.carModel}</td>
                        <td>${car.carType}</td>
                        <td>${car.licensePlate}</td>
                        <td>${car.year}</td>
                        <td>${car.status}</td>
                        <td>
                            <form action="DeleteCarServlet" method="post" style="display:inline;">
                                <input type="hidden" name="licensePlate" value="${car.licensePlate}">
                                <button type="submit" class="btn-delete">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Back to Dashboard Button -->
    <div class="text-center mt-4">
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
