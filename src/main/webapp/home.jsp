
<%@ page import="java.util.Optional" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="classes.User" %>

<%
    String userName = request.getParameter("username");

    boolean rememberAccount = request.getParameter("rememberMe") != null;

    if (rememberAccount && userName != null && !userName.trim().isEmpty()) {
        Cookie cookie = new Cookie("RememberAccount", userName.trim());

        cookie.setMaxAge(20);
        cookie.setPath(request.getContextPath().isEmpty()
            ? "/" : request.getContextPath());

        response.addCookie(cookie);
    }

    User user = (User) session.getAttribute("loggedInUser");

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
<title>ShopEasy | Products</title>

<style>

    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    /* ================= GENERAL ================= */

    body {
        font-family: Arial, sans-serif;
        min-height: 100vh;
        transition: background 0.3s, color 0.3s;
    }

    /* ================= DARK MODE ================= */

    body.dark-mode {
        background: #0f172a;
        color: #f1f5f9;
    }

    body.dark-mode .navbar {
        background: #111c32;
        border-bottom: 1px solid #263449;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
    }

    body.dark-mode .logo {
        color: #f8fafc;
    }

    body.dark-mode .logo span:last-child {
        color: #60a5fa;
    }

    body.dark-mode .nav-links a {
        color: #cbd5e1;
    }

    body.dark-mode .nav-links a:hover {
        color: #60a5fa;
    }

    body.dark-mode .nav-links a::after {
        background: #60a5fa;
    }

    body.dark-mode .nav-icons a {
        border: 1px solid #334155;
        background: #1e293b;
        color: #e2e8f0;
    }

    body.dark-mode .nav-icons a:hover {
        background: #263b5b;
        border-color: #60a5fa;
    }

    body.dark-mode .page-title p,
    body.dark-mode .description,
    body.dark-mode .total-label {
        color: #94a3b8;
    }

    body.dark-mode .card {
        background: #1e293b;
        border: 1px solid #334155;
    }

    body.dark-mode .card:hover {
        border-color: #60a5fa;
    }

    body.dark-mode .product-image {
        background: #263449;
    }

    body.dark-mode .price,
    body.dark-mode #total {
        color: #4ade80;
    }

    body.dark-mode .add-btn {
        background: #3b82f6;
        color: white;
    }

    body.dark-mode .add-btn:hover {
        background: #2563eb;
    }

    body.dark-mode .checkout {
        background: #1e293b;
        border: 1px solid #334155;
    }

    body.dark-mode .buy-btn {
        background: #16a34a;
        color: white;
    }

    body.dark-mode .buy-btn:hover:not(:disabled) {
        background: #15803d;
    }

    body.dark-mode .buy-btn:disabled {
        background: #475569;
    }

    body.dark-mode .nav-links {
        border-color: #263449;
    }

    /* ================= LIGHT MODE ================= */

    body.light-mode {
        background: #f8fafc;
        color: #1e293b;
    }

    body.light-mode .navbar {
        background: #ffffff;
        border-bottom: 1px solid #e2e8f0;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
    }

    body.light-mode .logo {
        color: #1e293b;
    }

    body.light-mode .logo span:last-child {
        color: #2563eb;
    }

    body.light-mode .nav-links a {
        color: #475569;
    }

    body.light-mode .nav-links a:hover {
        color: #2563eb;
    }

    body.light-mode .nav-links a::after {
        background: #2563eb;
    }

    body.light-mode .nav-icons a {
        border: 1px solid #e2e8f0;
        background: #f1f5f9;
        color: #334155;
    }

    body.light-mode .nav-icons a:hover {
        background: #dbeafe;
        border-color: #60a5fa;
    }

    body.light-mode .page-title p,
    body.light-mode .description,
    body.light-mode .total-label {
        color: #64748b;
    }

    body.light-mode .card {
        background: #ffffff;
        border: 1px solid #e2e8f0;
    }

    body.light-mode .card:hover {
        border-color: #60a5fa;
    }

    body.light-mode .product-image {
        background: #eff6ff;
    }

    body.light-mode .price,
    body.light-mode #total {
        color: #16a34a;
    }

    body.light-mode .add-btn {
        background: #2563eb;
        color: white;
    }

    body.light-mode .add-btn:hover {
        background: #1d4ed8;
    }

    body.light-mode .checkout {
        background: #ffffff;
        border: 1px solid #e2e8f0;
    }

    body.light-mode .buy-btn {
        background: #16a34a;
        color: white;
    }

    body.light-mode .buy-btn:hover:not(:disabled) {
        background: #15803d;
    }

    body.light-mode .buy-btn:disabled {
        background: #94a3b8;
    }

    body.light-mode .nav-links {
        border-color: #e2e8f0;
    }

    /* ================= NAVBAR ================= */

    .navbar {
        min-height: 76px;
        padding: 0 7%;

        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 30px;

        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .logo {
        display: inline-flex;
        align-items: center;
        gap: 7px;

        text-decoration: none;
        font-size: 26px;
        font-weight: 800;
        white-space: nowrap;
    }

    .logo-icon {
        font-size: 25px;
    }

    .nav-links {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 32px;
    }

    .nav-links a {
        position: relative;
        padding: 10px 0;

        text-decoration: none;
        font-size: 15px;
        font-weight: 600;

        transition: color 0.25s ease;
    }

    .nav-links a::after {
        content: "";
        position: absolute;
        left: 0;
        bottom: 3px;

        width: 0;
        height: 2px;
        border-radius: 2px;

        transition: width 0.25s ease;
    }

    .nav-links a:hover::after {
        width: 100%;
    }

    .nav-icons {
        display: flex;
        align-items: center;
        gap: 14px;
    }

    .nav-icons a {
        min-width: 44px;
        height: 44px;
        padding: 0 10px;

        display: flex;
        align-items: center;
        justify-content: center;
        gap: 7px;

        border-radius: 12px;

        text-decoration: none;
        font-size: 21px;

        transition:
            background 0.25s ease,
            border-color 0.25s ease,
            transform 0.25s ease;
    }

    .nav-icons a:hover {
        transform: translateY(-2px);
    }

    #cart-count {
        min-width: 20px;
        height: 20px;
        padding: 0 5px;

        display: inline-flex;
        align-items: center;
        justify-content: center;

        background: #3b82f6;
        color: white;
        border-radius: 50%;
        font-size: 11px;
        font-weight: bold;
    }

    /* ================= MAIN LAYOUT ================= */

    main {
        max-width: 1200px;
        margin: 35px auto;
        padding: 0 20px 40px;
    }

    .page-title {
        margin-bottom: 25px;
    }

    .page-title h2 {
        font-size: 28px;
        margin-bottom: 8px;
    }

    .page-title p {
        line-height: 1.6;
    }

    /* ================= PRODUCTS ================= */

    .products {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 22px;
    }

    .card {
        overflow: hidden;
        border-radius: 14px;

        transition:
            transform 0.25s,
            border-color 0.25s;
    }

    .card:hover {
        transform: translateY(-5px);
    }

    .product-image {
        height: 150px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 65px;
    }

    .card-content {
        padding: 20px;
    }

    .card h3 {
        font-size: 18px;
        margin-bottom: 10px;
    }

    .description {
        min-height: 40px;
        font-size: 13px;
        line-height: 1.5;
        margin-bottom: 15px;
    }

    .price {
        font-size: 21px;
        font-weight: bold;
        margin-bottom: 17px;
    }

    .add-btn {
        width: 100%;
        padding: 11px;

        border: none;
        border-radius: 8px;

        font-size: 14px;
        font-weight: bold;
        cursor: pointer;

        transition: background 0.2s;
    }

    /* ================= CHECKOUT ================= */

    .checkout {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;

        margin-top: 30px;
        padding: 25px;

        border-radius: 14px;
    }

    .total-label {
        margin-bottom: 8px;
    }

    #total {
        font-size: 27px;
        font-weight: bold;
    }

    .buy-btn {
        padding: 13px 28px;

        border: none;
        border-radius: 8px;

        font-size: 15px;
        font-weight: bold;
        cursor: pointer;
    }

    .buy-btn:disabled {
        cursor: not-allowed;
    }

    /* ================= RESPONSIVE ================= */

    @media (max-width: 900px) {

        .navbar {
            padding: 16px 4%;
            gap: 18px;
        }

        .nav-links {
            gap: 20px;
        }

        .products {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }
    }

    @media (max-width: 560px) {

        .navbar {
            justify-content: space-between;
            gap: 14px;
        }

        .logo {
            font-size: 22px;
        }

        .nav-links {
            order: 3;
            width: 100%;
            justify-content: center;
            gap: 24px;
            padding-top: 12px;
            border-top: 1px solid;
        }

        .nav-links a {
            font-size: 14px;
        }

        .nav-icons {
            gap: 8px;
        }

        .nav-icons a {
            min-width: 39px;
            height: 39px;
            padding: 0 7px;
        }

        main {
            margin-top: 28px;
            padding: 0 15px 30px;
        }

        .page-title h2 {
            font-size: 23px;
        }

        .products {
            grid-template-columns: 1fr;
        }

        .checkout {
            padding: 20px;
        }

        .buy-btn {
            width: 100%;
        }
    }

    @media (max-width: 360px) {

        .nav-links {
            gap: 15px;
        }

        .nav-links a {
            font-size: 12px;
        }
    }

