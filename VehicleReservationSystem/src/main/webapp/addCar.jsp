<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Car</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Background Image */
        body {
            background-image: url('https://wallpapercave.com/wp/wp1898209.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            font-family: 'Arial', sans-serif;
            padding-top: 100px;
            padding-bottom: 100px;
            animation: fadeIn 2s ease-out;
        }

        /* Title Styling */
        h1 {
            text-align: center;
            color: #333; /* Dark text for contrast */
            font-size: 3rem;
            margin-bottom: 30px;
            background-color: white; /* White background for title */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            animation: fadeInUp 1.5s ease-out;
        }

        /* Form Styling */
        .form-container {
            background-color: rgba(0, 0, 0, 0.7); /* Semi-transparent black background */
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

        .form-container input,
        .form-container select {
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
    <h1>Add Car Details</h1>

    <!-- Form Container -->
    <div class="form-container">
        <form action="AddCarServlet" method="post">
            <div class="mb-3">
                <label for="carModel" class="form-label">Car Model:</label>
                <input type="text" class="form-control" name="carModel" required>
            </div>

            <div class="mb-3">
                <label for="carType" class="form-label">Car Type:</label>
                <input type="text" class="form-control" name="carType">
            </div>

            <div class="mb-3">
                <label for="licensePlate" class="form-label">License Plate:</label>
                <input type="text" class="form-control" name="licensePlate" required>
            </div>

            <div class="mb-3">
                <label for="year" class="form-label">Year:</label>
                <input type="number" class="form-control" name="year" required>
            </div>

            <div class="mb-3">
                <label for="status" class="form-label">Status:</label>
                <select class="form-select" name="status">
                    <option value="Available">Available</option>
                    <option value="Unavailable">Unavailable</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Add Car</button>
        </form>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
