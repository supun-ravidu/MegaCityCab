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
import java.sql.ResultSet;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class ManageBookingServletTest {

    private ManageBookingServlet manageBookingServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;
    private Connection mockConnection;
    private PreparedStatement mockStatement;
    private ResultSet mockResultSet;

    @BeforeEach
    void setUp() {
        manageBookingServlet = new ManageBookingServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);
    }

    @Test
    void testInvalidAction() throws ServletException, IOException {
        when(request.getParameter("action")).thenReturn("invalid_action");
        when(request.getParameter("orderNumber")).thenReturn("ORD12345");
        when(request.getRequestDispatcher("manageBooking.jsp")).thenReturn(dispatcher);

        manageBookingServlet.doPost(request, response);

        verify(request).setAttribute("errorMessage", "Invalid action specified.");
        verify(dispatcher).forward(request, response);
    }

    @Test
    void testDatabaseConnectionFailure() throws ServletException, IOException {
        when(request.getParameter("action")).thenReturn("view");
        when(request.getParameter("orderNumber")).thenReturn("ORD12345");
        when(request.getRequestDispatcher("error.jsp")).thenReturn(dispatcher);

        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection)
                    .thenThrow(new RuntimeException("Database connection failed"));

            manageBookingServlet.doPost(request, response);

            verify(request).setAttribute(eq("errorMessage"), eq("Database Error: Database connection failed"));
            verify(dispatcher).forward(request, response);
        }
    }
}
