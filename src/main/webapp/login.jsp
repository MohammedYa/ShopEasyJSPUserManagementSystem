
<%@page import="java.util.Optional"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.User" %>
<%
ArrayList<User> users =
    (ArrayList<User>) session.getAttribute("Users");

String message = "";

String userName = request.getParameter("username");
String password = request.getParameter("password");

boolean rememberAccount =
    request.getParameter("rememberMe") != null;

// Start with an empty Optional
Optional<User> account = Optional.empty();

// Check that all required values exist
if (users != null && userName != null && password != null) {

    account = users.stream()
        .filter(user ->
            user.getName().equals(userName.trim()) &&
            user.getPassword().equals(password)
        )
        .findFirst();
}

if (account.isPresent()) {

    // Save logged-in user
    session.setAttribute("loggedInUser", account.get());

    request.getRequestDispatcher("/home.jsp")
           .forward(request, response);

    return;

} else {
    message = "Invalid username or password";
}
%>




<%
String  cookieUserName="";
Cookie[] cookies = request.getCookies();
for(Cookie cookie:cookies){
	if(cookie.getName().equals("RememberAccount")){
		        cookieUserName = cookie.getValue();
	}
}
%>






<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>ShopEasy | Login</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: "Segoe UI", Arial, sans-serif;
        background: #0b1020;
        color: #f1f5f9;
        min-height: 100vh;
    }

    /* ================= NAVBAR ================= */

    .navbar {
        min-height: 75px;
        padding: 0 7%;
        display: flex;
        align-items: center;
        justify-content: space-between;
        background: #11182b;
        border-bottom: 1px solid #252d45;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        position: relative;
        z-index: 1;
    }

    .logo {
        text-decoration: none;
        font-size: 27px;
        font-weight: 800;
        color: #f8fafc;
        white-space: nowrap;
    }

    .logo span {
        color: #8b72ff;
    }

    .logo-icon {
        margin-right: 8px;
    }

    .nav-links {
        display: flex;
        align-items: center;
        gap: 35px;
    }

    .nav-links a {
        color: #cbd5e1;
        text-decoration: none;
        font-size: 15px;
        transition: color 0.2s;
    }

    .nav-links a:hover {
        color: #a78bfa;
    }

    .nav-icons {
        display: flex;
        gap: 23px;
        align-items: center;
    }

    .nav-icons a {
        text-decoration: none;
        font-size: 22px;
        color: #e2e8f0;
        transition: transform 0.2s, color 0.2s;
    }

    .nav-icons a:hover {
        color: #a78bfa;
        transform: translateY(-2px);
    }

    /* ================= MAIN LAYOUT ================= */

    .main-container {
        min-height: calc(100vh - 75px);
        padding: 55px 7%;
        display: grid;
        grid-template-columns: 1fr 1fr;
        align-items: center;
        gap: 65px;

        background:
            radial-gradient(
                circle at 5% 95%,
                rgba(109, 76, 255, 0.15),
                transparent 35%
            ),
            radial-gradient(
                circle at 95% 5%,
                rgba(59, 130, 246, 0.12),
                transparent 35%
            ),
            #0b1020;
    }

    /* ================= WELCOME SECTION ================= */

    .welcome-section {
        max-width: 500px;
    }

    .store-badge {
        display: inline-block;
        background: rgba(139, 114, 255, 0.15);
        color: #b8a8ff;
        padding: 10px 17px;
        border: 1px solid rgba(139, 114, 255, 0.2);
        border-radius: 30px;
        font-size: 14px;
        font-weight: 600;
        margin-bottom: 25px;
    }

    .welcome-section h1 {
        font-size: clamp(38px, 4vw, 58px);
        line-height: 1.15;
        margin-bottom: 20px;
        letter-spacing: -1.5px;
        color: #f8fafc;
    }

    .welcome-section h1 span {
        color: #8b72ff;
    }

    .welcome-description {
        color: #a5b4cc;
        font-size: 18px;
        line-height: 1.8;
        margin-bottom: 35px;
    }

    .feature {
        display: flex;
        align-items: center;
        gap: 16px;
        margin-bottom: 23px;
    }

    .feature-icon {
        width: 52px;
        height: 52px;
        flex-shrink: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        background: rgba(139, 114, 255, 0.15);
        border: 1px solid rgba(139, 114, 255, 0.12);
        font-size: 23px;
    }

    .feature h3 {
        color: #e2e8f0;
        font-size: 16px;
        margin-bottom: 5px;
    }

    .feature p {
        color: #94a3b8;
        font-size: 14px;
    }

    /* ================= LOGIN CARD ================= */

    .login-card {
        width: 100%;
        max-width: 500px;
        justify-self: center;
        padding: 42px;

        background: rgba(21, 29, 50, 0.95);
        border: 1px solid #29334e;
        border-radius: 24px;

        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        position: relative;
        overflow: hidden;
    }

    .login-card::before {
        content: "";
        position: absolute;
        top: -100px;
        right: -100px;
        width: 200px;
        height: 200px;
        background: rgba(139, 114, 255, 0.07);
        border-radius: 50%;
        pointer-events: none;
    }

    .card-content {
        position: relative;
        z-index: 1;
    }

    .card-icon {
        width: 75px;
        height: 75px;
        margin: 0 auto 18px;

        display: flex;
        justify-content: center;
        align-items: center;

        background: linear-gradient(135deg, #8058f5, #4169ff);
        color: white;
        border-radius: 22px;
        font-size: 35px;

        box-shadow: 0 8px 25px rgba(98, 70, 234, 0.25);
    }

    .login-card h2 {
        text-align: center;
        font-size: 34px;
        margin-bottom: 10px;
        color: #f8fafc;
    }

    .card-description {
        text-align: center;
        color: #a5b4cc;
        font-size: 14px;
        line-height: 1.6;
        margin-bottom: 30px;
    }

    /* ================= FORM ================= */

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        font-size: 14px;
        font-weight: 600;
        margin-bottom: 9px;
        color: #dbe4f0;
    }

    .input-wrapper {
        position: relative;
    }

    .input-icon {
        position: absolute;
        left: 16px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 18px;
        color: #a78bfa;
        pointer-events: none;
    }

    .form-group input {
        width: 100%;
        height: 54px;
        padding: 0 15px 0 47px;

        border: 1px solid #35415d;
        border-radius: 12px;

        background: #0e1629;
        color: #f8fafc;
        font-size: 15px;
        outline: none;

        transition: border-color 0.2s, box-shadow 0.2s;
    }

    .form-group input:focus {
        border-color: #8b72ff;
        box-shadow: 0 0 0 4px rgba(139, 114, 255, 0.12);
    }

    .form-group input::placeholder {
        color: #8290aa;
    }

    /* ================= REMEMBER ME ================= */

    .remember-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 10px;
        margin: 5px 0 25px;
    }

    .remember-option {
        display: flex;
        align-items: center;
        gap: 9px;
        font-size: 14px;
        color: #cbd5e1;
    }

    .remember-option input {
        width: 17px;
        height: 17px;
        accent-color: #8b72ff;
        cursor: pointer;
    }

    .remember-option label {
        cursor: pointer;
    }

    .forgot-link,
    .signup-link {
        color: #a78bfa;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        transition: color 0.2s;
    }

    .forgot-link:hover,
    .signup-link:hover {
        color: #c4b5fd;
        text-decoration: underline;
    }

    /* ================= LOGIN BUTTON ================= */

    .login-button {
        width: 100%;
        height: 55px;

        border: none;
        border-radius: 12px;

        background: linear-gradient(110deg, #9165f6, #4778ff);
        color: #ffffff;

        font-size: 17px;
        font-weight: 700;
        cursor: pointer;

        box-shadow: 0 8px 18px rgba(98, 70, 234, 0.2);
        transition: transform 0.2s, box-shadow 0.2s;
    }

    .login-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 24px rgba(98, 70, 234, 0.28);
    }

    .login-button:active {
        transform: translateY(0);
    }

    /* ================= SIGN UP ================= */

    .signup-section {
        text-align: center;
        margin-top: 28px;
        color: #94a3b8;
        font-size: 14px;
    }

    .signup-section a {
        margin-left: 5px;
    }

    /* ================= ERROR MESSAGE ================= */

    .error-message {
        color: #fca5a5;
        background: rgba(220, 38, 38, 0.1);
        border: 1px solid rgba(248, 113, 113, 0.3);
        border-radius: 9px;
        padding: 11px;
        font-size: 14px;
        margin-bottom: 18px;
        text-align: center;
    }

    /* ================= RESPONSIVE ================= */

    @media (max-width: 900px) {
        .navbar {
            padding: 0 4%;
        }

        .nav-links {
            gap: 15px;
        }

        .main-container {
            padding: 40px 5%;
            gap: 30px;
        }

        .login-card {
            padding: 30px 24px;
        }

        .welcome-section h1 {
            font-size: 40px;
        }
    }

    @media (max-width: 650px) {
        .navbar {
            height: auto;
            min-height: 70px;
            flex-wrap: wrap;
            gap: 12px;
            padding: 15px 5%;
        }

        .logo {
            font-size: 23px;
        }

        .nav-links {
            order: 3;
            width: 100%;
            justify-content: center;
            gap: 22px;
            padding-top: 12px;
            border-top: 1px solid #252d45;
        }

        .nav-links a {
            font-size: 13px;
        }

        .nav-icons {
            gap: 15px;
        }

        .main-container {
            grid-template-columns: 1fr;
            padding: 40px 5%;
            gap: 35px;
        }

        .welcome-section {
            text-align: center;
            margin: auto;
        }

        .welcome-section h1 {
            font-size: 40px;
        }

        .welcome-description {
            font-size: 16px;
        }

        .feature {
            text-align: left;
            max-width: 320px;
            margin: 20px auto;
        }

        .login-card {
            max-width: 450px;
            padding: 30px 22px;
        }

        .login-card h2 {
            font-size: 30px;
        }

        .remember-row {
            flex-wrap: wrap;
        }
    }

    @media (max-width: 360px) {
        .nav-links {
            gap: 12px;
        }

        .nav-links a {
            font-size: 12px;
        }

        .remember-row {
            align-items: flex-start;
            flex-direction: column;
        }
    }
