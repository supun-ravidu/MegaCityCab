package com.reservation.servlets;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static org.mockito.Mockito.*;

class BookingServletTest {

    private BookingServlet bookingServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;

    @BeforeEach
    void setUp() {
        bookingServlet = new BookingServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
    }

    @Test
    void testBookingSuccess() throws ServletException, IOException {  // Declare the exceptions here
        // Mocking request parameters
        when(request.getParameter("name")).thenReturn("John Doe");
        when(request.getParameter("address")).thenReturn("123 Main St");
        when(request.getParameter("phone")).thenReturn("1234567890");
        when(request.getParameter("pickupLocation")).thenReturn("Galle Road");
        when(request.getParameter("destination")).thenReturn("Duplication Road");
        when(request.getParameter("vehicleType")).thenReturn("Standard");
        when(request.getParameter("date")).thenReturn("2025-02-25");
        when(request.getParameter("time")).thenReturn("12:00");
        when(request.getParameter("paymentMethod")).thenReturn("cash_on_ride");
        when(request.getParameter("fare")).thenReturn("2000 LKR");
        when(request.getParameter("tax")).thenReturn("200 LKR");
        when(request.getParameter("totalFare")).thenReturn("2200 LKR");


    }
}
