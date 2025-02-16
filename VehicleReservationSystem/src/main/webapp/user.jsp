<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5KCajCLx1vcTwv72qIUmy7LbrB4e6HJ0&libraries=places"></script>

    <style>
        /* Global Styles */
        body {
            background-color: #f4f4f4;
            font-family: 'Arial', sans-serif;
            padding-top: 50px;
            color: black;
            overflow-x: hidden;
        }

        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background-color: #2c3e50;
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
            background-color: #2980b9;
            border-radius: 5px;
        }

        /* Main Content */
        .main-content {
            margin-left: 260px;
            padding: 20px;
            overflow: auto;
        }

        .card {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .card-title {
            font-size: 1.8rem;
            color: #333;
        }

        .card-body {
            font-size: 1.1rem;
        }

        .btn-custom {
            background-color: #3498db;
            color: white;
            padding: 12px 20px;
            font-size: 1.1rem;
            border-radius: 5px;
            text-align: center;
            transition: background-color 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #2980b9;
        }

        .btn-warning {
            background-color: #f39c12;
        }

        .btn-warning:hover {
            background-color: #e67e22;
        }

        /* Map Container */
        #map {
            height: 400px;
            width: 100%;
            margin-top: 20px;
        }

        /* Profile Image Styling */
        .profile-img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: bold;
            margin-right: 20px;
            text-transform: uppercase;
            border: 3px solid #fff;
        }

        /* Profile Info Section */
        .profile-info {
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body>

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <a href="#" class="active">Dashboard</a>
        <a href="#">Manage Bookings</a>
        <a href="#">Manage Profile</a>
        <a href="#">Notifications</a>
        <a href="#">Settings</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">

        <!-- Dashboard Header -->
        <h1>Welcome to Your Dashboard, <%= session.getAttribute("userName") %></h1>
        <p>You are logged in successfully!</p>

        <!-- Profile Card -->
        <div class="card">
            <div class="profile-info">
                <!-- Random Color Profile Image -->
                <div class="profile-img" id="profileImage">
                    <%= session.getAttribute("userName").toString().charAt(0) %> <!-- Use the first letter of user's name -->
                </div>
                <div>
                    <h2 class="card-title">Your Profile</h2>
                    <p><strong>Name:</strong> <%= session.getAttribute("userName") %></p>
                    <p><strong>Email:</strong> <%= session.getAttribute("userEmail") %></p>
                    <p><strong>Phone:</strong> <%= session.getAttribute("userPhone") %></p>
                </div>
            </div>
        </div>

        <!-- Manage Bookings Card -->
        <div class="card">
            <h3 class="card-title">Manage Your Bookings</h3>
            <p>Click below to manage your bookings:</p>
            <a href="ViewBookingsServlet" class="btn btn-custom">View Bookings</a><br>
            <a href="newBooking.jsp" class="btn btn-custom mt-2">Create New Booking</a>
        </div>

        <!-- Map with Car Locations -->
        <div id="map"></div>

        <!-- Log Out Card -->
        <div class="card">
            <h3 class="card-title">Log Out</h3>
            <a href="logout.jsp" class="btn btn-danger">Log Out</a>
        </div>

    </div>

    <!-- Floating Action Button -->
    <div class="floating-btn">
        <i class="fas fa-plus"></i>
    </div>

    <!-- Initialize Google Maps -->
    <script>
        function initMap() {
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 12,
                center: {lat: 6.9271, lng: 79.8612}, // Colombo, Sri Lanka coordinates
            });

            var marker = new google.maps.Marker({
                position: {lat: 6.9271, lng: 79.8612}, // Place car markers here if needed
                map: map,
                title: 'Taxi Car',
            });
        }

        // Load Google Maps API
        google.maps.event.addDomListener(window, 'load', initMap);

        // JavaScript function to generate random color
        function getRandomColor() {
            const letters = '0123456789ABCDEF';
            let color = '#';
            for (let i = 0; i < 6; i++) {
                color += letters[Math.floor(Math.random() * 16)];
            }
            return color;
        }

        // Set the random color for the profile image
        document.getElementById('profileImage').style.backgroundColor = getRandomColor();
    </script>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
