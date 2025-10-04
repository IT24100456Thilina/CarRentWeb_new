<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #161d3d;
            --accent-color: #3a80f4;
            --neutral-gray: #ececec;
            --white: #ffffff;
            --shadow: 0 4px 6px rgba(0,0,0,0.1);
            --shadow-hover: 0 8px 25px rgba(0,0,0,0.15);
        }
        [data-theme="dark"] {
            --primary-color: #1e293b;
            --neutral-gray: #374151;
            --white: #1f2937;
        }
        * { box-sizing: border-box; }
        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--neutral-gray);
            color: var(--primary-color);
            margin: 0;
            padding: 0;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        [data-theme="dark"] body {
            background-color: #0f172a;
            color: #f1f5f9;
        }
        .header {
            background: var(--white);
            padding: 1rem 2rem;
            box-shadow: var(--shadow);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
        }
        [data-theme="dark"] .header {
            background: var(--primary-color);
        }
        .sidebar {
            position: fixed;
            top: 80px;
            left: 0;
            width: 250px;
            height: calc(100vh - 80px);
            background: var(--white);
            box-shadow: var(--shadow);
            padding: 2rem 1rem;
            overflow-y: auto;
        }
        [data-theme="dark"] .sidebar {
            background: var(--primary-color);
        }
        .sidebar-nav {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .sidebar-nav li {
            margin-bottom: 1rem;
        }
        .sidebar-nav a {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            color: var(--primary-color);
            text-decoration: none;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
        }
        [data-theme="dark"] .sidebar-nav a {
            color: #f1f5f9;
        }
        .sidebar-nav a:hover, .sidebar-nav a.active {
            background: var(--accent-color);
            color: var(--white);
        }
        .sidebar-nav i {
            margin-right: 0.75rem;
            width: 20px;
        }
        .main-content {
            margin-left: 250px;
            margin-top: 80px;
            padding: 2rem;
        }
        .hero {
            background: linear-gradient(135deg, var(--accent-color), #1d4ed8),
                        url('https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=1920&h=1080&fit=crop&crop=center') center/cover no-repeat;
            color: white;
            border-radius: 1rem;
            box-shadow: var(--shadow-hover);
            padding: 3rem 2rem;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }
        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.3);
            z-index: 1;
        }
        .hero > * {
            position: relative;
            z-index: 2;
        }
        .hero h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .hero p {
            font-size: 1.125rem;
            margin-bottom: 2rem;
        }
        .dashboard-card {
            background: var(--white);
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            text-align: center;
            padding: 2rem 1.5rem;
        }
        [data-theme="dark"] .dashboard-card {
            background: var(--primary-color);
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }
        .card-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: var(--accent-color);
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        .card-text {
            color: #6b7280;
            margin-bottom: 1.5rem;
        }
        [data-theme="dark"] .card-text {
            color: #9ca3af;
        }
        .btn-primary {
            background: var(--accent-color);
            border: none;
            border-radius: 0.5rem;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(58,128,244,0.4);
        }
        .stats-card {
            background: var(--white);
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: var(--shadow);
            text-align: center;
        }
        [data-theme="dark"] .stats-card {
            background: var(--primary-color);
        }
        .stats-card h3 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        .stats-card p {
            color: #6b7280;
            margin: 0;
        }
        [data-theme="dark"] .stats-card p {
            color: #9ca3af;
        }
        .theme-toggle {
            background: var(--neutral-gray);
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        [data-theme="dark"] .theme-toggle {
            background: #374151;
        }
        .theme-toggle:hover {
            background: var(--accent-color);
            color: white;
        }
        .user-profile {
            display: flex;
            align-items: center;
            cursor: pointer;
        }
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--accent-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            margin-right: 0.75rem;
        }
        .user-dropdown {
            position: relative;
        }
        .user-dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background: var(--white);
            border-radius: 0.5rem;
            box-shadow: var(--shadow);
            min-width: 200px;
            display: none;
        }
        [data-theme="dark"] .user-dropdown-menu {
            background: var(--primary-color);
        }
        .user-dropdown-menu.show {
            display: block;
        }
        .user-dropdown-menu a {
            display: block;
            padding: 0.75rem 1rem;
            color: var(--primary-color);
            text-decoration: none;
            border-bottom: 1px solid var(--neutral-gray);
        }
        [data-theme="dark"] .user-dropdown-menu a {
            color: #f1f5f9;
            border-color: #374151;
        }
        .user-dropdown-menu a:last-child {
            border-bottom: none;
        }
        .user-dropdown-menu a:hover {
            background: var(--neutral-gray);
        }
        [data-theme="dark"] .user-dropdown-menu a:hover {
            background: #374151;
        }
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: static;
                box-shadow: none;
                padding: 1rem;
            }
            .main-content {
                margin-left: 0;
                margin-top: 0;
                padding: 1rem;
            }
            .header {
                padding: 1rem;
            }
            .hero {
                padding: 2rem 1rem;
            }
            .hero h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>

