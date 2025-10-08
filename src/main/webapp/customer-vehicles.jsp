<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Vehicles - CarRent</title>
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
        .car-card {
            background: var(--white);
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            position: relative;
        }
        [data-theme="dark"] .car-card {
            background: var(--primary-color);
        }
        .car-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }
        .car-card img {
            height: 200px;
            object-fit: cover;
            width: 100%;
        }
        .card-body {
            padding: 1.5rem;
        }
        .car-name {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        .car-model {
            color: #6b7280;
            margin-bottom: 0.5rem;
        }
        [data-theme="dark"] .car-model {
            color: #9ca3af;
        }
        .availability-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            padding: 0.25rem 0.75rem;
            border-radius: 1rem;
            font-size: 0.75rem;
            font-weight: 500;
        }
        .available { background: #10b981; color: white; }
        .booked { background: #ef4444; color: white; }
        .price {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--accent-color);
            margin-bottom: 1rem;
        }
        .favorite-btn {
            position: absolute;
            top: 1rem;
            left: 1rem;
            background: rgba(255,255,255,0.8);
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
        [data-theme="dark"] .favorite-btn {
            background: rgba(30,41,59,0.8);
        }
        .favorite-btn:hover {
            background: var(--accent-color);
            color: white;
        }
        .favorite-btn.favorited {
            background: var(--accent-color);
            color: white;
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
        .filters-section {
            background: var(--white);
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
        }
        [data-theme="dark"] .filters-section {
            background: var(--primary-color);
        }
        .form-control, .form-select {
            border: 1px solid #d1d5db;
            border-radius: 0.5rem;
            padding: 0.75rem;
        }
        [data-theme="dark"] .form-control, [data-theme="dark"] .form-select {
            background: var(--primary-color);
            border-color: #374151;
            color: #f1f5f9;
        }
        .checkbox-group {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .checkbox-item {
            display: flex;
            align-items: center;
        }
        .checkbox-item input {
            margin-right: 0.5rem;
        }
        .promo-card {
            background: linear-gradient(135deg, var(--accent-color), #1d4ed8);
            color: white;
            padding: 2rem;
            border-radius: 1rem;
            text-align: center;
            margin-bottom: 2rem;
        }
        .promo-card h3 {
            margin-bottom: 1rem;
        }
        .promo-card p {
            margin-bottom: 1.5rem;
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
        <li><a href="<c:choose><c:when test="${sessionScope.role == 'admin'}">AdminServlet</c:when><c:otherwise>HomeServlet?page=customer-dashboard</c:otherwise></c:choose>"><i class="fas fa-tachometer-alt"></i><c:choose><c:when test="${sessionScope.role == 'admin'}">Admin Panel</c:when><c:otherwise>Dashboard</c:otherwise></c:choose></a></li>
        <li><a href="HomeServlet?page=customer-vehicles" class="active"><i class="fas fa-car"></i>Vehicles</a></li>
        <li><a href="HomeServlet?page=customer-booking"><i class="fas fa-calendar-check"></i>My Bookings</a></li>
        <li><a href="#favorites"><i class="fas fa-heart"></i>Favorites</a></li>
        <li><a href="HomeServlet?page=customer-promotions"><i class="fas fa-tags"></i>Promotions</a></li>
        <li><a href="HomeServlet?page=customer-feedback"><i class="fas fa-star"></i>Feedback</a></li>
        <li><a href="#settings"><i class="fas fa-cog"></i>Settings</a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Promo Card -->
    <div class="promo-card">
        <h3>We are a team! Join and earn now</h3>
        <p>Become a driver partner and start earning with flexible hours and competitive rates.</p>
        <button class="btn btn-light">Join Now</button>
    </div>

    <!-- Header -->
    <div style="margin-bottom: 2rem;">
        <h1 style="margin-bottom: 0.5rem;">Available Vehicles</h1>
        <p style="color: #6b7280;">Choose from our wide selection of vehicles for your journey</p>
    </div>
    
    <!-- Search Form -->
    <div class="filters-section" style="margin-bottom: 2rem;">
        <h4 style="margin-bottom: 1.5rem;">Search & Book Vehicle</h4>
        <form action="HomeServlet" method="get" class="row g-3">
            <input type="hidden" name="page" value="customer-vehicles">
            <div class="col-md-3">
                <label class="form-label">Pickup Date</label>
                <input type="date" class="form-control" name="pickupDate" value="${param.pickupDate}" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Return Date</label>
                <input type="date" class="form-control" name="returnDate" value="${param.returnDate}" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Vehicle Type</label>
                <select class="form-select" name="vehicleType">
                    <option value="">All Types</option>
                    <option value="Sedan" ${param.vehicleType == 'Sedan' ? 'selected' : ''}>Sedan</option>
                    <option value="SUV" ${param.vehicleType == 'SUV' ? 'selected' : ''}>SUV</option>
                    <option value="Luxury SUV" ${param.vehicleType == 'Luxury SUV' ? 'selected' : ''}>Luxury SUV</option>
                    <option value="Van" ${param.vehicleType == 'Van' ? 'selected' : ''}>Van</option>
                </select>
            </div>
            <div class="col-md-3 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100">Search Vehicles</button>
            </div>
        </form>
    </div>
    
    <!-- Filters -->
<div class="filters-section">
    <h4 style="margin-bottom: 1.5rem;">Filters</h4>
    <div class="row g-3">
        <div class="col-12 col-md-3">
            <label class="form-label">Brand & Model</label>
            <select id="filterBrandModel" class="form-select">
                <option value="">All Brands & Models</option>
                <option value="Toyota Camry">Toyota Camry</option>
                <option value="Honda Civic">Honda Civic</option>
                <option value="Ford Mustang">Ford Mustang</option>
                <option value="BMW X5">BMW X5</option>
                <!-- Add more options as needed -->
            </select>
        </div>
        <div class="col-12 col-md-3">
            <label class="form-label">Price Range (per day)</label>
            <div style="display: flex; align-items: center; gap: 0.5rem;">
                <span>$</span>
                <input id="filterMinPrice" type="number" min="0" step="1" class="form-control" placeholder="Min">
                <span>-</span>
                <input id="filterMaxPrice" type="number" min="0" step="1" class="form-control" placeholder="Max">
            </div>
        </div>
        <div class="col-12 col-md-3">
            <label class="form-label">Car Type</label>
            <div class="checkbox-group">
                <div class="checkbox-item">
                    <input type="checkbox" id="typeSedan" value="Sedan">
                    <label for="typeSedan">Sedan</label>
                </div>
                <div class="checkbox-item">
                    <input type="checkbox" id="typeSUV" value="SUV">
                    <label for="typeSUV">SUV</label>
                </div>
                <div class="checkbox-item">
                    <input type="checkbox" id="typeVan" value="Van">
                    <label for="typeVan">Van</label>
                </div>
                <!-- Add more as needed -->
            </div>
        </div>
        <div class="col-12 col-md-3">
            <label class="form-label">Color</label>
            <div class="checkbox-group">
                <div class="checkbox-item">
                    <input type="checkbox" id="colorBlack" value="Black">
                    <label for="colorBlack">Black</label>
                </div>
                <div class="checkbox-item">
                    <input type="checkbox" id="colorWhite" value="White">
                    <label for="colorWhite">White</label>
                </div>
                <div class="checkbox-item">
                    <input type="checkbox" id="colorBlue" value="Blue">
                    <label for="colorBlue">Blue</label>
                </div>
                <!-- Add more as needed -->
            </div>
        </div>
        <div class="col-12">
            <div class="checkbox-item">
                <input type="checkbox" id="availableOnly">
                <label for="availableOnly">Available now only</label>
            </div>
        </div>
        <div class="col-12 d-flex justify-content-end">
            <button class="btn btn-primary" type="button" onclick="applyFilters()">Apply Filters</button>
        </div>
    </div>
</div>

<!-- Vehicles Grid -->
<div class="row" id="vehicleGrid">
    <c:forEach var="car" items="${carList}">
        <div class="col-lg-4 col-md-6 mb-4 vehicle-item"
              data-type="${car.vehicleType}"
              data-availability="${(car.available == true or car.available == 1) ? 'true' : 'false'}"
              data-price="${car.dailyPrice}">
            <div class="car-card">
                <button class="favorite-btn" onclick="toggleFavorite('${car.vehicleId}')">
                    <i class="far fa-heart"></i>
                </button>
                <span class="availability-badge ${car.available == true or car.available == 1 ? 'available' : 'booked'}">
                    ${car.available == true or car.available == 1 ? 'Available' : 'Booked'}
                </span>
                <img src="${car.imageUrl != null && car.imageUrl != '' ? car.imageUrl : 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400&h=300&fit=crop&crop=center'}" alt="${car.vehicleName}" onerror="this.src='https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400&h=300&fit=crop&crop=center'">
                <div class="card-body">
                    <h5 class="car-name">${car.vehicleName}</h5>
                    <p class="car-model">Model/Year: ${car.vehicleType} 2023</p> <!-- Placeholder for model/year -->
                    <p class="price">Rs${car.dailyPrice} / day</p> <!-- Changed to per hour as per task -->
                    <div style="display: flex; gap: 0.5rem;">
                        <button class="btn btn-primary" onclick="selectVehicle('${car.vehicleId}', '${car.vehicleName}')" ${car.available == true or car.available == 1 ? '' : 'disabled'} style="flex: 1;">
                            ${car.available == true or car.available == 1 ? 'Book Now' : 'Unavailable'}
                        </button>
                        <button class="btn btn-outline-primary" onclick="viewDetails('${car.vehicleId}')" style="flex: 1;">Details</button>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
    <c:if test="${empty carList}">
        <div class="col-12">
            <div style="text-align: center; padding: 3rem; background: var(--white); border-radius: 1rem; box-shadow: var(--shadow);">
                <h4>No vehicles found</h4>
                <p>Please check back later or contact our support team.</p>
            </div>
        </div>
    </c:if>
</div>

<!-- Vehicle Details Modal -->
<div class="modal fade" id="vehicleModal" tabindex="-1" aria-labelledby="vehicleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="vehicleModalLabel">Vehicle Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="vehicleDetails">
                <!-- Vehicle details will be loaded here -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="bookVehicleBtn">Book This Vehicle</button>
            </div>
        </div>
    </div>
</div>

<!-- Booking Modal -->
<div class="modal fade" id="bookingModal" tabindex="-1" aria-labelledby="bookingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="bookingModalLabel">Book Vehicle</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="bookingForm" action="BookingController" method="post">
                    <input type="hidden" name="action" value="create">
                    <input type="hidden" id="selectedVehicleId" name="vehicleId">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Pickup Date</label>
                            <input type="date" class="form-control" name="pickupDate" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Return Date</label>
                            <input type="date" class="form-control" name="returnDate" required>
                        </div>
                        <div class="col-12">
                            <div class="alert alert-info">
                                <strong>Booking Summary:</strong><br>
                                <span id="bookingSummary">Please select dates to see summary.</span>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" form="bookingForm" class="btn btn-primary">Confirm Booking</button>
            </div>
        </div>
    </div>
</div>

</div> <!-- End main-content -->

<!-- Notification Area -->
<div class="position-fixed top-0 end-0 p-3" style="z-index: 11000;">
    <div id="notify" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
            <strong class="me-auto">CarGO</strong>
            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body" id="notifyText">
            Notification message here
        </div>
    </div>
</div>

<!-- Vehicle Details Modal -->
<div class="modal fade" id="vehicleModal" tabindex="-1" aria-labelledby="vehicleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="vehicleModalLabel">Vehicle Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="vehicleDetails">
                <!-- Vehicle details will be loaded here -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="bookVehicleBtn">Book This Vehicle</button>
            </div>
        </div>
    </div>
</div>

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
        if (!profile.contains(event.target)) {
            dropdown.classList.remove('show');
        }
    });

    // Favorite Toggle
    function toggleFavorite(vehicleId) {
        // In a real app, this would send an AJAX request to save/remove favorite
        const btn = event.target.closest('.favorite-btn');
        const icon = btn.querySelector('i');
        if (icon.classList.contains('far')) {
            icon.classList.remove('far');
            icon.classList.add('fas');
            btn.classList.add('favorited');
        } else {
            icon.classList.remove('fas');
            icon.classList.add('far');
            btn.classList.remove('favorited');
        }
    }

    function applyFilters() {
        const brandModel = document.getElementById('filterBrandModel')?.value || '';
        const minPrice = parseFloat(document.getElementById('filterMinPrice')?.value || '0');
        const maxPrice = parseFloat(document.getElementById('filterMaxPrice')?.value || 'Infinity');
        const availableOnly = document.getElementById('availableOnly')?.checked || false;

        // Get selected car types
        const selectedTypes = [];
        document.querySelectorAll('input[id^="type"]:checked').forEach(cb => selectedTypes.push(cb.value));

        // Get selected colors
        const selectedColors = [];
        document.querySelectorAll('input[id^="color"]:checked').forEach(cb => selectedColors.push(cb.value));

        document.querySelectorAll('#vehicleGrid .vehicle-item').forEach(function(card){
            const name = card.querySelector('.car-name')?.textContent || '';
            const type = card.getAttribute('data-type') || '';
            const availability = card.getAttribute('data-availability') || '';
            const price = parseFloat(card.getAttribute('data-price') || '0');

            let show = true;

            if (brandModel && !name.toLowerCase().includes(brandModel.toLowerCase())) show = false;
            if (price < minPrice || price > maxPrice) show = false;
            if (availableOnly && availability !== 'true') show = false;
            if (selectedTypes.length > 0 && !selectedTypes.includes(type)) show = false;
            // Note: Color filtering would require color data in the card attributes

            card.style.display = show ? '' : 'none';
        });
    }

    function selectVehicle(id, name){
        // Open booking modal with selected vehicle
        document.getElementById('selectedVehicleId').value = id;
        document.getElementById('bookingModalLabel').textContent = 'Book ' + name;
        const modal = new bootstrap.Modal(document.getElementById('bookingModal'));
        modal.show();
    }

    function viewDetails(vehicleId){
        // For now, just show basic info. In a real app, you'd fetch detailed info via AJAX
        const modal = new bootstrap.Modal(document.getElementById('vehicleModal'));
        document.getElementById('vehicleDetails').innerHTML = `
            <div class="text-center">
                <h4>Vehicle ID: ${vehicleId}</h4>
                <p>Detailed vehicle information would be loaded here via AJAX call to the server.</p>
                <p>This could include specifications, features, insurance details, etc.</p>
            </div>
        `;
        document.getElementById('bookVehicleBtn').onclick = function() {
            selectVehicle(vehicleId, 'Vehicle #' + vehicleId);
        };
        modal.show();
    }

    // Update booking summary when dates change
    document.getElementById('bookingForm').addEventListener('input', updateBookingSummary);

    function updateBookingSummary() {
        const pickupDate = document.querySelector('input[name="pickupDate"]').value;
        const returnDate = document.querySelector('input[name="returnDate"]').value;
        const vehicleId = document.getElementById('selectedVehicleId').value;

        if (pickupDate && returnDate && vehicleId) {
            const start = new Date(pickupDate);
            const end = new Date(returnDate);
            const days = Math.ceil((end - start) / (1000 * 60 * 60 * 24));

            if (days > 0) {
                // Find the vehicle price from the carList
                const carCards = document.querySelectorAll('.vehicle-item');
                let dailyPrice = 0;
                carCards.forEach(card => {
                    if (card.querySelector('.btn').onclick.toString().includes(vehicleId)) {
                        const priceText = card.querySelector('.price').textContent;
                        dailyPrice = parseFloat(priceText.replace('$', '').split('/')[0]);
                    }
                });
                const totalCost = days * dailyPrice;

                document.getElementById('bookingSummary').innerHTML = `
                    Duration: ${days} days<br>
                    Daily Rate: $${dailyPrice}<br>
                    <strong>Total Cost: $${totalCost.toFixed(2)}</strong>
                `;
            } else {
                document.getElementById('bookingSummary').innerHTML = 'Please select valid dates.';
            }
        } else {
            document.getElementById('bookingSummary').innerHTML = 'Please select dates to see summary.';
        }
    }

    // Notification function
    function showNotification(message) {
        const notifyElement = document.getElementById('notify');
        const notifyText = document.getElementById('notifyText');
        if (notifyElement && notifyText) {
            notifyText.textContent = message;
            const toast = new bootstrap.Toast(notifyElement);
            toast.show();
        }
    }

    // Initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        initTheme();
        document.getElementById('themeToggle').addEventListener('click', toggleTheme);

        // Handle URL parameters for messages
        const urlParams = new URLSearchParams(window.location.search);

        if (urlParams.get('login') === '1') {
            showNotification('Login successful! Welcome back.');
        }

        if (urlParams.get('successMsg')) {
            showNotification(decodeURIComponent(urlParams.get('successMsg')));
        }

        if (urlParams.get('errorMsg')) {
            showNotification('Error: ' + decodeURIComponent(urlParams.get('errorMsg')));
        }
    });
</script>
</body>
</html>