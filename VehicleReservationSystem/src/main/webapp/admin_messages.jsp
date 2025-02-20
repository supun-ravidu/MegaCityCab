<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<%
    List<String[]> messages = (List<String[]>) request.getAttribute("messages");

    if (messages == null) {
        response.sendRedirect("ViewMessagesServlet");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - User Messages</title>

    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        /* Background Styling */
        body {
            background: url('https://source.unsplash.com/1600x900/?tech,workspace') no-repeat center center fixed;
            background-size: cover;
            color: white;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            transition: background 0.5s ease-in-out;
        }

        /* Glassmorphism Container */
        .container-glass {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 30px;
            width: 85%;
            margin: auto;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1s ease-in-out;
        }

        /* Title */
        h1 {
            text-align: center;
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 25px;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.3);
        }

        /* Message Card */
        .message-card {
            background: rgba(255, 255, 255, 0.15);
            border-left: 5px solid #ffdf00;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .message-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        }

        .message-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .message-name {
            font-weight: bold;
            font-size: 1.1rem;
            color: #ffdf00;
        }

        .message-email {
            font-size: 0.9rem;
            color: #bbb;
        }

        .message-text {
            margin-top: 10px;
            color: #ddd;
        }

        .message-time {
            font-size: 0.85rem;
            color: #aaa;
        }

        /* Search Box */
        .search-box {
            width: 100%;
            max-width: 400px;
            margin: 0 auto 20px;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            text-align: center;
        }

        /* Buttons */
        .btn-back {
            margin-top: 20px;
            background-color: #ffdf00;
            color: black;
            padding: 10px 15px;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
            display: inline-block;
            transition: background 0.3s ease-in-out;
        }

        .btn-back:hover {
            background-color: #e6c300;
            text-decoration: none;
        }

        /* Dark Mode */
        .dark-mode {
            background: #222 !important;
            color: white !important;
        }

        .dark-mode .container-glass {
            background: rgba(0, 0, 0, 0.3) !important;
        }

        .dark-mode .message-card {
            background: rgba(0, 0, 0, 0.3) !important;
            border-left: 5px solid #ff5733 !important;
        }

        .dark-mode .btn-back {
            background: #ff5733 !important;
            color: white !important;
        }

        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container-glass {
                width: 95%;
            }
        }
    </style>
</head>
<body>

    <div class="container text-center mt-4">
        <button class="btn btn-warning" onclick="toggleDarkMode()">
            <i class="bi bi-moon-fill"></i> Toggle Dark Mode
        </button>
    </div>

    <div class="container-glass mt-4">
        <h1><i class="bi bi-chat-dots"></i> User Messages</h1>

        <!-- Search Bar -->
        <input type="text" id="searchInput" class="search-box form-control" placeholder="Search messages by name or email..." onkeyup="filterMessages()">

        <div id="messagesContainer">
            <% if (!messages.isEmpty()) { 
                for (String[] msg : messages) { %>
                    <div class="message-card">
                        <div class="message-header">
                            <div>
                                <span class="message-name"><i class="bi bi-person-circle"></i> <%= msg[0] %></span>
                                <br>
                                <span class="message-email"><i class="bi bi-envelope"></i> <%= msg[1] %></span>
                            </div>
                            <span class="message-time"><i class="bi bi-clock"></i> <%= msg[3] %></span>
                        </div>
                        <p class="message-text"><i class="bi bi-chat-right-dots"></i> <%= msg[2] %></p>
                    </div>
            <% }} else { %>
                <div class="alert alert-warning text-center">
                    <i class="bi bi-exclamation-triangle"></i> No messages found.
                </div>
            <% } %>
        </div>

        <a href="adminDashboard.jsp" class="btn btn-back"><i class="bi bi-arrow-left-circle"></i> Back to Dashboard</a>
    </div>

    <!-- JavaScript to filter messages -->
    <script>
        function filterMessages() {
            let input = document.getElementById("searchInput").value.toLowerCase();
            let messages = document.querySelectorAll(".message-card");

            messages.forEach(card => {
                let name = card.querySelector(".message-name").textContent.toLowerCase();
                let email = card.querySelector(".message-email").textContent.toLowerCase();
                if (name.includes(input) || email.includes(input)) {
                    card.style.display = "block";
                } else {
                    card.style.display = "none";
                }
            });
        }

        function toggleDarkMode() {
            document.body.classList.toggle("dark-mode");
            localStorage.setItem("darkMode", document.body.classList.contains("dark-mode") ? "enabled" : "disabled");
        }

        if (localStorage.getItem("darkMode") === "enabled") {
            document.body.classList.add("dark-mode");
        }
    </script>

</body>
</html>
