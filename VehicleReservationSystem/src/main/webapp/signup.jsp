<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign-Up</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styling & Animations -->
    <style>
        /* Full screen background image */
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Arial', sans-serif;
        }

        .bg {
            background-image: url('https://wallpapercave.com/wp/wp1898154.jpg');
            background-size: cover;
            background-position: center;
            height: 100%;
            position: absolute;
            width: 100%;
            top: 0;
            left: 0;
            z-index: -1;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding-top: 80px;
            position: relative;
            z-index: 1;
        }

        /* Form container */
        .form-container {
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.6);
            color: #fff;
            animation: fadeInUp 1s ease-out;
        }

        /* Heading Animation */
        h1 {
            text-align: center;
            font-size: 3em;
            color: #ffdf00;
            animation: fadeIn 1s ease-out;
        }

        /* Form Elements Animation */
        .form-group {
            margin-bottom: 20px;
            opacity: 0;
            animation: slideIn 1s forwards;
        }

        .form-group:nth-child(odd) {
            animation-delay: 0.5s;
        }

        .form-group:nth-child(even) {
            animation-delay: 0.7s;
        }

        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ddd;
            background-color: #fff;
            color: #333;
            font-size: 1em;
            transition: transform 0.3s ease-in-out;
        }

        input:focus {
            transform: scale(1.05);
            border-color: #ffdf00;
            outline: none;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #ffdf00;
            border: none;
            border-radius: 8px;
            font-size: 1.2em;
            cursor: pointer;
            transition: transform 0.3s ease-in-out;
            animation: scaleIn 1s ease-out;
        }

        button:hover {
            background-color: #ffcc00;
            transform: scale(1.05);
        }

        /* Keyframe Animations */
        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(-50px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(50px);
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

        @keyframes scaleIn {
            0% {
                opacity: 0;
                transform: scale(0.8);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }

    </style>
</head>

<body>
    <!-- Background image -->
    <div class="bg"></div>

    <!-- Main container for the form -->
    <div class="container">
        <div class="form-container">
            <h1>Create a New Account</h1>
            <form action="CustomerServlet" method="post">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" name="name" required>
                </div>

                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" name="address" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input type="text" name="phone" pattern="[0-9]+" required>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" name="email" required>
                </div>

                <div class="form-group">
                    <label for="nic">NIC:</label>
                    <input type="text" name="nic" required>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" name="password" required>
                </div>

                <button type="submit">Sign Up</button>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS & dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>

</html>
