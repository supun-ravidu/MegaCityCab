package com.reservation.servlets;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import com.reservation.utils.DBConnection;
import com.reservation.utils.UserUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class CustomerServletTest {

    private CustomerServlet customerServlet;
    private HttpServletRequest mockRequest;
    private HttpServletResponse mockResponse;
    private Connection mockConnection;
    private PreparedStatement mockPreparedStatement;

    @BeforeEach
    public void setUp() {
        customerServlet = new CustomerServlet();
        mockRequest = mock(HttpServletRequest.class);
        mockResponse = mock(HttpServletResponse.class);
        mockConnection = mock(Connection.class);
        mockPreparedStatement = mock(PreparedStatement.class);
    }

    @Test
    public void testDoPost_validInput() throws ServletException, IOException {
        // Setup mock request parameters
        when(mockRequest.getParameter("name")).thenReturn("John Doe");
        when(mockRequest.getParameter("address")).thenReturn("123 Street");
        when(mockRequest.getParameter("phone")).thenReturn("1234567890");
        when(mockRequest.getParameter("email")).thenReturn("john@example.com");
        when(mockRequest.getParameter("nic")).thenReturn("123456789V");
        when(mockRequest.getParameter("password")).thenReturn("password123");

        // Mock the connection and prepared statement
        when(DBConnection.getConnection()).thenReturn(mockConnection);
        when(mockConnection.prepareStatement(anyString())).thenReturn(mockPreparedStatement);
        when(mockPreparedStatement.executeUpdate()).thenReturn(1); // Simulate successful insert

        // Call the doPost method
        customerServlet.doPost(mockRequest, mockResponse);

        // Verify the expected behavior
        verify(mockResponse).sendRedirect("success.jsp");
    }

    @Test
    public void testDoPost_missingFields() throws ServletException, IOException {
        // Setup mock request parameters (missing 'name' field)
        when(mockRequest.getParameter("name")).thenReturn(null);
        when(mockRequest.getParameter("address")).thenReturn("123 Street");
        when(mockRequest.getParameter("phone")).thenReturn("1234567890");
        when(mockRequest.getParameter("email")).thenReturn("john@example.com");
        when(mockRequest.getParameter("nic")).thenReturn("123456789V");
        when(mockRequest.getParameter("password")).thenReturn("password123");

        // Call the doPost method
        customerServlet.doPost(mockRequest, mockResponse);

        // Verify the error redirection
        verify(mockRequest).getRequestDispatcher("error.jsp");
    }

    @Test
    public void testDoPost_databaseError() throws ServletException, IOException {
        // Setup mock request parameters
        when(mockRequest.getParameter("name")).thenReturn("John Doe");
        when(mockRequest.getParameter("address")).thenReturn("123 Street");
        when(mockRequest.getParameter("phone")).thenReturn("1234567890");
        when(mockRequest.getParameter("email")).thenReturn("john@example.com");
        when(mockRequest.getParameter("nic")).thenReturn("123456789V");
        when(mockRequest.getParameter("password")).thenReturn("password123");

        // Mock a failed database connection
        when(DBConnection.getConnection()).thenReturn(null);

        // Call the doPost method
        customerServlet.doPost(mockRequest, mockResponse);

        // Verify the error redirection
        verify(mockRequest).getRequestDispatcher("error.jsp");
    }
}
