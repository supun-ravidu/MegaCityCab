<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Boolean darkMode = (Boolean) session.getAttribute("darkMode");
    if (darkMode == null) {
        darkMode = false; // Default to light mode if not set
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Cab Service</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5KCajCLx1vcTwv72qIUmy7LbrB4e6HJ0&libraries=places"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        /* Dark Mode Support */
        body {
            background-color: <%= darkMode ? "#121212" : "#f4f4f4" %>;
            color: <%= darkMode ? "#ffffff" : "#000000" %>;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background-color: <%= darkMode ? "#1e1e1e" : "#2c3e50" %>;
            padding-top: 30px;
            box-shadow: 4px 0px 10px rgba(0, 0, 0, 0.2);
            z-index: 100;
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

        /* Collapsible Sidebar */
        .sidebar .active {
            background-color: <%= darkMode ? "#444" : "#2980b9" %>;
        }

        /* Main Content */
        .main-content {
            margin-left: 260px;
            padding: 20px;
            overflow: auto;
            transition: margin-left 0.3s ease;
        }

        .card {
            background-color: <%= darkMode ? "#1e1e1e" : "rgba(255, 255, 255, 0.9)" %>;
            color: <%= darkMode ? "#ffffff" : "#000000" %>;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        /* Contact Form */
        .contact-form input, .contact-form textarea {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s ease;
        }

        .contact-form input:focus, .contact-form textarea:focus {
            border-color: #28a745;
        }

        .contact-form button {
            background: #28a745;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 1.2rem;
        }

        .contact-form button:hover {
            background: #218838;
        }

        /* Map Container */
        #map {
            height: 400px;
            width: 100%;
            margin-top: 20px;
            border-radius: 10px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
                padding-top: 15px;
            }

            .main-content {
                margin-left: 210px;
            }
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

    <!-- Main Content -->
    <div class="main-content">
        <h1>Contact Us</h1>
        <p>If you have any questions, feel free to reach out to us.</p>

        <div class="row">
            <!-- Company Information Card -->
            <div class="col-md-6">
                <div class="card">
                    <h3><i class="fas fa-building"></i> Company Information</h3>
                    <p><strong>Cab Service Name:</strong> Mega City Cab</p>
                    <p><strong>Email:</strong> support@quickride.com</p>
                    <p><strong>Phone:</strong> +1 234 567 890</p>
                    <p><strong>Address:</strong> 123 Main Street, Colombo</p>
                </div>
            </div>

            <!-- Contact Form Card -->
            <div class="col-md-6">
                <div class="card">
                    <h3><i class="fas fa-paper-plane"></i> Send Us a Message</h3>
                    <form class="contact-form" action="sendContact.jsp" method="post">
                        <input type="text" name="name" placeholder="Your Name" required>
                        <input type="email" name="email" placeholder="Your Email" required>
                        <textarea name="message" rows="5" placeholder="Your Message" required></textarea>
                        <button type="submit">Send Message</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Map with Company Location -->
        <div class="card">
            <h3><i class="fas fa-map-marker-alt"></i> Our Location</h3>
            <div id="map"></div>
        </div>
    </div>

    <!-- Initialize Google Maps -->
    <script>
        function initMap() {
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 12,
                center: {lat: 6.9271, lng: 79.8612}, // Example: Colombo, Sri Lanka
            });

            var marker = new google.maps.Marker({
                position: {lat: 6.9271, lng: 79.8612}, // Replace with actual company location
                map: map,
                title: 'Our Location',
            });
        }

        // Load Google Maps API
        google.maps.event.addDomListener(window, 'load', initMap);
    </script>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
