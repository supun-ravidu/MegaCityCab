package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import com.reservation.utils.UserUtils;  // Class for password hashing
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {

    // Declare the serialVersionUID
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data from the request
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String nic = request.getParameter("nic");
        String password = request.getParameter("password");

        // Input validation
        if (name == null || address == null || phone == null || email == null || nic == null || password == null ||
            name.isEmpty() || address.isEmpty() || phone.isEmpty() || email.isEmpty() || nic.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Hash the password before storing it
        String hashedPassword = UserUtils.hashPassword(password);

        // Try to connect to the database and insert the data
        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            // SQL query to insert user details into Customers table
            String sql = "INSERT INTO Customers (name, address, phone, email, nic, password) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, address);
            ps.setString(3, phone);
            ps.setString(4, email);
            ps.setString(5, nic);
            ps.setString(6, hashedPassword);  // Store the hashed password
            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                response.sendRedirect("success.jsp");
            } else {
                request.setAttribute("errorMessage", "Error: Unable to register user.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Print SQL error in logs
            request.setAttribute("errorMessage", "Database Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