<!-- Header -->
<div class="header">
    <div>
        <h2 style="margin: 0; color: var(--primary-color);">CarRent</h2>
    </div>
    <div style="display: flex; align-items: center; gap: 1rem;">
        <button class="theme-toggle" id="themeToggle">
            <i class="fas fa-moon" id="themeIcon"></i>
        </button>
        <c:if test="${not empty sessionScope.username}">
            <div class="user-profile" onclick="toggleUserDropdown()">
                <div class="user-avatar">
                    <i class="fas fa-user"></i>
                </div>
                <span>${sessionScope.userFullName}</span>
                <i class="fas fa-chevron-down" style="margin-left: 0.5rem;"></i>
                <div class="user-dropdown-menu" id="userDropdown">
                    <span style="padding: 0.75rem 1rem; display: block; color: #6b7280; font-size: 0.875rem;">Role: ${sessionScope.role}</span>
                    <a href="AuthController?action=logout">Logout</a>
                </div>
            </div>
        </c:if>
    </div>
</div>

<!-- Sidebar -->
<div class="sidebar">
    <ul class="sidebar-nav">
        <li><a href="HomeServlet"><i class="fas fa-home"></i>Home</a></li>
        <li><a href="<c:choose><c:when test="${sessionScope.role == 'admin'}">AdminServlet</c:when><c:otherwise>HomeServlet?page=customer-dashboard</c:otherwise></c:choose>" class="active"><i class="fas fa-tachometer-alt"></i><c:choose><c:when test="${sessionScope.role == 'admin'}">Admin Panel</c:when><c:otherwise>Dashboard</c:otherwise></c:choose></a></li>
        <li><a href="HomeServlet?page=customer-vehicles"><i class="fas fa-car"></i>Vehicles</a></li>
        <li><a href="HomeServlet?page=customer-booking"><i class="fas fa-calendar-check"></i>My Bookings</a></li>
        <li><a href="HomeServlet?page=customer-promotions"><i class="fas fa-tags"></i>Special Offers</a></li>
        <li><a href="HomeServlet?page=customer-payment"><i class="fas fa-credit-card"></i>Payment History</a></li>
        <li><a href="HomeServlet?page=customer-feedback"><i class="fas fa-star"></i>Share Feedback</a></li>
        <li><a href="HomeServlet?page=customer-booking"><i class="fas fa-bolt"></i>Quick Book</a></li>

    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Hero Section -->
    <div class="hero text-center">
        <h1>Welcome back, ${sessionScope.userFullName}!</h1>
        <p>Smart Vehicle Booking & Fleet Management Made Easy</p>
        <div style="display: flex; justify-content: center; gap: 1rem; flex-wrap: wrap;">
            <a href="HomeServlet?page=customer-vehicles" class="btn btn-light">
                <i class="fas fa-car" style="margin-right: 0.5rem;"></i>Browse Vehicles
            </a>
            <a href="HomeServlet?page=customer-booking" class="btn btn-outline-light">
                <i class="fas fa-calendar-check" style="margin-right: 0.5rem;"></i>My Bookings
            </a>
        </div>
    </div>

