package com.reservation.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3305/VehicleDB?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root"; // Change if your username is different
    private static final String PASSWORD = "1234"; // Replace with your MySQL password

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish Connection
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Database Connection Successful!");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL Driver Not Found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("❌ Database Connection Failed!");
            e.printStackTrace();
        }
        return conn;
    }

    public static void main(String[] args) {
        // Test Database Connection
        Connection testConn = getConnection();
        if (testConn != null) {
            System.out.println("✅ Connection Test Passed!");
        } else {
            System.out.println("❌ Connection Test Failed!");
        }
    }
}
