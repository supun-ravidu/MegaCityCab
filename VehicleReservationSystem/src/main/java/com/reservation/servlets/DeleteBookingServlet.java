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

@WebServlet("/DeleteBookingServlet")
public class DeleteBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }
            String sql = "DELETE FROM Bookings WHERE booking_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, bookingId);
            int rowsDeleted = ps.executeUpdate();
            if (rowsDeleted > 0) {
                response.sendRedirect("ViewBookingsServlet"); // Redirect back to the booking list
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting booking.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database Error: " + e.getMessage());
        }
    }
}
