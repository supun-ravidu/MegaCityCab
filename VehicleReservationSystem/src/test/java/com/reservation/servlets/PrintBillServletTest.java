package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static org.mockito.Mockito.*;

class PrintBillServletTest {

    private PrintBillServlet printBillServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private Connection mockConnection;
    private PreparedStatement mockStatement;
    private ResultSet mockResultSet;
    private ServletOutputStream outputStream;

    @BeforeEach
    void setUp() throws IOException {
        printBillServlet = new PrintBillServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);
        outputStream = mock(ServletOutputStream.class);
        when(response.getOutputStream()).thenReturn(outputStream);
    }

    @Test
    void testPrintBillSuccess() throws ServletException, IOException, SQLException {
        when(request.getParameter("orderNumber")).thenReturn("ORD12345");

        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeQuery()).thenReturn(mockResultSet);
            when(mockResultSet.next()).thenReturn(true);
            when(mockResultSet.getString("customer_name")).thenReturn("John Doe");
            when(mockResultSet.getDouble("fare")).thenReturn(2000.0);
            when(mockResultSet.getDouble("tax")).thenReturn(200.0);
            when(mockResultSet.getDouble("total_fare")).thenReturn(2200.0);

            printBillServlet.doGet(request, response);

            verify(response).setContentType("image/jpeg");
            verify(response).setHeader(eq("Content-Disposition"), contains("booking_bill_ORD12345.jpg"));
        }
    }

    @Test
    void testPrintBillNotFound() throws ServletException, IOException, SQLException {
        when(request.getParameter("orderNumber")).thenReturn("ORD99999");

        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeQuery()).thenReturn(mockResultSet);
            when(mockResultSet.next()).thenReturn(false);

            printBillServlet.doGet(request, response);

            verify(response).sendRedirect("printBill.jsp?error=Booking not found");
        }
    }

    @Test
    void testPrintBillDatabaseError() throws ServletException, IOException, SQLException {
        when(request.getParameter("orderNumber")).thenReturn("ORD12345");

        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenThrow(new RuntimeException("Database connection failed"));

            printBillServlet.doGet(request, response);

            verify(response).sendRedirect("printBill.jsp?error=Error generating bill");
        }
    }
}