</style>
</head>

<body>

    <!-- ================= NAVBAR ================= -->

    <header class="navbar">

        <a href="<%= request.getContextPath() %>/home.jsp"
           class="logo">
            <span class="logo-icon">🛍</span> Shop<span>Easy</span>
        </a>

        <nav class="nav-links">
            <a href="<%= request.getContextPath() %>/home.jsp">
                Home
            </a>

            <a href="<%= request.getContextPath() %>/home.jsp">
                Products
            </a>

            <a href="<%= request.getContextPath() %>/home.jsp">
                Categories
            </a>
        </nav>

        <div class="nav-icons">

            <a href="<%= request.getContextPath() %>/cart.jsp"
               aria-label="Shopping cart"
               title="Shopping Cart">
                🛒
            </a>

            <a href="<%= request.getContextPath() %>/login.jsp"
               aria-label="Account"
               title="Account">
                👤
            </a>

        </div>

    </header>

    <!-- ================= MAIN CONTENT ================= -->

    <main class="main-container">

        <!-- Welcome Section -->

        <section class="welcome-section">

            <div class="store-badge">
                🛒 &nbsp; Your Favorite Store
            </div>

            <h1>
                Welcome <span>Back!</span>
            </h1>

            <p class="welcome-description">
                Log in to your account and continue
                shopping your favorite products.
            </p>

            <div class="feature">

                <div class="feature-icon">🚚</div>

                <div>
                    <h3>Fast & Reliable Delivery</h3>
                    <p>Get your orders at your door</p>
                </div>

            </div>

            <div class="feature">

                <div class="feature-icon">🛡️</div>

                <div>
                    <h3>Secure Shopping</h3>
                    <p>Your data is always protected</p>
                </div>

            </div>

            <div class="feature">

                <div class="feature-icon">💜</div>

                <div>
                    <h3>Best Deals & Offers</h3>
                    <p>Shop more, save more</p>
                </div>

            </div>

        </section>

        <!-- Login Card -->

        <section class="login-card">

            <div class="card-content">

                <div class="card-icon">🛍</div>

                <h2>Login</h2>

                <p class="card-description">
                    Enter your credentials to access your account
                </p>
					<% if (!message.isEmpty()) { %>
					
					    <div class="error-message">
					        <%= message %>
					    </div>
					
					<% } %>

                <!-- Login Form -->
					<form action=""  method="post">
                

                    <div class="form-group">

                        <label for="username">Username</label>

                        <div class="input-wrapper">

                            <span class="input-icon">👤</span>

                            <input
                                type="text"
                                id="username"
                                name="username"
                                placeholder="Enter your username"
                                autocomplete="username"
                                value="<%= cookieUserName %>"
                                required>

                        </div>

                    </div>

                    <div class="form-group">

                        <label for="password">Password</label>

                        <div class="input-wrapper">

                            <span class="input-icon">🔒</span>

                            <input
                                type="password"
                                id="password"
                                name="password"
                                placeholder="Enter your password"                                
                                autocomplete="current-password"
                                required>

                        </div>

                    </div>

                    <div class="remember-row">

                        <div class="remember-option">

                            <input
                                type="checkbox"
                                id="rememberMe"
                                name="rememberMe"
                                value="true">

                            <label for="rememberMe">
                                Remember me
                            </label>

                        </div>

                        

                    </div>

                    <button type="submit" class="login-button">
                        Login &nbsp; →
                    </button>

                </form>

                <!-- Register Link -->

                <div class="signup-section">

                    Don't have an account?

                    <a
                        href="<%= request.getContextPath() %>/pages/register.html"
                        class="signup-link">
                        Sign up
                    </a>

                </div>

            </div>

        </section>

    </main>

</body>
</html>
