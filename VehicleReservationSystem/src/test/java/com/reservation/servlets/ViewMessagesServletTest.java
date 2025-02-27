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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.assertTrue;  // Added import

class ViewMessagesServletTest {

    private ViewMessagesServlet viewMessagesServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;
    private Connection mockConnection;
    private PreparedStatement mockStatement;
    private ResultSet mockResultSet;

    @BeforeEach
    void setUp() {
        viewMessagesServlet = new ViewMessagesServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);
    }

    @Test
    void testViewMessagesSuccess() throws ServletException, IOException, SQLException {
        // Prepare mock data
        ArrayList<String[]> messages = new ArrayList<>();
        messages.add(new String[]{"John Doe", "johndoe@example.com", "How do I book a cab?", "2025-02-27 10:30:00"});
        messages.add(new String[]{"Alice Smith", "alice@example.com", "Is there a discount on weekly bookings?", "2025-02-27 11:00:00"});

        // Simulate DB connection and query execution
        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeQuery()).thenReturn(mockResultSet);

            // Mock ResultSet to return test data
            when(mockResultSet.next()).thenReturn(true).thenReturn(true).thenReturn(false);
            when(mockResultSet.getString("name")).thenReturn("John Doe").thenReturn("Alice Smith");
            when(mockResultSet.getString("email")).thenReturn("johndoe@example.com").thenReturn("alice@example.com");
            when(mockResultSet.getString("message")).thenReturn("How do I book a cab?").thenReturn("Is there a discount on weekly bookings?");
            when(mockResultSet.getString("submitted_at")).thenReturn("2025-02-27 10:30:00").thenReturn("2025-02-27 11:00:00");

            // Mock the request dispatcher
            when(request.getRequestDispatcher("admin_messages.jsp")).thenReturn(dispatcher);

            // Call servlet method
            viewMessagesServlet.doGet(request, response);


        }
    }

    @Test
    void testDatabaseErrorHandling() throws ServletException, IOException, SQLException {
        // Simulate database error
        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeQuery()).thenThrow(new SQLException("Database connection failed"));

            // Mock the request dispatcher
            when(request.getRequestDispatcher("error.jsp")).thenReturn(dispatcher);

            // Call servlet method
            viewMessagesServlet.doGet(request, response);

            // Verify that the error message is set and forwarded to error.jsp
            ArgumentCaptor<String> errorMessageCaptor = ArgumentCaptor.forClass(String.class);
            verify(request).setAttribute(eq("errorMessage"), errorMessageCaptor.capture());
            assertTrue(errorMessageCaptor.getValue().contains("Database Error:"));
            verify(dispatcher).forward(request, response);
        }
    }

    @Test
    void testNoMessagesInDatabase() throws ServletException, IOException, SQLException {
        // Simulate no messages in the database
        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeQuery()).thenReturn(mockResultSet);
            when(mockResultSet.next()).thenReturn(false); // No messages

            // Mock the request dispatcher
            when(request.getRequestDispatcher("admin_messages.jsp")).thenReturn(dispatcher);

            // Call servlet method
            viewMessagesServlet.doGet(request, response);

            // Verify that an empty list is set
            verify(request).setAttribute("messages", new ArrayList<>());
            verify(dispatcher).forward(request, response);
        }
    }
}
