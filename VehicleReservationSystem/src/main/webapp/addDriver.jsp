<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Driver</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Background Image */
        body {
            background-image: url('https://wallpapercave.com/wp/wp3097385.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            font-family: 'Arial', sans-serif;
            padding-top: 100px;
            padding-bottom: 100px;
            animation: fadeIn 2s ease-out;
        }

        /* Title Styling (in white box) */
        h1 {
            text-align: center;
            color: #333; /* Dark text for contrast */
            font-size: 3rem;
            margin-bottom: 30px;
            background-color: white; /* White background */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            animation: fadeInUp 1.5s ease-out;
        }

        /* Form Styling */
        .form-container {
            background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent black */
            border-radius: 10px;
            padding: 30px;
            width: 50%;
            margin: 0 auto;
            animation: fadeInUp 2s ease-out;
        }

        .form-container label {
            color: white;
            font-size: 1.2rem;
        }

        .form-container input {
            margin-bottom: 15px;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .form-container button {
            width: 100%;
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 1.2rem;
            transition: background-color 0.3s ease;
        }

        .form-container button:hover {
            background-color: #0056b3;
        }

        /* Animations */
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
    </style>
</head>
<body>

    <!-- Title in White Box -->
    <h1>Add Driver Details</h1>

    <!-- Form Container -->
    <div class="form-container">
        <form action="AddDriverServlet" method="post">
            <div class="mb-3">
                <label for="driverName" class="form-label">Driver Name:</label>
                <input type="text" class="form-control" name="driverName" required>
            </div>

            <div class="mb-3">
                <label for="driverPhone" class="form-label">Driver Phone:</label>
                <input type="text" class="form-control" name="driverPhone" required>
            </div>

            <div class="mb-3">
                <label for="driverEmail" class="form-label">Driver Email:</label>
                <input type="email" class="form-control" name="driverEmail" required>
            </div>

            <div class="mb-3">
                <label for="licenseNumber" class="form-label">Driver License Number:</label>
                <input type="text" class="form-control" name="licenseNumber" required>
            </div>

            <div class="mb-3">
                <label for="licensePlate" class="form-label">Car License Plate:</label>
                <input type="text" class="form-control" name="licensePlate" required>
            </div>

            <button type="submit" class="btn btn-primary">Add Driver</button>
        </form>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
