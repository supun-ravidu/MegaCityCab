<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Guide - Mega City Cab</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom Styling -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-image: url('https://w0.peakpx.com/wallpaper/692/958/HD-wallpaper-taxi-rank-cab-rank-taxi-car.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            color: #fff; /* Ensure readability */
        }

        .guide-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 30px;
            background: rgba(255, 255, 255, 0.9); /* Slight transparency for readability */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            color: #333;
        }

        h1 {
            text-align: center;
            font-size: 2.5em;
            color: #ff6600;
        }

        .section {
            background: #fff3e0;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }

        .section:hover {
            transform: scale(1.02);
        }

        .section-title {
            font-size: 1.5em;
            font-weight: bold;
            color: #333;
            display: flex;
            align-items: center;
            cursor: pointer;
        }

        .section-title i {
            margin-right: 10px;
            color: #ff6600;
        }

        .section-content {
            display: none;
            padding-top: 10px;
            font-size: 1.1em;
        }

        .toggle-btn {
            font-size: 1.2em;
            color: #007bff;
            cursor: pointer;
            text-align: center;
            display: block;
            margin-top: 10px;
        }

        .back-btn {
            display: block;
            text-align: center;
            margin-top: 20px;
        }

        .back-btn a {
            text-decoration: none;
            font-size: 1.2em;
            color: white;
            background: #ff6600;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .back-btn a:hover {
            background: #e55d00;
        }

    </style>
</head>
<body>

    <div class="guide-container">
        <h1>🚖 Welcome to Mega City Cab! 🚖</h1>
        <p class="text-center"><strong>Your journey begins here! Follow this guide for a smooth experience. Buckle up! 🏁</strong></p>

        <!-- Booking a Ride -->
        <div class="section">
            <div class="section-title" onclick="toggleSection('booking')">
                <i class="fas fa-taxi"></i> 🎉 Booking a Ride - Hassle-Free!
            </div>
            <div class="section-content" id="booking">
                <ul>
                    <li>📝 <strong>Enter your details</strong> – Name, pickup location, destination.</li>
                    <li>🚗 <strong>Choose your ride</strong> – Standard or Luxury?</li>
                    <li>🕒 <strong>Select a time</strong> – Schedule your pickup.</li>
                    <li>💰 <strong>Review Fare</strong> – Instant estimate with tax.</li>
                    <li>💳 <strong>Choose Payment</strong> – Cash or Card?</li>
                    <li>🎯 <strong>Confirm & Ride</strong> – Done! Your booking is successful!</li>
                    <li>✨ <strong>Pro Tip:</strong> Unsure of the fare? Just select a destination and vehicle type to calculate the cost!</li>
                </ul>
            </div>
        </div>

        <!-- Managing Your Booking -->
        <div class="section">
            <div class="section-title" onclick="toggleSection('manageBooking')">
                <i class="fas fa-calendar-check"></i> 🔍 Managing Your Booking – Plans Change!
            </div>
            <div class="section-content" id="manageBooking">
                <ul>
                    <li>🧐 <strong>Check your ride</strong> – Enter your order number.</li>
                    <li>❌ <strong>Cancel a ride</strong> – Use the "Cancel Booking" button.</li>
                    <li>🧾 <strong>Print your receipt</strong> – Enter booking number and print.</li>
                    <li>⚡ <strong>Quick Hack:</strong> Save your booking details after confirmation!</li>
                </ul>
            </div>
        </div>

        <!-- Profile Management -->
        <div class="section">
            <div class="section-title" onclick="toggleSection('profile')">
                <i class="fas fa-user"></i> 🔐 Your Profile – Personalize Your Experience!
            </div>
            <div class="section-content" id="profile">
                <ul>
                    <li>🆔 <strong>Update your info</strong> – Name, phone, address.</li>
                    <li>🚙 <strong>Vehicle Preferences</strong> – Choose your go-to ride.</li>
                    <li>🌙 <strong>Dark Mode</strong> – Toggle sleek dark mode.</li>
                    <li>🔔 <strong>Stay Notified</strong> – Enable booking updates.</li>
                    <li>🎁 <strong>Bonus Tip:</strong> Your profile icon color changes randomly!</li>
                </ul>
            </div>
        </div>

        <!-- Dashboard Features -->
        <div class="section">
            <div class="section-title" onclick="toggleSection('dashboard')">
                <i class="fas fa-map"></i> 🌎 Your Dashboard – Your Ride HQ!
            </div>
            <div class="section-content" id="dashboard">
                <ul>
                    <li>🚀 <strong>Quick Access</strong> – View bookings, print bills, adjust settings.</li>
                    <li>🗺️ <strong>Live Map Feature</strong> – See location & car routes.</li>
                    <li>🔑 <strong>One-Click Logout</strong> – Log out safely.</li>
                    <li>🎨 <strong>Pro Ride Hack:</strong> Profile icon color changes randomly!</li>
                </ul>
            </div>
        </div>

        <!-- Troubleshooting -->
        <div class="section">
            <div class="section-title" onclick="toggleSection('troubleshooting')">
                <i class="fas fa-tools"></i> ❌ Registration & Login Issues? No Worries!
            </div>
            <div class="section-content" id="troubleshooting">
                <ul>
                    <li>😟 <strong>Registration Failed?</strong> Double-check details.</li>
                    <li>🔑 <strong>Login Problems?</strong> Reset your password.</li>
                    <li>📞 <strong>Need Help?</strong> Contact support!</li>
                    <li>🔒 <strong>Stay Secure:</strong> Email is read-only for safety.</li>
                </ul>
            </div>
        </div>

        <p class="text-center"><strong>🚖 And That’s It! Now, you're all set to enjoy smooth, reliable rides with Mega City Cab. 🌟</strong></p>

        <!-- Back Button -->
        <div class="back-btn">
            <a href="index.jsp">⬅️ Back to Home</a>
        </div>
    </div>

    <script>
        function toggleSection(id) {
            var content = document.getElementById(id);
            content.style.display = content.style.display === "block" ? "none" : "block";
        }
    </script>

</body>
</html>
