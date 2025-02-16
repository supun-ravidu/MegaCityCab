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

@WebServlet("/DeleteDriverServlet")
public class DeleteDriverServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String licenseNumber = request.getParameter("licenseNumber");

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            String sql = "DELETE FROM Drivers WHERE license_number = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, licenseNumber);

            int rowsDeleted = ps.executeUpdate();

            if (rowsDeleted > 0) {
                response.sendRedirect("ViewDriversServlet");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting driver.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }
}
