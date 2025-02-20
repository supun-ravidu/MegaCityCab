<%
    Boolean darkMode = (Boolean) session.getAttribute("darkMode");
    if (darkMode == null) {
        darkMode = false; // Default to light mode
    }
%>

<style>
    body {
        background-color: <%= darkMode ? "#121212" : "#f8f9fa" %>;
        color: <%= darkMode ? "#ffffff" : "#000000" %>;
        transition: background-color 0.3s ease, color 0.3s ease;
    }
    .card {
        background-color: <%= darkMode ? "#1e1e1e" : "#ffffff" %>;
        border: none;
        color: <%= darkMode ? "#ffffff" : "#000000" %>;
    }
</style>
