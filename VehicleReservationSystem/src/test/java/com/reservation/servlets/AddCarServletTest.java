package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.MockedStatic;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class AddCarServletTest {

    private AddCarServlet addCarServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;
    private Connection mockConnection;
    private PreparedStatement mockStatement;

    @BeforeEach
    void setUp() {
        addCarServlet = new AddCarServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
    }

    @Test
    void testAddCarSuccess() throws ServletException, IOException, SQLException {
        // Simulate form parameters
        when(request.getParameter("carModel")).thenReturn("Toyota Prius");
        when(request.getParameter("carType")).thenReturn("Standard");
        when(request.getParameter("licensePlate")).thenReturn("ABC1234");
        when(request.getParameter("year")).thenReturn("2020");
        when(request.getParameter("status")).thenReturn("Available");

        // Mock database connection and successful insertion
        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeUpdate()).thenReturn(1); // Simulating successful insertion

            // Simulate request dispatcher
            when(request.getRequestDispatcher("addDriver.jsp")).thenReturn(dispatcher);

            // Call the servlet method
            addCarServlet.doPost(request, response);

            // Verify redirection to the addDriver page with the correct license plate
            verify(response).sendRedirect("addDriver.jsp?licensePlate=ABC1234");
        }
    }

    @Test
    void testAddCarFailure() throws ServletException, IOException, SQLException {
        // Simulate form parameters
        when(request.getParameter("carModel")).thenReturn("Honda Civic");
        when(request.getParameter("carType")).thenReturn("Luxury");
        when(request.getParameter("licensePlate")).thenReturn("XYZ5678");
        when(request.getParameter("year")).thenReturn("2019");
        when(request.getParameter("status")).thenReturn("Unavailable");

        // Mock database connection with failed insertion
        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeUpdate()).thenReturn(0); // Simulating failure to insert

            // Call the servlet method
            addCarServlet.doPost(request, response);

            // Verify that the error page is displayed
            verify(response).sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error inserting car details.");
        }
    }


}
