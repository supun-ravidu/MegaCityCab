<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Successful</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles and Animations -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-image: url('https://cbcny.org/sites/default/files/media/hero/Yellow_Cabs_in_New_York.JPG');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            color: white;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            animation: fadeIn 1.5s ease-out;
        }

        h2 {
            font-size: 2.5rem;
            color: #ffdf00;
            font-weight: bold;
            animation: slideIn 1s ease-out;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            color: #ffdf00;
            font-size: 1.2rem;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        a:hover {
            color: #ff6600;
        }

        /* Keyframe animations */
        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(-30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideIn {
            0% {
                opacity: 0;
                transform: translateY(50px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>

<body>

    <div class="container">
        <h2>Registration Successful!</h2>
        <a href="index.jsp" class="btn btn-outline-light">Go Back to Home</a>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>

</html>
