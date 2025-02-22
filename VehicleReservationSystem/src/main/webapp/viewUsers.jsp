<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="com.reservation.utils.DBConnection" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Users</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styling and Animations -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-image: url('https://wallpaperaccess.com/full/5824933.jpg');
            background-size: cover;
            background-position: center;
            padding: 50px;
            color: white;
            animation: fadeInBackground 1.5s ease-out;
        }

        h1 {
            text-align: center;
            color: #ffdf00;
            font-size: 3rem;
            margin-bottom: 30px;
            animation: fadeIn 1s ease-out;
        }

        .table-container {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
            border-radius: 10px;
            padding: 30px;
            animation: fadeInUp 1.5s ease-out;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            transition: all 0.3s ease;
        }

        th {
            background-color: #007bff;
            color: white;
            font-size: 1.1rem;
        }

        td {
            background-color: #f4f4f4;
            color: #333;
            font-size: 1rem;
        }

        tr:nth-child(even) {
            background-color: #e9ecef;
        }

        tr:hover {
            background-color: #ffdf00;
            color: #333;
            transform: scale(1.05);
            transition: transform 0.3s ease;
        }

        a {
            color: #ffdf00;
            text-decoration: none;
            font-size: 1.2rem;
            display: block;
            margin-top: 30px;
            text-align: center;
            transition: color 0.3s ease;
        }

        a:hover {
            text-decoration: underline;
            color: #e67e22;
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

        @keyframes fadeInBackground {
            0% {
                opacity: 0;
            }
            100% {
                opacity: 1;
            }
        }
        th {
    background-color: #007bff;
    color: black; /* Changed text color to black */
    font-size: 1.1rem;
}
        
    </style>
</head>

<body>

    <!-- Title -->
    <h1>Users List</h1>

    <!-- Table Container -->
    <div class="table-container">
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Customer ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection con = DBConnection.getConnection();  // Create connection
                        String sql = "SELECT customer_id, name, email, phone FROM Customers";
                        PreparedStatement ps = con.prepareStatement(sql);  // Prepare the query
                        ResultSet rs = ps.executeQuery();  // Execute the query

                        while (rs.next()) {
                %>
                            <tr>
                                <td><%= rs.getInt("customer_id") %></td>
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getString("email") %></td>
                                <td><%= rs.getString("phone") %></td>
                            </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();  // Handle exception
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Back to Admin Dashboard -->
    <a href="adminDashboard.jsp">Back to Admin Dashboard</a>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>

</html>
