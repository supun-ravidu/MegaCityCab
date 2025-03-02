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

class ViewBookingsServletTest {

    private ViewBookingsServlet viewBookingsServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private RequestDispatcher dispatcher;
    private Connection mockConnection;
    private PreparedStatement mockStatement;
    private ResultSet mockResultSet;

    @BeforeEach
    void setUp() {
        viewBookingsServlet = new ViewBookingsServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        dispatcher = mock(RequestDispatcher.class);
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);
    }

    @Test
    void testFetchBookingDataSuccess() throws ServletException, IOException, SQLException {
        // Simulate the DB connection and the execution of the query
        when(request.getRequestDispatcher("viewBookings.jsp")).thenReturn(dispatcher);

        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeQuery()).thenReturn(mockResultSet);
            
            // Simulate the data to be fetched from the ResultSet
            when(mockResultSet.next()).thenReturn(true, false); // Simulate one row returned
            when(mockResultSet.getInt("booking_id")).thenReturn(1);
            when(mockResultSet.getString("order_number")).thenReturn("ORD12345");
            when(mockResultSet.getString("customer_name")).thenReturn("John Doe");
            when(mockResultSet.getString("address")).thenReturn("123 Main St");
            when(mockResultSet.getString("phone")).thenReturn("0712345678");
            when(mockResultSet.getString("destination")).thenReturn("Galle Road");
            when(mockResultSet.getDouble("fare")).thenReturn(2000.0);  // Correct type
            when(mockResultSet.getString("booking_date")).thenReturn("2025-03-01");
            when(mockResultSet.getString("pickup_location")).thenReturn("Galle Road");
            when(mockResultSet.getString("vehicle_type")).thenReturn("Standard");
            when(mockResultSet.getDouble("tax")).thenReturn(200.0);  // Correct type
            when(mockResultSet.getDouble("total_fare")).thenReturn(2200.0);  // Correct type
            when(mockResultSet.getString("booking_time")).thenReturn("10:00");
            when(mockResultSet.getString("car_model")).thenReturn("Toyota Prius");
            when(mockResultSet.getString("license_plate")).thenReturn("ABC1234");
            when(mockResultSet.getString("driver_name")).thenReturn("Alice Johnson");
            when(mockResultSet.getString("driver_phone")).thenReturn("0779876543");

            // Call the servlet method
            viewBookingsServlet.doGet(request, response);

            // Verify that the bookings data is set and forwarded to the JSP page
            verify(request).setAttribute(eq("bookings"), eq(mockResultSet));
            verify(dispatcher).forward(request, response);
        }
    }


}
