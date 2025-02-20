package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");  // Ensure user is logged in
        
        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE Customers SET name=?, phone=?, address=?, nic=? WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, nic);
            ps.setString(5, email);
            
            int updated = ps.executeUpdate();
            if (updated > 0) {
                session.setAttribute("userName", name);  // Update session name
                request.setAttribute("message", "Profile updated successfully!"); // Set success message
            } else {
                request.setAttribute("message", "Error updating profile. Please try again.");
            }
            request.getRequestDispatcher("profile.jsp").forward(request, response); // Forward back to profile page
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Database error: " + e.getMessage());
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}
