<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="com.reservation.utils.DBConnection" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Users</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- FontAwesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <!-- Custom Styling and Animations -->
    <style>
        /* Hero Section */
        .hero-section {
            background-image: url('https://images.unsplash.com/photo-1490650404312-a2175773bbf5?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dGF4aXxlbnwwfHwwfHx8MA%3D%3D');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
        }

        .hero-content h1 {
            font-size: 4rem;
            font-weight: 700;
        }

        .table-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 30px;
        }

        .card {
            border: none;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .card-header {
            background-color: #007bff;
            color: white;
            font-size: 1.5rem;
            text-align: center;
            padding: 20px;
            border-radius: 10px 10px 0 0;
        }

        .card-body {
            background-color: #fff;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            color: #555;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: black;  /* Changed the text color to black */
            font-size: 1.1rem;
        }

        tr {
            background-color: #f9f9f9;
        }

        tr:nth-child(even) {
            background-color: #f1f1f1;
        }

        tr:hover {
            background-color: #e2e2e2;
        }

        .btn-dashboard {
            background-color: #28a745;
            color: white;
            padding: 12px 25px;
            font-size: 1.2rem;
            text-decoration: none;
            margin-top: 20px;
            display: inline-block;
            text-align: center;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-dashboard:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }

        .modal-header {
            background-color: #007bff;
            color: white;
        }

        .modal-body {
            background-color: #f9f9f9;
        }
    </style>
</head>

<body>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-content text-center">
            <h1>Customer Information</h1>
            <p>View the complete list of customers and their details below</p>
        </div>
    </div>

    <!-- Table Container -->
    <div class="table-container">
        <div class="card">
            <div class="card-header">
                <i class="fas fa-users"></i> Customer List
            </div>
            <div class="card-body">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Customer ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>NIC</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                ResultSet rs = (ResultSet) request.getAttribute("customerList");

                                if (rs == null) {
                                    Connection con = DBConnection.getConnection();
                                    String sql = "SELECT customer_id, name, email, phone, address, nic FROM Customers";
                                    PreparedStatement ps = con.prepareStatement(sql);
                                    rs = ps.executeQuery();
                                }

                                while (rs != null && rs.next()) {
                        %>
                                    <tr>
                                        <td><%= rs.getInt("customer_id") %></td>
                                        <td><%= rs.getString("name") %></td>
                                        <td><%= rs.getString("email") %></td>
                                        <td><%= rs.getString("phone") %></td>
                                        <td><%= rs.getString("address") %></td>
                                        <td><%= rs.getString("nic") %></td>
                                    </tr>
                        <%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Back to Admin Dashboard Button -->
    <a href="adminDashboard.jsp" class="btn-dashboard">
        <i class="fas fa-arrow-left"></i> Back to Admin Dashboard
    </a>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>

</html>
