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
import java.sql.SQLException;  // Import SQLException
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*; // Import assertTrue

class ViewDriversServletTest {

    private ViewDriversServlet viewDriversServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;
    private Connection mockConnection;
    private PreparedStatement mockStatement;
    private ResultSet mockResultSet;

    @BeforeEach
    void setUp() {
        viewDriversServlet = new ViewDriversServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);
    }

    @Test
    void testViewDriversSuccess() throws ServletException, IOException, SQLException {
        // Simulate the database connection and query execution
        when(request.getRequestDispatcher("viewDrivers.jsp")).thenReturn(dispatcher);

        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeQuery()).thenReturn(mockResultSet);

            // Simulate data from the ResultSet
            when(mockResultSet.next()).thenReturn(true, false);
            when(mockResultSet.getString("driver_name")).thenReturn("Alice Johnson");
            when(mockResultSet.getString("phone")).thenReturn("0779876543");
            when(mockResultSet.getString("email")).thenReturn("alice@cabservice.com");
            when(mockResultSet.getString("license_number")).thenReturn("ABC123");
            when(mockResultSet.getString("license_plate")).thenReturn("ABC1234");
            when(mockResultSet.getString("status")).thenReturn("Active");

            // Call servlet method
            viewDriversServlet.doGet(request, response);

            // Verify the drivers list is set and forwarded to the JSP page
            verify(request).setAttribute(eq("drivers"), any());
            verify(dispatcher).forward(request, response);
        }
    }


}
