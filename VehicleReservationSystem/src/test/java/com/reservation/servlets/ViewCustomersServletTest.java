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

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

class ViewCustomersServletTest {

    private ViewCustomersServlet viewCustomersServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;
    private Connection mockConnection;
    private PreparedStatement mockStatement;
    private ResultSet mockResultSet;

    @BeforeEach
    void setUp() {
        viewCustomersServlet = new ViewCustomersServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);
    }

    @Test
    void testFetchCustomerDataSuccess() throws ServletException, IOException, SQLException {
        // Simulate the DB connection and the execution of the query
        when(request.getRequestDispatcher("viewCustomers.jsp")).thenReturn(dispatcher);

        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeQuery()).thenReturn(mockResultSet);
            
            // Simulate the data to be fetched from the ResultSet
            when(mockResultSet.next()).thenReturn(true, false); // Simulate one row returned
            when(mockResultSet.getInt("customer_id")).thenReturn(1);
            when(mockResultSet.getString("name")).thenReturn("John Doe");
            when(mockResultSet.getString("email")).thenReturn("johndoe@example.com");
            when(mockResultSet.getString("phone")).thenReturn("0712345678");
            when(mockResultSet.getString("address")).thenReturn("123 Main St");
            when(mockResultSet.getString("nic")).thenReturn("981234567V");

            // Call the servlet method
            viewCustomersServlet.doGet(request, response);

            // Verify that the request was forwarded to viewCustomers.jsp
            verify(request).setAttribute(eq("customerList"), eq(mockResultSet));
            verify(dispatcher).forward(request, response);
        }
    }


}
