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

@WebServlet("/DeleteCarServlet")
public class DeleteCarServlet extends HttpServlet {

    // Declare the serialVersionUID
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String licensePlate = request.getParameter("licensePlate");

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            String sql = "DELETE FROM Cars WHERE license_plate = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, licensePlate);

            int rowsDeleted = ps.executeUpdate();

            if (rowsDeleted > 0) {
                // Redirect to the view cars page after deleting the car
                response.sendRedirect("ViewCarsServlet");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting car.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }
}
