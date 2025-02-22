package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/ViewMessagesServlet")
public class ViewMessagesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection con = DBConnection.getConnection()) {
            if (con == null) {
                throw new ServletException("Database connection failed");
            }

            // Fetch messages from the database
            String sql = "SELECT * FROM contact_messages ORDER BY submitted_at DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            ArrayList<String[]> messages = new ArrayList<>();
            while (rs.next()) {
                String[] messageData = {
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("message"),
                    rs.getString("submitted_at")
                };
                messages.add(messageData);
            }

            // Send messages to the JSP page
            request.setAttribute("messages", messages);
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin_messages.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