</style>
</head>

<body class="<%= themeClass %>">

<!-- ================= NAVBAR ================= -->

<header class="navbar">

    <a href="<%= request.getContextPath() %>/home.jsp"
       class="logo">

        <span class="logo-icon">🛍</span>
        Shop<span>Easy</span>

    </a>

    <nav class="nav-links">

        <a href="<%= request.getContextPath() %>/home.jsp">Home</a>

        <a href="<%= request.getContextPath() %>/products.jsp">Products</a>

        <a href="<%= request.getContextPath() %>/setting.jsp">Settings</a>

    </nav>

    <div class="nav-icons">

        <a href="<%= request.getContextPath() %>/cart.jsp"
           aria-label="Shopping cart"
           title="Shopping Cart">

            🛒 <span id="cart-count">0</span>

        </a>

        <a href="<%= request.getContextPath() %>/pages/register.html"
           aria-label="Account settings"
           title="Account Settings">

            👤

        </a>

    </div>

</header>

<!-- ================= MAIN CONTENT ================= -->

<main>

    <section class="page-title">

        <h2>Our Products</h2>

        <p>Discover our products and add your favorites to the cart.</p>

    </section>

    <section class="products">

        <div class="card">

            <div class="product-image">🎧</div>

            <div class="card-content">

                <h3>Wireless Headphones</h3>

                <p class="description">
                    High-quality sound and comfortable design.
                </p>

                <p class="price">$75.00</p>

                <button class="add-btn" onclick="addToCart(75)">
                    Add to Cart
                </button>

            </div>

        </div>

        <div class="card">

            <div class="product-image">⌚</div>

            <div class="card-content">

                <h3>Smart Watch</h3>

                <p class="description">
                    Track your activity and daily notifications.
                </p>

                <p class="price">$120.00</p>

                <button class="add-btn" onclick="addToCart(120)">
                    Add to Cart
                </button>

            </div>

        </div>

        <div class="card">

            <div class="product-image">📱</div>

            <div class="card-content">

                <h3>Smartphone</h3>

                <p class="description">
                    A powerful phone for everyday use.
                </p>

                <p class="price">$450.00</p>

                <button class="add-btn" onclick="addToCart(450)">
                    Add to Cart
                </button>

            </div>

        </div>

        <div class="card">

            <div class="product-image">⌨️</div>

            <div class="card-content">

                <h3>Mechanical Keyboard</h3>

                <p class="description">
                    Responsive keys for work and gaming.
                </p>

                <p class="price">$65.00</p>

                <button class="add-btn" onclick="addToCart(65)">
                    Add to Cart
                </button>

            </div>

        </div>

        <div class="card">

            <div class="product-image">🖱️</div>

            <div class="card-content">

                <h3>Wireless Mouse</h3>

                <p class="description">
                    Precise control with a comfortable grip.
                </p>

                <p class="price">$35.00</p>

                <button class="add-btn" onclick="addToCart(35)">
                    Add to Cart
                </button>

            </div>

        </div>

        <div class="card">

            <div class="product-image">🎒</div>

            <div class="card-content">

                <h3>Travel Backpack</h3>

                <p class="description">
                    A practical backpack for work and travel.
                </p>

                <p class="price">$50.00</p>

                <button class="add-btn" onclick="addToCart(50)">
                    Add to Cart
                </button>

            </div>

        </div>

    </section>

    <section class="checkout">

        <div>

            <p class="total-label">Total Cost</p>

            <p id="total">$0.00</p>

        </div>

        <button id="buy-btn"
                class="buy-btn"
                onclick="buyProducts()"
                disabled>

            Buy Now

        </button>

    </section>

</main>

<script>

    let total = 0;
    let cartCount = 0;

    function addToCart(price) {

        total += price;
        cartCount++;

        document.getElementById("total").textContent =
            "$" + total.toFixed(2);

        document.getElementById("cart-count").textContent =
            cartCount;

        document.getElementById("buy-btn").disabled = false;
    }

    function buyProducts() {

        if (cartCount === 0) {
            return;
        }

        alert(
            "Order total: $" + total.toFixed(2) +
            "\nItems: " + cartCount +
            "\nCheckout is a demo."
        );
    }

</script>

</body>
</html>
