
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.User" %>

<%
    ArrayList<User> users =
        (ArrayList<User>) session.getAttribute("Users");

    // Create the list only if it doesn't exist
    if (users == null) {
        users = new ArrayList<>();
        session.setAttribute("Users", users);
    }

    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String governerate = request.getParameter("governerate");
        String birthdate = request.getParameter("birthdate");
        String languages = request.getParameter("languages");

        boolean status =Boolean.parseBoolean(request.getParameter("status"));

        // Check that the username is not empty
        if (name == null || name.trim().isEmpty()) {
            message = "Username is required";
        } else {

            boolean isExistUser = users.stream()
                .anyMatch(user ->
                    user.getName().equalsIgnoreCase(name.trim())
                );

            if (isExistUser) {
                // Stay on this page and show the error
                message = "Registration failed: Username already exists";
            } else {

                User newUser = new User(
                    name.trim(),
                    password,
                    email,
                    governerate,
                    birthdate,
                    languages,
                    status
                );

                users.add(newUser);

                response.sendRedirect(
                        request.getContextPath() + "/login.jsp"
                    );
                return;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration Result</title>

    <style>
       * {
    box-sizing: border-box;
}

body {
    margin: 0;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background: #0f172a;
    font-family: Arial, sans-serif;
}

.card {
    width: 90%;
    max-width: 420px;
    padding: 35px 25px;
    background: #1e293b;
    border: 1px solid #334155;
    border-radius: 16px;
    text-align: center;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.35);
}

.error-icon {
    width: 65px;
    height: 65px;
    margin: 0 auto 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    background: #451a1a;
    color: #f87171;
    font-size: 38px;
    font-weight: bold;
}

.card h2 {
    margin-bottom: 15px;
    color: #f1f5f9;
    font-size: 23px;
}

.error-message {
    margin: 0;
    padding: 14px;
    border: 1px solid #7f1d1d;
    border-radius: 8px;
    background: #351b24;
    color: #fca5a5;
    font-size: 14px;
    line-height: 1.6;
}

.back-link {
    display: inline-block;
    margin-top: 22px;
    padding: 12px 24px;
    background: #3b82f6;
    color: #ffffff;
    text-decoration: none;
    border-radius: 8px;
    font-weight: 600;
    transition: background 0.3s, transform 0.3s;
}

.back-link:hover {
    background: #2563eb;
    transform: translateY(-2px);
}
    </style>
</head>

<body>

    <div class="card">

        <div class="error-icon">!</div>

        <h2>Registration Error</h2>

        <% if (!message.isEmpty()) { %>
            <p class="error-message">
                <%= message %>
            </p>
        <% } %>

        <a href="pages/register.html" class="back-link">
            Try Again
        </a>

    </div>

</body>
</html>
