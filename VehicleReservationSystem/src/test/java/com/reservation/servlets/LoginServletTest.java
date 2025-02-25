package com.reservation.servlets;

import com.reservation.utils.DBConnection;
import com.reservation.utils.UserUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
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

import static org.mockito.Mockito.*;

class LoginServletTest {

    private LoginServlet loginServlet;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private HttpSession session;
    private RequestDispatcher dispatcher;
    private Connection mockConnection;
    private PreparedStatement mockStatement;
    private ResultSet mockResultSet;

    @BeforeEach
    void setUp() {
        loginServlet = new LoginServlet();
        request = mock(HttpServletRequest.class);
        response = mock(HttpServletResponse.class);
        session = mock(HttpSession.class);
        dispatcher = mock(RequestDispatcher.class);
        mockConnection = mock(Connection.class);
        mockStatement = mock(PreparedStatement.class);
        mockResultSet = mock(ResultSet.class);

        when(request.getSession()).thenReturn(session);
    }

    @Test
    void testAdminLoginSuccess() throws ServletException, IOException {
        when(request.getParameter("email")).thenReturn("admin@gmail.com");
        when(request.getParameter("password")).thenReturn("123");

        loginServlet.doPost(request, response);

        verify(session).setAttribute("role", "admin");
        verify(response).sendRedirect("adminDashboard.jsp");
    }

    @Test
    void testUserLoginSuccess() throws ServletException, IOException, SQLException {
        when(request.getParameter("email")).thenReturn("user@example.com");
        when(request.getParameter("password")).thenReturn("password123");

        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class);
             MockedStatic<UserUtils> mockedUserUtils = mockStatic(UserUtils.class)) {
            
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeQuery()).thenReturn(mockResultSet);
            when(mockResultSet.next()).thenReturn(true);
            when(mockResultSet.getString("password")).thenReturn("hashedPassword");
            when(mockResultSet.getString("name")).thenReturn("John Doe");
            when(mockResultSet.getString("phone")).thenReturn("1234567890");
            
            mockedUserUtils.when(() -> UserUtils.checkPassword("password123", "hashedPassword")).thenReturn(true);

            loginServlet.doPost(request, response);

            verify(session).setAttribute("role", "user");
            verify(session).setAttribute("userName", "John Doe");
            verify(session).setAttribute("userEmail", "user@example.com");
            verify(session).setAttribute("userPhone", "1234567890");
            verify(response).sendRedirect("user.jsp");
        }
    }

    @Test
    void testInvalidPassword() throws ServletException, IOException, SQLException {
        when(request.getParameter("email")).thenReturn("user@example.com");
        when(request.getParameter("password")).thenReturn("wrongpassword");
        when(request.getRequestDispatcher("login.jsp")).thenReturn(dispatcher);

        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class);
             MockedStatic<UserUtils> mockedUserUtils = mockStatic(UserUtils.class)) {
            
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeQuery()).thenReturn(mockResultSet);
            when(mockResultSet.next()).thenReturn(true);
            when(mockResultSet.getString("password")).thenReturn("hashedPassword");
            
            mockedUserUtils.when(() -> UserUtils.checkPassword("wrongpassword", "hashedPassword")).thenReturn(false);

            loginServlet.doPost(request, response);

            verify(request).setAttribute("errorMessage", "Invalid password. Please try again.");
            verify(dispatcher).forward(request, response);
        }
    }

    @Test
    void testUserNotFound() throws ServletException, IOException, SQLException {
        when(request.getParameter("email")).thenReturn("unknown@example.com");
        when(request.getParameter("password")).thenReturn("password123");
        when(request.getRequestDispatcher("login.jsp")).thenReturn(dispatcher);

        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection).thenReturn(mockConnection);
            when(mockConnection.prepareStatement(anyString())).thenReturn(mockStatement);
            when(mockStatement.executeQuery()).thenReturn(mockResultSet);
            when(mockResultSet.next()).thenReturn(false);

            loginServlet.doPost(request, response);

            verify(request).setAttribute("errorMessage", "No user found with this email. Please register first.");
            verify(dispatcher).forward(request, response);
        }
    }

    @Test
    void testDatabaseError() throws ServletException, IOException, SQLException {
        when(request.getParameter("email")).thenReturn("user@example.com");
        when(request.getParameter("password")).thenReturn("password123");
        when(request.getRequestDispatcher("login.jsp")).thenReturn(dispatcher);

        try (MockedStatic<DBConnection> mockedDb = mockStatic(DBConnection.class)) {
            mockedDb.when(DBConnection::getConnection)
                    .thenAnswer(invocation -> { throw new SQLException("Database connection failed"); });

            loginServlet.doPost(request, response);

            verify(request).setAttribute("errorMessage", "Database Error: Database connection failed");
            verify(dispatcher).forward(request, response);
        }
    }

}
