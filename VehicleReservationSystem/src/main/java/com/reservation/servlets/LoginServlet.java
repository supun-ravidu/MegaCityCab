package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import com.reservation.utils.UserUtils;  // For password checking
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    // Declare the serialVersionUID
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Check if it's an admin login
        if ("admin@gmail.com".equals(email) && "123".equals(password)) {
            // Set admin session attributes
            HttpSession session = request.getSession();
            session.setAttribute("role", "admin");
            response.sendRedirect("adminDashboard.jsp"); // Redirect to the admin dashboard
            return; // Exit the method here
        }

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            // SQL query to fetch the stored password hash and other user details from the database
            String sql = "SELECT customer_id, name, phone, email, password FROM Customers WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // If the email exists, compare the password
                String storedHashedPassword = rs.getString("password");

                // Check if the entered password matches the stored hashed password
                if (UserUtils.checkPassword(password, storedHashedPassword)) {
                    // If passwords match, set session attributes for user details
                    HttpSession session = request.getSession();
                    session.setAttribute("role", "user"); // Set role as user
                    session.setAttribute("userName", rs.getString("name"));
                    session.setAttribute("userEmail", email); // Store email in session
                    session.setAttribute("userPhone", rs.getString("phone"));

                    // Redirect to user dashboard
                    response.sendRedirect("user.jsp");
                } else {
                    // Invalid password, show error message
                    request.setAttribute("errorMessage", "Invalid password. Please try again.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                // Email not found in the database, show warning message
                request.setAttribute("errorMessage", "No user found with this email. Please register first.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();  // Print any exceptions in the logs
            request.setAttribute("errorMessage", "Database Error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
