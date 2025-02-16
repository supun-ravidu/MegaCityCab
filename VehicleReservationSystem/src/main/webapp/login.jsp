<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>

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
            filter: blur(5px);
            z-index: -1;
        }

        .container {
            max-width: 500px;
            margin: 0 auto;
            padding-top: 80px;
            position: relative;
            z-index: 1;
        }

        /* Form container */
        .form-container {
            background-color: rgba(0, 0, 0, 0.6); /* Semi-transparent background */
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.6);
            color: #fff;
            animation: fadeInUp 1s ease-out;
        }

        /* Heading animation */
        h1 {
            text-align: center;
            color: #ffdf00;
            font-size: 3em;
            animation: fadeIn 1s ease-out;
        }

        /* Form input fields */
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

        /* Button animation */
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

        button:active {
            transform: scale(0.95);
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

    <!-- Background Image -->
    <div class="bg"></div>

    <!-- Main container for form -->
    <div class="container">
        <div class="form-container">
            <h1>Login</h1>

            <!-- Error message if exists -->
            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
                <p style="color:red; text-align: center;"><%= errorMessage %></p>
            <% } %>

            <!-- Login Form -->
            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" class="form-control" name="email" required>
                </div>

                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" class="form-control" name="password" required>
                </div>

                <button type="submit" class="btn btn-primary">Login</button>
            </form>

            <!-- Sign Up link -->
            <p style="text-align: center;">Don't have an account? <a href="signup.jsp" style="color: #ffdf00;">Sign Up</a></p>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>

</html>
