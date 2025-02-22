<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Booking</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        /* Apply background image to the body */
        body {
            background-image: url('https://images.hdqwalls.com/download/taxi-digital-art-4k-yv-3840x2160.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            font-family: Arial, sans-serif;
            padding-top: 50px;
        }

        /* Form container with slight opacity for readability */
        .form-container {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
            max-width: 800px;
            margin: 0 auto;
        }

        /* Adjust label and input field colors */
        label {
            font-weight: bold;
        }

        .form-control, .btn {
            background-color: rgba(255, 255, 255, 0.8);
            color: #333;
        }

        .form-control:focus, .btn:focus {
            box-shadow: none;
            border-color: #3498db;
        }

        /* Input field margins */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .btn-custom {
            background-color: #3498db;
            color: white;
            font-size: 1.2rem;
            padding: 12px 20px;
            border-radius: 5px;
        }

        .btn-custom:hover {
            background-color: #2980b9;
        }

        .card-details {
            margin-top: 20px;
            padding: 15px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 5px;
        }

        .radio-btn-group input {
            margin-right: 15px;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="form-container">
            <h1 class="text-center mb-4">New Booking</h1>

            <form action="BookingServlet" method="post">
                <div class="form-group">
                    <label for="name">Customer Name:</label>
                    <input type="text" name="name" class="form-control" required><br>
                </div>

                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" name="address" class="form-control" required><br>
                </div>

                <div class="form-group">
                    <label for="phone">Telephone Number:</label>
                    <input type="text" name="phone" class="form-control" required><br>
                </div>

                <div class="form-group">
                    <label for="pickupLocation">Pickup Location:</label>
                    <input type="text" name="pickupLocation" class="form-control" required><br>
                </div>

                <div class="form-group">
                    <label for="destination">Destination:</label>
                    <select id="destination" name="destination" class="form-control" onchange="calculateFare()" required>
                        <option value="">Select Destination</option>
                        <option value="Galle Road">Galle Road</option>
                        <option value="Duplication Road">Duplication Road</option>
                        <option value="Marine Drive">Marine Drive</option>
                        <option value="Union Place">Union Place</option>
                        <option value="Bauddhaloka Mawatha">Bauddhaloka Mawatha</option>
                        <option value="Baseline Road">Baseline Road</option>
                        <option value="Havelock Road">Havelock Road</option>
                        <option value="Nawala Road">Nawala Road</option>
                    </select><br>
                </div>

                <div class="form-group">
                    <label for="vehicleType">Vehicle Type:</label>
                    <select id="vehicleType" name="vehicleType" class="form-control" onchange="calculateFare()" required>
                        <option value="">Select Vehicle Type</option>
                        <option value="Standard">Standard</option>
                        <option value="Luxury">Luxury</option>
                    </select><br>
                </div>

                <div class="form-group">
                    <label for="date">Date of Booking:</label>
                    <input type="date" name="date" class="form-control" required><br>
                </div>

                <div class="form-group">
                    <label for="time">Time of Booking:</label>
                    <input type="time" name="time" class="form-control" required><br>
                </div>

                <div class="form-group">
                    <label for="fare">Base Fare:</label>
                    <input type="text" id="fare" name="fare" class="form-control" readonly><br>
                </div>

                <div class="form-group">
                    <label for="tax">Tax (10%):</label>
                    <input type="text" id="tax" name="tax" class="form-control" readonly><br>
                </div>

                <div class="form-group">
                    <label for="totalFare">Total Fare (including tax):</label>
                    <input type="text" id="totalFare" name="totalFare" class="form-control" readonly><br>
                </div>

                <h3>Select Payment Method:</h3>
                <div class="radio-btn-group">
                    <input type="radio" name="paymentMethod" value="cash_on_ride" onclick="togglePaymentFields()" required> Cash on-Ride
                    <input type="radio" name="paymentMethod" value="debit_card" onclick="togglePaymentFields()"> Debit Card<br>
                </div>
                
                <br>
                <br>
             

                <div id="cardDetails" class="card-details" style="display:none;">
                    <h3>Debit Card Details</h3>
                    <label for="cardNumber">Card Number:</label>
                    <input type="text" name="cardNumber" class="form-control"><br>

                    <label for="cardHolder">Card Holder Name:</label>
                    <input type="text" name="cardHolder" class="form-control"><br>

                    <label for="expiryDate">Expiry Date:</label>
                    <input type="month" name="expiryDate" class="form-control"><br>

                    <label for="cvv">CVV:</label>
                    <input type="password" name="cvv" class="form-control"><br>
                </div>
                
                                <br>
                <br>

                <button type="submit" class="btn btn-custom">Submit Booking</button>
            </form>
        </div>
    </div>

    <script>
        // Function to calculate fare based on destination and vehicle type
        function calculateFare() {
            var destination = document.getElementById("destination").value;
            var vehicleType = document.getElementById("vehicleType").value;
            var fare = 0;

            // Set fare based on Colombo city streets
            var fareMap = {
                "Galle Road": 2000,
                "Duplication Road": 1800,
                "Marine Drive": 1900,
                "Union Place": 2100,
                "Bauddhaloka Mawatha": 2200,
                "Baseline Road": 1700,
                "Havelock Road": 2000,
                "Nawala Road": 1950
            };

            if (fareMap[destination]) {
                fare = fareMap[destination];
            } else {
                fare = 0; // Default if no destination selected
            }

            // Adjust fare based on vehicle type
            if (vehicleType === "Luxury") {
                fare += 1000; // Additional fare for luxury vehicles
            }

            // Add 10% tax to the fare
            var tax = fare * 0.10;
            var totalFare = fare + tax;

            // Display the fare, tax, and total fare
            document.getElementById("fare").value = fare + " LKR";
            document.getElementById("tax").value = tax.toFixed(2) + " LKR";
            document.getElementById("totalFare").value = totalFare.toFixed(2) + " LKR";
        }

        // Function to toggle debit card payment fields
        function togglePaymentFields() {
            var paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
            var cardDetails = document.getElementById("cardDetails");
            
            if (paymentMethod === "debit_card") {
                cardDetails.style.display = "block";
            } else {
                cardDetails.style.display = "none";
            }
        }
    </script>
</body>
</html>
