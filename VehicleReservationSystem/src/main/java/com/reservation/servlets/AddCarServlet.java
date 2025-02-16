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

@WebServlet("/AddCarServlet")
public class AddCarServlet extends HttpServlet {

    // Declare the serialVersionUID
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carModel = request.getParameter("carModel");
        String carType = request.getParameter("carType");
        String licensePlate = request.getParameter("licensePlate");
        int year = Integer.parseInt(request.getParameter("year"));
        String status = request.getParameter("status");

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            String sql = "INSERT INTO Cars (car_model, car_type, license_plate, year, status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, carModel);
            ps.setString(2, carType);
            ps.setString(3, licensePlate);
            ps.setInt(4, year);
            ps.setString(5, status);

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                // After successfully adding the car, redirect to the Add Driver page
                response.sendRedirect("addDriver.jsp?licensePlate=" + licensePlate);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error inserting car details.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }
}
