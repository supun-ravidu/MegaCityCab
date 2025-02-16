<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Full Background Image */
        body {
            background-image: url('https://www.urlaubsguru.de/wp-content/uploads/2017/01/Fernglas-auf-Ellis-Island-deutete-auf-Manhattans-Skyline-an-einem-bew%C3%B6lkten-Tag-iStock-518657226.jpg');
            background-size: cover;
            background-position: center;
            color: black;
            font-family: 'Arial', sans-serif;
            padding-top: 100px;
            padding-bottom: 100px;
            animation: fadeIn 1.5s ease-out;
        }

        /* Title Styling */
        h1 {
            text-align: center;
            color: #ffdf00;
            font-size: 3rem;
            margin-bottom: 30px;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
            animation: fadeInUp 1.5s ease-out;
        }

        h3 {
            color: #333;
            font-size: 1.8rem;
            margin-bottom: 15px;
            animation: fadeInUp 1.8s ease-out;
        }

        p {
            font-size: 1.2rem;
            color: #333;
            animation: fadeInUp 2s ease-out;
        }

        a {
            color: #007bff;
            text-decoration: none;
            font-size: 1.2rem;
            transition: color 0.3s ease, transform 0.3s ease;
        }

        a:hover {
            color: #0056b3;
            text-decoration: underline;
            transform: scale(1.05);
        }

        /* Card Styling for Sections */
        .dashboard-container {
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 15px;
            padding: 40px;
            width: 75%;
            margin: 0 auto;
            animation: fadeInUp 2s ease-out;
        }

        .dashboard-card {
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        /* Slide-In Animation for Menu Items */
        .menu-item {
            opacity: 0;
            transform: translateX(-50px);
            animation: slideIn 0.8s ease-out forwards;
        }

        .menu-item:nth-child(odd) {
            animation-delay: 0.2s;
        }

        .menu-item:nth-child(even) {
            animation-delay: 0.4s;
        }

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

        @keyframes slideIn {
            0% {
                opacity: 0;
                transform: translateX(-50px);
            }
            100% {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Responsive Styling for Smaller Screens */
        @media (max-width: 768px) {
            .dashboard-container {
                width: 90%;
            }

            h1 {
                font-size: 2.5rem;
            }

            h3 {
                font-size: 1.5rem;
            }

            p, a {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>

    <div class="dashboard-container">
        <!-- Title -->
        <h1>Welcome, Admin!</h1>
        <p>You are logged in as an admin.</p>

        <!-- Manage Cars and Drivers Section -->
        <div class="dashboard-card menu-item">
            <h3>Manage Cars and Drivers</h3>
            <p><a href="addCar.jsp">Add Car</a></p>
            <p><a href="addDriver.jsp">Add Driver</a></p>
        </div>

        <!-- Manage Users Section -->
        <div class="dashboard-card menu-item">
            <h3>Manage Users</h3>
            <p><a href="viewUsers.jsp">View Users</a></p>
        </div>

        <!-- Manage Bookings Section -->
        <div class="dashboard-card menu-item">
            <h3>Manage Bookings</h3>
            <p><a href="ViewBookingsServlet">View Bookings</a></p>
        </div>

        <!-- Manage Cars Section -->
        <div class="dashboard-card menu-item">
            <h3>Manage Cars</h3>
            <p><a href="addCar.jsp">Add Car</a></p>
            <p><a href="ViewCarsServlet">View Cars</a></p>
        </div>

        <!-- Manage Drivers Section -->
        <div class="dashboard-card menu-item">
            <h3>Manage Drivers</h3>
            <p><a href="addDriver.jsp">Add Driver</a></p>
            <p><a href="ViewDriversServlet">View Drivers</a></p>
        </div>

        <!-- Log Out Section -->
        <div class="dashboard-card menu-item">
            <h3>Log Out</h3>
            <p><a href="logout.jsp">Log Out</a></p>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
