package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import com.reservation.utils.UserUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class CustomerServletTest {

    private CustomerServlet customerServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;
    private Connection mockConnection;
    private PreparedStatement mockStatement;

    @BeforeEach
    void setUp() {
        customerServlet = new CustomerServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
    }

    @Test
    void testSuccessfulSignup() throws ServletException, IOException, SQLException {
        // Mock request parameters
        when(request.getParameter("name")).thenReturn("John Doe");
        when(request.getParameter("address")).thenReturn("123 Main St");
        when(request.getParameter("phone")).thenReturn("1234567890");
        when(request.getParameter("email")).thenReturn("john@example.com");
        when(request.getParameter("nic")).thenReturn("12345678");
        when(request.getParameter("password")).thenReturn("password123");

        // Mock password hashing
        try (MockedStatic<UserUtils> mockedUserUtils = mockStatic(UserUtils.class)) {
            mockedUserUtils.when(() -> UserUtils.hashPassword("password123")).thenReturn("hashedPassword123");

            // Mock DB connection
            try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
                mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
                when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
                when(mockStatement.executeUpdate()).thenReturn(1); // Simulating successful insertion

                // Call servlet method
                customerServlet.doPost(request, response);

                // Verify redirect to success.jsp
                verify(response).sendRedirect("success.jsp");
            }
        }
    }

    @Test
    void testSignupWithMissingFields() throws ServletException, IOException {
        // Simulate missing parameters (name is missing)
        when(request.getParameter("name")).thenReturn("");
        when(request.getParameter("address")).thenReturn("123 Main St");
        when(request.getParameter("phone")).thenReturn("1234567890");
        when(request.getParameter("email")).thenReturn("john@example.com");
        when(request.getParameter("nic")).thenReturn("12345678");
        when(request.getParameter("password")).thenReturn("password123");
        when(request.getRequestDispatcher("error.jsp")).thenReturn(dispatcher);

        // Call servlet method
        customerServlet.doPost(request, response);

        // Verify error message is set and forwarded to error.jsp
        verify(request).setAttribute(eq("errorMessage"), eq("All fields are required."));
        verify(dispatcher).forward(request, response);
    }

    @Test
    void testDatabaseErrorHandling() throws ServletException, IOException, SQLException {
        // Mock request parameters
        when(request.getParameter("name")).thenReturn("John Doe");
        when(request.getParameter("address")).thenReturn("123 Main St");
        when(request.getParameter("phone")).thenReturn("1234567890");
        when(request.getParameter("email")).thenReturn("john@example.com");
        when(request.getParameter("nic")).thenReturn("12345678");
        when(request.getParameter("password")).thenReturn("password123");
        when(request.getRequestDispatcher("error.jsp")).thenReturn(dispatcher);

        // Mock password hashing
        try (MockedStatic<UserUtils> mockedUserUtils = mockStatic(UserUtils.class)) {
            mockedUserUtils.when(() -> UserUtils.hashPassword("password123")).thenReturn("hashedPassword123");

            // Mock DB connection failure
            try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
                mockedDb.when(DBConnection::getConnection)
                        .thenAnswer(invocation -> { throw new SQLException("Database connection failed"); });

                // Call servlet method
                customerServlet.doPost(request, response);

                // Verify error message is set and forwarded to error.jsp
                ArgumentCaptor<String> errorMessageCaptor = ArgumentCaptor.forClass(String.class);
                verify(request).setAttribute(eq("errorMessage"), errorMessageCaptor.capture());
                assertTrue(errorMessageCaptor.getValue().contains("Database Error:"));

                verify(dispatcher).forward(request, response);
            }
        }
    }

    @Test
    void testSignupFailsToInsertData() throws ServletException, IOException, SQLException {
        // Mock request parameters
        when(request.getParameter("name")).thenReturn("John Doe");
        when(request.getParameter("address")).thenReturn("123 Main St");
        when(request.getParameter("phone")).thenReturn("1234567890");
        when(request.getParameter("email")).thenReturn("john@example.com");
        when(request.getParameter("nic")).thenReturn("12345678");
        when(request.getParameter("password")).thenReturn("password123");
        when(request.getRequestDispatcher("error.jsp")).thenReturn(dispatcher);

        // Mock password hashing
        try (MockedStatic<UserUtils> mockedUserUtils = mockStatic(UserUtils.class)) {
            mockedUserUtils.when(() -> UserUtils.hashPassword("password123")).thenReturn("hashedPassword123");

            // Mock DB connection and SQL execution returning 0 rows inserted
            try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
                mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
                when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
                when(mockStatement.executeUpdate()).thenReturn(0); // Simulate failure in insertion

                // Call servlet method
                customerServlet.doPost(request, response);

                // Verify error message is set and forwarded to error.jsp
                verify(request).setAttribute(eq("errorMessage"), eq("Error: Unable to register user."));
                verify(dispatcher).forward(request, response);
            }
        }
    }
}
