package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import static org.mockito.Mockito.*;

class AddDriverServletTest {

    private AddDriverServlet addDriverServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;
    private Connection mockConnection;
    private PreparedStatement mockStatement;

    @BeforeEach
    void setUp() {
        addDriverServlet = new AddDriverServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
    }

    @Test
    void testAddDriverSuccess() throws ServletException, IOException {
        // Mock request parameters
        when(request.getParameter("driverName")).thenReturn("Alice Johnson");
        when(request.getParameter("driverPhone")).thenReturn("0779876543");
        when(request.getParameter("driverEmail")).thenReturn("alice@cabservice.com");
        when(request.getParameter("licenseNumber")).thenReturn("ABC123");
        when(request.getParameter("licensePlate")).thenReturn("ABC1234");



        }
    

    @Test
    void testAddDriverFailure() throws ServletException, IOException {
        // Simulate missing driver details (empty name)
        when(request.getParameter("driverName")).thenReturn("");
        when(request.getParameter("driverPhone")).thenReturn("0779876543");
        when(request.getParameter("driverEmail")).thenReturn("alice@cabservice.com");
        when(request.getParameter("licenseNumber")).thenReturn("ABC123");
        when(request.getParameter("licensePlate")).thenReturn("ABC1234");

        // Call servlet method
        addDriverServlet.doPost(request, response);

        // Verify that error message is shown
        verify(response).sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error inserting driver details.");
    }
}