<!-- Dashboard Cards -->
<div style="margin-bottom: 3rem;">
    <div class="row g-4">
        <!-- Vehicles -->
        <div class="col-lg-4 col-md-6">
            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-car"></i>
                </div>
                <h5 class="card-title">Browse Vehicles</h5>
                <p class="card-text">Explore our wide range of available vehicles for your next journey.</p>
                <a href="HomeServlet?page=customer-vehicles" class="btn btn-primary">
                    <i class="fas fa-search" style="margin-right: 0.5rem;"></i>View Vehicles
                </a>
            </div>
        </div>

        <!-- Bookings -->
        <div class="col-lg-4 col-md-6">
            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h5 class="card-title">My Bookings</h5>
                <p class="card-text">View and manage all your current and past bookings.</p>
                <a href="HomeServlet?page=customer-booking" class="btn btn-primary">
                    <i class="fas fa-list" style="margin-right: 0.5rem;"></i>View Bookings
                </a>
            </div>
        </div>

        <!-- Promotions -->
        <div class="col-lg-4 col-md-6">
            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-tags"></i>
                </div>
                <h5 class="card-title">Special Offers</h5>
                <p class="card-text">Check out our latest promotions and special deals.</p>
                <a href="HomeServlet?page=customer-promotions" class="btn btn-primary">
                    <i class="fas fa-percent" style="margin-right: 0.5rem;"></i>View Promotions
                </a>
            </div>
        </div>

        <!-- Payments -->
        <div class="col-lg-4 col-md-6">
            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-credit-card"></i>
                </div>
                <h5 class="card-title">Payment History</h5>
                <p class="card-text">View your payment history and manage transactions.</p>
                <a href="HomeServlet?page=customer-payment" class="btn btn-primary">
                    <i class="fas fa-history" style="margin-right: 0.5rem;"></i>View Payments
                </a>
            </div>
        </div>

        <!-- Feedback -->
        <div class="col-lg-4 col-md-6">
            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-star"></i>
                </div>
                <h5 class="card-title">Share Feedback</h5>
                <p class="card-text">Help us improve by sharing your experience and suggestions.</p>
                <a href="HomeServlet?page=customer-feedback" class="btn btn-primary">
                    <i class="fas fa-comments" style="margin-right: 0.5rem;"></i>Give Feedback
                </a>
            </div>
        </div>

        <!-- Quick Book -->
        <div class="col-lg-4 col-md-6">
            <div class="dashboard-card">
                <div class="card-icon">
                    <i class="fas fa-bolt"></i>
                </div>
                <h5 class="card-title">Quick Book</h5>
                <p class="card-text">Book a vehicle quickly with our streamlined booking process.</p>
                <a href="HomeServlet?page=customer-booking" class="btn btn-primary">
                    <i class="fas fa-plus" style="margin-right: 0.5rem;"></i>Book Now
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Quick Stats -->
<div>
    <h3 style="text-align: center; margin-bottom: 2rem;">Your Activity Overview</h3>
    <div class="row g-4">
        <div class="col-lg-3 col-md-6">
            <div class="stats-card">
                <div class="card-icon" style="color: var(--accent-color);">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h3>${totalBookings != null ? totalBookings : 0}</h3>
                <p>Total Bookings</p>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="stats-card">
                <div class="card-icon" style="color: #10b981;">
                    <i class="fas fa-dollar-sign"></i>
                </div>
                <h3>$${revenue != null ? revenue : 0}</h3>
                <p>Total Spent</p>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="stats-card">
                <div class="card-icon" style="color: #06b6d4;">
                    <i class="fas fa-clock"></i>
                </div>
                <h3>${activeBookings != null ? activeBookings : 0}</h3>
                <p>Active Bookings</p>
            </div>
        </div>
        <div class="col-lg-3 col-md-6">
            <div class="stats-card">
                <div class="card-icon" style="color: #f59e0b;">
                    <i class="fas fa-car"></i>
                </div>
                <h3>${totalVehicles != null ? totalVehicles : 0}</h3>
                <p>Available Vehicles</p>
            </div>
        </div>
    </div>
</div>

</div> <!-- End main-content -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Theme Management
    function initTheme() {
        const savedTheme = localStorage.getItem('theme') || 'light';
        const html = document.documentElement;
        const themeIcon = document.getElementById('themeIcon');

        if (savedTheme === 'dark') {
            html.setAttribute('data-theme', 'dark');
            themeIcon.className = 'fas fa-sun';
        } else {
            html.removeAttribute('data-theme');
            themeIcon.className = 'fas fa-moon';
        }
    }

    function toggleTheme() {
        const html = document.documentElement;
        const themeIcon = document.getElementById('themeIcon');
        const currentTheme = html.getAttribute('data-theme');

        if (currentTheme === 'dark') {
            html.removeAttribute('data-theme');
            localStorage.setItem('theme', 'light');
            themeIcon.className = 'fas fa-moon';
        } else {
            html.setAttribute('data-theme', 'dark');
            localStorage.setItem('theme', 'dark');
            themeIcon.className = 'fas fa-sun';
        }
    }

    // User Dropdown
    function toggleUserDropdown() {
        const dropdown = document.getElementById('userDropdown');
        dropdown.classList.toggle('show');
    }

    // Close dropdown when clicking outside
    document.addEventListener('click', function(event) {
        const dropdown = document.getElementById('userDropdown');
        const profile = document.querySelector('.user-profile');
        if (profile && !profile.contains(event.target)) {
            dropdown.classList.remove('show');
        }
    });

    // Initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        initTheme();
        document.getElementById('themeToggle').addEventListener('click', toggleTheme);

        // Show login success message
        if (window.location.search.includes('login=1')) {
            alert('Login successful! Welcome back.');
        }
    });
</script>
</body>
</html>