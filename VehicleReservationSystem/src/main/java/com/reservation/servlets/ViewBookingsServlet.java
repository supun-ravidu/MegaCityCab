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
import java.sql.ResultSet;

@WebServlet("/ViewBookingsServlet")
public class ViewBookingsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ResultSet rs = null;
        PreparedStatement ps = null;
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            String sql = "SELECT b.booking_id, b.order_number, b.customer_name, b.address, b.phone, b.destination, b.fare, b.booking_date, b.pickup_location, b.vehicle_type, b.tax, b.total_fare, b.booking_time, c.car_model, c.license_plate, d.driver_name, d.phone AS driver_phone FROM Bookings b JOIN Cars c ON b.car_license_plate = c.license_plate JOIN Drivers d ON b.car_license_plate = d.license_plate";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            request.setAttribute("bookings", rs);
            request.getRequestDispatcher("viewBookings.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error fetching bookings: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
