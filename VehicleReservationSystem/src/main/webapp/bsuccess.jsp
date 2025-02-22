<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            text-align: center;
            padding: 20px;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
            text-align: left;
        }
        h1 {
            color: green;
        }
        .info {
            margin-bottom: 10px;
        }
        .highlight {
            font-weight: bold;
            color: #007bff;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Booking Successful!</h1>
        <p class="info"><strong>Order Number:</strong> <span class="highlight">${param.orderNumber}</span></p>
        <p class="info"><strong>Customer Name:</strong> ${param.name}</p>
        <p class="info"><strong>Pickup Location:</strong> ${param.pickupLocation}</p>
        <p class="info"><strong>Destination:</strong> ${param.destination}</p>
        <p class="info"><strong>Vehicle Type:</strong> ${param.vehicleType}</p>
        <p class="info"><strong>Date of Booking:</strong> ${param.date}</p>
        <p class="info"><strong>Time of Booking:</strong> ${param.time}</p>
        
        <h2>Fare Details</h2>
        <p class="info"><strong>Fare:</strong> ${param.fare}</p>
        <p class="info"><strong>Tax:</strong> ${param.tax}</p>
        <p class="info"><strong>Total Fare:</strong> <span class="highlight">${param.totalFare}</span></p>
        
        <h2>Payment Details</h2>
        <p class="info"><strong>Payment Method:</strong> <span class="highlight">${param.paymentMethod}</span></p>

        <h2>Driver and Vehicle Details</h2>
        <p class="info"><strong>Car Model:</strong> ${param.carModel}</p>
        <p class="info"><strong>Car License Plate:</strong> ${param.carLicensePlate}</p>
        <p class="info"><strong>Driver Name:</strong> ${param.driverName}</p>
        <p class="info"><strong>Driver Phone:</strong> ${param.driverPhone}</p>

        <br>
        <a href="index.jsp">Go Back to Home</a>
         <!-- Print Bill Option -->
    <h3>Print Your Bill</h3>
    <form action="PrintBillServlet" method="get">
        <label for="orderNumber">Enter your Booking Order Number:</label>
        <input type="text" name="orderNumber" required><br>
        <button type="submit">Print Bill</button>
    </form>
    </div>

</body>
</html>
