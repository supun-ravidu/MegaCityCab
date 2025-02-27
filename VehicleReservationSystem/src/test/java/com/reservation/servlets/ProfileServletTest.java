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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class ProfileServletTest {

    private ProfileServlet profileServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private RequestDispatcher dispatcher;
    private Connection mockConnection;
    private PreparedStatement mockStatement;
    private ResultSet mockResultSet;

    @BeforeEach
    void setUp() {
        profileServlet = new ProfileServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        session = mock(HttpSession.class);
        dispatcher = mock(RequestDispatcher.class);
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);
    }

    @Test
    void testProfileUpdateSuccess() throws ServletException, IOException, SQLException {
        // Simulate the user session
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("userEmail")).thenReturn("user@example.com");
        when(request.getParameter("name")).thenReturn("John Doe");
        when(request.getParameter("phone")).thenReturn("9876543210");
        when(request.getParameter("address")).thenReturn("123 Main St");
        when(request.getParameter("nic")).thenReturn("12345678");

        // Mock database connection and result
        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeUpdate()).thenReturn(1);  // Simulating successful update

            // Mocking the request dispatcher
            when(request.getRequestDispatcher("profile.jsp")).thenReturn(dispatcher);

            // Call the servlet method
            profileServlet.doPost(request, response);

            // Verify that the success message is set and forwarded
            verify(request).setAttribute("message", "Profile updated successfully!");
            verify(dispatcher).forward(request, response);
        }
    }

    @Test
    void testProfileUpdateFailure() throws ServletException, IOException, SQLException {
        // Simulate the user session
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("userEmail")).thenReturn("user@example.com");
        when(request.getParameter("name")).thenReturn("John Doe");
        when(request.getParameter("phone")).thenReturn("9876543210");
        when(request.getParameter("address")).thenReturn("123 Main St");
        when(request.getParameter("nic")).thenReturn("12345678");

        // Mock database connection and result
        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeUpdate()).thenReturn(0);  // Simulating failure in updating

            // Mocking the request dispatcher
            when(request.getRequestDispatcher("profile.jsp")).thenReturn(dispatcher);

            // Call the servlet method
            profileServlet.doPost(request, response);

            // Verify that the failure message is set and forwarded
            verify(request).setAttribute("message", "Error updating profile. Please try again.");
            verify(dispatcher).forward(request, response);
        }
    }

    @Test
    void testUserNotLoggedIn() throws ServletException, IOException {
        // Simulate no session (user not logged in)
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("userEmail")).thenReturn(null);

        // Call the servlet method
        profileServlet.doPost(request, response);

        // Verify that the user is redirected to the login page
        verify(response).sendRedirect("login.jsp");
    }

    @Test
    void testDatabaseErrorHandling() throws ServletException, IOException, SQLException {
        // Simulate the user session
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("userEmail")).thenReturn("user@example.com");
        when(request.getParameter("name")).thenReturn("John Doe");
        when(request.getParameter("phone")).thenReturn("9876543210");
        when(request.getParameter("address")).thenReturn("123 Main St");
        when(request.getParameter("nic")).thenReturn("12345678");

        // Mock database connection throwing an exception
        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeUpdate()).thenThrow(new SQLException("Database error"));

            // Mocking the request dispatcher
            when(request.getRequestDispatcher("profile.jsp")).thenReturn(dispatcher);

            // Call the servlet method
            profileServlet.doPost(request, response);

            // Verify that the error message is set and forwarded
            ArgumentCaptor<String> errorMessageCaptor = ArgumentCaptor.forClass(String.class);
            verify(request).setAttribute(eq("message"), errorMessageCaptor.capture());
            assertTrue(errorMessageCaptor.getValue().contains("Database error"));
            verify(dispatcher).forward(request, response);
        }
    }
}
