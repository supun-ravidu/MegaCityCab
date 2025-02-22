<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mega City Cab - Vehicle Reservation System</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styling -->
    <style>
        /* Full-screen video background */
        .video-background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }

        /* Ensure text is overlaid on the video */
        .overlay {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: white;
        }

        /* Main heading animation */
        h1 {
            font-size: 4em;
            font-family: 'Arial', sans-serif;
            text-transform: uppercase;
            font-weight: bold;
            animation: fadeInUp 1.5s ease-out;
        }

        /* Subheading animation */
        h3 {
            font-size: 1.5em;
            margin-top: 20px;
            animation: fadeInUp 2s ease-out;
        }

        /* Button styling and animation */
        .btn {
            font-size: 1.2em;
            padding: 15px 30px;
            margin-top: 30px;
            border-radius: 50px;
            transition: transform 0.3s ease;
            opacity: 0;
            animation: fadeInUp 2.5s ease-out forwards;
        }

        .btn:hover {
            transform: scale(1.1);
            background-color: #ff6600;
        }

        /* Floating effect for User Guide Button */
        .btn-floating {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #17a2b8;
            color: white;
            padding: 15px 25px;
            border-radius: 50px;
            font-size: 1.2em;
            text-decoration: none;
            box-shadow: 0px 5px 15px rgba(0, 255, 255, 0.5);
            transition: all 0.3s ease-in-out;
            animation: floatEffect 3s infinite ease-in-out;
        }

        .btn-floating:hover {
            background-color: #138496;
            box-shadow: 0px 8px 20px rgba(0, 255, 255, 0.8);
            transform: scale(1.1);
        }

        /* Floating animation */
        @keyframes floatEffect {
            0% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-8px);
            }
            100% {
                transform: translateY(0px);
            }
        }

        /* Fade-in animation */
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

        /* Slide-in animation for buttons */
        .btn-container {
            animation: slideIn 3s ease-out forwards;
        }

        @keyframes slideIn {
            0% {
                opacity: 0;
                transform: translateX(100px);
            }
            100% {
                opacity: 1;
                transform: translateX(0);
            }
        }
    </style>
</head>

<body>
    <!-- Video Background -->
    <video autoplay muted loop class="video-background">
        <source src="https://www.desktophut.com/files/1655487100-1655487100-free-video-stock-taxi-lane-in-the-city-live-wallpaper.mp4" type="video/mp4">
    </video>

    <!-- Content Overlay -->
    <div class="overlay">
        <!-- Title -->
        <h1>Welcome to Mega City Cab</h1>

        <!-- Subtitle -->
        <h3>Your Reliable Taxi Service in the City</h3>

        <!-- Buttons Container with Animation -->
        <div class="btn-container">
            <!-- Login Button -->
            <a href="login.jsp">
                <button class="btn btn-primary">Login</button>
            </a>

            <!-- Sign-Up Button -->
            <a href="signup.jsp">
                <button class="btn btn-warning">Sign Up</button>
            </a>
        </div>
    </div>

    <!-- Floating User Guide Button -->
    <a href="userguide.jsp" class="btn-floating"> User Guide</a>

    <!-- Bootstrap JS & jQuery (optional for other Bootstrap features) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
