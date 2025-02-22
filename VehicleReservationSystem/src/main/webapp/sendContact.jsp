<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.reservation.utils.DBConnection" %>

<%
    // Retrieve form data from contact.jsp
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    // Sanitize inputs to prevent XSS
    name = name.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    email = email.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
    message = message.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

    // Validate form inputs
    if (name == null || name.trim().isEmpty() || 
        email == null || email.trim().isEmpty() || 
        message == null || message.trim().isEmpty()) {
%>
    <script>
        alert("All fields are required.");
        window.location.href = "contact.jsp"; // Redirect back to the form
    </script>
<%
    } else {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Get database connection
            conn = DBConnection.getConnection();

            // Insert query to store the message
            String sql = "INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, message);

            // Execute the insert query
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                // Redirect to thankYou.jsp with the user's name
                response.sendRedirect("thankYou.jsp?name=" + URLEncoder.encode(name, "UTF-8"));
            } else {
%>
                <script>
                    alert("Failed to send message. Please try again.");
                    window.location.href = "contact.jsp";
                </script>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
%>
            <script>
                alert("An error occurred. Please try again later.");
                window.location.href = "contact.jsp";
            </script>
<%
        } finally {
            // Close database resources
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    }
%>
