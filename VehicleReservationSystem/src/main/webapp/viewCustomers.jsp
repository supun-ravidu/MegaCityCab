<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%
    ResultSet rs = (ResultSet) request.getAttribute("customerList");
%>

<h2>Customer List</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Address</th>
        <th>Phone</th>
        <th>Email</th>
        <th>NIC</th>
    </tr>

    <%
        try {
            while (rs != null && rs.next()) {
    %>
                <tr>
                    <td><%= rs.getInt("customer_id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("address") %></td>
                    <td><%= rs.getString("phone") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("nic") %></td>
                </tr>
    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
</table>
