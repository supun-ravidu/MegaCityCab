<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>

    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        /* Background Styling */
        body {
            background: url('https://source.unsplash.com/1600x900/?technology,city') no-repeat center center fixed;
            background-size: cover;
            color: white;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            transition: background 0.5s ease-in-out;
        }

        /* Glassmorphism Card Style */
        .dashboard-container {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 40px;
            width: 85%;
            margin: auto;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1s ease-in-out;
        }

        /* Card Styling */
        .dashboard-card {
            background: rgba(255, 255, 255, 0.15);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        }

        /* Title Styling */
        h1 {
            text-align: center;
            font-size: 3rem;
            font-weight: bold;
            margin-bottom: 30px;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
        }

        /* Icon Styling */
        .dashboard-icon {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        /* Button Style */
        .dashboard-btn {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 15px;
            border-radius: 5px;
            background: #ffdf00;
            color: black;
            font-weight: bold;
            text-decoration: none;
            transition: background 0.3s ease-in-out;
        }

        .dashboard-btn:hover {
            background: #e6c300;
            text-decoration: none;
        }

        /* Dark Mode Toggle */
        .dark-mode {
            background: #222 !important;
            color: #fff !important;
        }

        .dark-mode .dashboard-card {
            background: rgba(0, 0, 0, 0.3) !important;
        }

        .dark-mode .dashboard-btn {
            background: #ff5733 !important;
            color: white !important;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .dashboard-container {
                width: 95%;
            }
        }
    </style>
</head>
<body>

    <div class="container text-center mt-4">
        <button class="btn btn-warning" onclick="toggleDarkMode()">
            <i class="bi bi-moon-fill"></i> Toggle Dark Mode
        </button>
    </div>

    <div class="dashboard-container mt-4">
        <h1>🚀 Admin Dashboard</h1>

        <div class="row">
            <!-- Manage Cars & Drivers -->
            <div class="col-md-4">
                <div class="dashboard-card">
                    <i class="bi bi-car-front dashboard-icon"></i>
                    <h3>Manage Cars & Drivers</h3>
                    <a href="addCar.jsp" class="dashboard-btn">Add Car</a>
                    <a href="addDriver.jsp" class="dashboard-btn">Add Driver</a>
                </div>
            </div>

            <!-- Manage Users -->
            <div class="col-md-4">
                <div class="dashboard-card">
                    <i class="bi bi-people dashboard-icon"></i>
                    <h3>Manage Users</h3>
                    <a href="viewUsers.jsp" class="dashboard-btn">View Users</a>
                </div>
            </div>

            <!-- Manage Bookings -->
            <div class="col-md-4">
                <div class="dashboard-card">
                    <i class="bi bi-calendar-check dashboard-icon"></i>
                    <h3>Manage Bookings</h3>
                    <a href="ViewBookingsServlet" class="dashboard-btn">View Bookings</a>
                </div>
            </div>

            <!-- Manage Cars -->
            <div class="col-md-4">
                <div class="dashboard-card">
                    <i class="bi bi-truck dashboard-icon"></i>
                    <h3>Manage Cars</h3>
                    <a href="addCar.jsp" class="dashboard-btn">Add Car</a>
                    <a href="ViewCarsServlet" class="dashboard-btn">View Cars</a>
                </div>
            </div>

            <!-- Manage Drivers -->
            <div class="col-md-4">
                <div class="dashboard-card">
                    <i class="bi bi-person-badge dashboard-icon"></i>
                    <h3>Manage Drivers</h3>
                    <a href="addDriver.jsp" class="dashboard-btn">Add Driver</a>
                    <a href="ViewDriversServlet" class="dashboard-btn">View Drivers</a>
                </div>
            </div>

            <!-- View Messages -->
            <div class="col-md-4">
                <div class="dashboard-card">
                    <i class="bi bi-chat-dots dashboard-icon"></i>
                    <h3>View Messages</h3>
                    <a href="admin_messages.jsp" class="dashboard-btn">View Messages</a>
                </div>
            </div>

            <!-- Logout -->
            <div class="col-md-4 mx-auto">
                <div class="dashboard-card">
                    <i class="bi bi-box-arrow-right dashboard-icon"></i>
                    <h3>Log Out</h3>
                    <a href="logout.jsp" class="dashboard-btn">Log Out</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

    <!-- Dark Mode Toggle -->
    <script>
        function toggleDarkMode() {
            document.body.classList.toggle("dark-mode");
            localStorage.setItem("darkMode", document.body.classList.contains("dark-mode") ? "enabled" : "disabled");
        }

        // Load Dark Mode Preference
        if (localStorage.getItem("darkMode") === "enabled") {
            document.body.classList.add("dark-mode");
        }
    </script>

</body>
</html>
