package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/AddDriverServlet")
public class AddDriverServlet extends HttpServlet {

    // Declare the serialVersionUID
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String driverName = request.getParameter("driverName");
        String driverPhone = request.getParameter("driverPhone");
        String driverEmail = request.getParameter("driverEmail");
        String licenseNumber = request.getParameter("licenseNumber");
        String licensePlate = request.getParameter("licensePlate");  // This should be passed from addCar.jsp
        
        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            String sql = "INSERT INTO Drivers (driver_name, phone, email, license_number, license_plate, status) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, driverName);
            ps.setString(2, driverPhone);
            ps.setString(3, driverEmail);
            ps.setString(4, licenseNumber);
            ps.setString(5, licensePlate);  // Linking driver to the car using license plate
            ps.setString(6, "Active");

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                response.sendRedirect("adminDashboard.jsp");  // Redirect to dashboard after driver is added
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error inserting driver details.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }
}
