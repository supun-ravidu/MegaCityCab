<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userName = request.getParameter("name");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You!</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f4f4;
            text-align: center;
            padding-top: 100px;
        }

        .thank-you-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            width: 50%;
            margin: auto;
        }

        .thank-you-icon {
            font-size: 60px;
            color: #28a745;
        }

        h1 {
            color: #333;
        }

        p {
            font-size: 18px;
            color: #555;
        }

        .btn-custom {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }

        .btn-custom:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

    <div class="thank-you-container">
        <div class="thank-you-icon">✅</div>
        <h1>Thank You, <%= userName != null ? userName : "Dear User" %>!</h1>
        <p>Your message has been received. Our support team will contact you via email as soon as possible.</p>
        <p>We appreciate your patience and are here to assist you!</p>
        <a href="contact.jsp" class="btn-custom">Go Back</a>
    </div>

</body>
</html>
