
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="classes.User" %>

<%
    // Get the logged-in user from the session
    User user = (User) session.getAttribute("loggedInUser");

    // Redirect to login if no user is logged in
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }




    boolean statusdarkMode = user.getStatus();

    String themeClass = statusdarkMode ? "dark-mode" : "light-mode";
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>User Settings</title>

<style>

/* ================= GENERAL ================= */

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    padding: 30px 15px;
    font-family: Arial, sans-serif;
    min-height: 100vh;
    transition: background 0.3s, color 0.3s;
}

/* ================= DARK MODE ================= */

body.dark-mode {
    background: #0f172a;
    color: #e2e8f0;
}

.dark-mode .container {
    background: #1e293b;
    border: 1px solid #334155;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.25);
}

.dark-mode h1 {
    color: #60a5fa;
}

.dark-mode .info {
    background: #0f172a;
    border: 1px solid #334155;
}

.dark-mode .label {
    color: #94a3b8;
}

.dark-mode .value {
    color: #f1f5f9;
}

.dark-mode .back {
    background: #2563eb;
    color: white;
}

.dark-mode .back:hover {
    background: #1d4ed8;
}

/* ================= LIGHT MODE ================= */

body.light-mode {
    background: #f8fafc;
    color: #1e293b;
}

.light-mode .container {
    background: #ffffff;
    border: 1px solid #e2e8f0;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
}

.light-mode h1 {
    color: #2563eb;
}

.light-mode .info {
    background: #f1f5f9;
    border: 1px solid #e2e8f0;
}

.light-mode .label {
    color: #64748b;
}

.light-mode .value {
    color: #1e293b;
}

.light-mode .back {
    background: #2563eb;
    color: white;
}

.light-mode .back:hover {
    background: #1d4ed8;
}

/* ================= CONTAINER ================= */

.container {
    max-width: 600px;
    margin: 30px auto;
    padding: 30px;
    border-radius: 14px;
    transition: background 0.3s, border 0.3s;
}

h1 {
    text-align: center;
    margin-bottom: 28px;
}

.info {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    padding: 15px;
    margin-bottom: 12px;
    border-radius: 8px;
}

.label {
    font-weight: bold;
}

.value {
    overflow-wrap: anywhere;
}

.back {
    display: block;
    margin-top: 25px;
    padding: 13px;
    text-align: center;
    text-decoration: none;
    border-radius: 8px;
    transition: background 0.2s;
}

@media (max-width: 480px) {

    .container {
        padding: 20px 15px;
    }

    h1 {
        font-size: 24px;
    }

}

</style>

</head>

<body class="<%= themeClass %>">

    <div class="container">

        <h1>User Information</h1>

        <div class="info">

            <span class="label">Name:</span>

            <span class="value">
                <%= user.getName() %>
            </span>

        </div>

        <div class="info">

            <span class="label">Email:</span>

            <span class="value">
                <%= user.getEmail() %>
            </span>

        </div>

        <div class="info">

            <span class="label">Governorate:</span>

            <span class="value">
                <%= user.getGovernerate() %>
            </span>

        </div>

        <div class="info">

            <span class="label">Birthdate:</span>

            <span class="value">
                <%= user.getBirthdate() %>
            </span>

        </div>

        <div class="info">

            <span class="label">Languages:</span>

            <span class="value">
                <%= user.getLangueges() %>
            </span>

        </div>

        <div class="info">

            <span class="label">Theme Preference:</span>

            <span class="value">
                <%= user.getStatus() ? "Dark Mode" : "Light Mode" %>
            </span>

        </div>

        <a class="back"
           href="<%= request.getContextPath() %>/home.jsp">

            Back to Home

        </a>

    </div>

</body>

</html>
