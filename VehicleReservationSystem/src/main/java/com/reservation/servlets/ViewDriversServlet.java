package com.reservation.servlets;

import com.reservation.models.Driver;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ViewDriversServlet")
public class ViewDriversServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Driver> drivers = new ArrayList<Driver>();

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            String sql = "SELECT driver_name, phone, email, license_number, license_plate, status FROM Drivers";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Driver driver = new Driver(
                    rs.getString("driver_name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("license_number"),
                    rs.getString("license_plate"),
                    rs.getString("status")
                );
                drivers.add(driver);
            }

            request.setAttribute("drivers", drivers);
            request.getRequestDispatcher("viewDrivers.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
        }
    }
}
