<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Your Booking</title>

    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        body {
            background: url('https://source.unsplash.com/1600x900/?technology,car') no-repeat center center fixed;
            background-size: cover;
            transition: background 0.5s ease-in-out;
        }

        .container-glass {
            background: rgba(255, 255, 255, 0.8);
            border-radius: 15px;
            padding: 30px;
            max-width: 700px;
            margin: auto;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            text-align: center;
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 30px;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
        }

        .btn-group {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease-in-out, transform 0.3s ease;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-danger {
            background-color: #e74c3c;
            color: white;
        }

        .btn:hover {
            transform: translateY(-3px);
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Dark Mode Styles */
        .dark-mode {
            background: #222 !important;
            color: white !important;
        }

        .dark-mode .container-glass {
            background: rgba(0, 0, 0, 0.7) !important;
        }

        .dark-mode .btn-primary {
            background-color: #3498db !important;
        }

        .dark-mode .btn-danger {
            background-color: #e74c3c !important;
        }

        @media (max-width: 768px) {
            .container-glass {
                width: 90%;
            }

            h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>

<body>

    <!-- Dark Mode Toggle Button -->
    <div class="container text-center mt-4">
        <button class="btn btn-warning" onclick="toggleDarkMode()">
            <i class="bi bi-moon-fill"></i> Toggle Dark Mode
        </button>
    </div>

    <div class="container-glass mt-4">
        <h1>Manage Your Booking</h1>

        <!-- Display Success Message -->
        <% if (request.getAttribute("successMessage") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("successMessage") %></div>
        <% } %>

        <!-- Display Error Message -->
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
        <% } %>

        <!-- Display Booking Details -->
        <% if (request.getAttribute("orderNumber") != null) { %>
        <h2 class="text-success">Booking Successful!</h2>
        <div class="list-group">
            <p class="list-group-item"><strong>Order Number:</strong> <%= request.getAttribute("orderNumber") %></p>
            <p class="list-group-item"><strong>Customer Name:</strong> <%= request.getAttribute("name") %></p>
            <p class="list-group-item"><strong>Pickup Location:</strong> <%= request.getAttribute("pickupLocation") %></p>
            <p class="list-group-item"><strong>Destination:</strong> <%= request.getAttribute("destination") %></p>
            <p class="list-group-item"><strong>Vehicle Type:</strong> <%= request.getAttribute("vehicleType") %></p>
            <p class="list-group-item"><strong>Date of Booking:</strong> <%= request.getAttribute("date") %></p>
            <p class="list-group-item"><strong>Time of Booking:</strong> <%= request.getAttribute("time") %></p>
        </div>

        <h3 class="mt-4">Fare Details</h3>
        <div class="list-group">
            <p class="list-group-item"><strong>Fare:</strong> <%= request.getAttribute("fare") %></p>
            <p class="list-group-item"><strong>Tax:</strong> <%= request.getAttribute("tax") %></p>
            <p class="list-group-item"><strong>Total Fare:</strong> <%= request.getAttribute("totalFare") %></p>
        </div>

        <h3 class="mt-4">Payment Details</h3>
        <p><strong>Payment Method:</strong> <%= request.getAttribute("paymentMethod") %></p>

        <h3 class="mt-4">Driver and Vehicle Details</h3>
        <div class="list-group">
            <p class="list-group-item"><strong>Car Model:</strong> <%= request.getAttribute("carModel") %></p>
            <p class="list-group-item"><strong>Car License Plate:</strong> <%= request.getAttribute("carLicensePlate") %></p>
            <p class="list-group-item"><strong>Driver Name:</strong> <%= request.getAttribute("driverName") %></p>
            <p class="list-group-item"><strong>Driver Phone:</strong> <%= request.getAttribute("driverPhone") %></p>
        </div>
        <% } %>

        <!-- Booking Management Form -->
        <form action="ManageBookingServlet" method="post" id="bookingForm" class="mt-4">
            <div class="form-group">
                <label for="orderNumber">Enter Order Number:</label>
                <input type="text" name="orderNumber" id="orderNumber" class="form-control" required>
            </div>

            <div class="btn-group">
                <button type="submit" name="action" value="view" class="btn btn-primary">
                    <i class="bi bi-eye"></i> View Booking
                </button>
                <button type="submit" name="action" value="cancel" class="btn btn-danger">
                    <i class="bi bi-x-circle"></i> Cancel Booking
                </button>
            </div>
        </form>
    </div>

    <!-- JavaScript for Dark Mode Toggle -->
    <script>
        function toggleDarkMode() {
            document.body.classList.toggle("dark-mode");
            localStorage.setItem("darkMode", document.body.classList.contains("dark-mode") ? "enabled" : "disabled");
        }

        // Check if Dark Mode was previously enabled
        if (localStorage.getItem("darkMode") === "enabled") {
            document.body.classList.add("dark-mode");
        }
    </script>

    <!-- Bootstrap JS & Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
