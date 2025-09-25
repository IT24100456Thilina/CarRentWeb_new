<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Car Rental Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding-top: 70px; }
        .brand-primary { color: #0d6efd; }
        .hero { background: linear-gradient(rgba(13,110,253,.6), rgba(13,110,253,.6)), url('images/cars-hero.jpg') center/cover no-repeat; color: #fff; border-radius: .75rem; }
        .hero .display-5 { font-weight: 700; }
        .car-card img { height: 200px; object-fit: cover; }
        .footer { background-color: #0b1a2b; color: #e9f0ff; padding: 40px 0; margin-top: 50px; }
        .footer a { color: #b7cffd; text-decoration: none; }
        .stat-card { background: #f8fbff; border: 1px solid #e8f0ff; }
        .section-title { font-weight: 700; color: #0b1a2b; }
        .badge-available { background-color: #198754; }
        .badge-unavailable { background-color: #dc3545; }
    </style>
</head>
<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">CarRent</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#vehicles">Vehicles</a></li>
                <li class="nav-item"><a class="nav-link" href="#booking">Book Now</a></li>
                <li class="nav-item"><a class="nav-link" href="#promotions">Promotions</a></li>
                <li class="nav-item"><a class="nav-link" href="#reports">Reports</a></li>
                <li class="nav-item"><a class="nav-link" href="#contact">Contact Us</a></li>
                <c:choose>
                    <c:when test="${not empty sessionScope.username}">
                        <c:if test="${sessionScope.role == 'admin'}">
                            <li class="nav-item"><a class="nav-link" href="AdminServlet">Admin Panel</a></li>
                        </c:if>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Welcome, ${sessionScope.userFullName}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><span class="dropdown-item-text text-muted">Role: ${sessionScope.role}</span></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="AuthController?action=logout">Logout</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Notifications Area -->
<div class="container mt-3" id="home">
    <div id="notify" class="d-none alert alert-success alert-dismissible fade show" role="alert">
        <span id="notifyText"></span>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    </div>

<!-- Status Alerts -->
<div class="container mt-3">
    <c:if test="${param.registered == '1'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Registration successful. Please log in.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.logout == '1'}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            You have been logged out.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.error == '1'}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            Invalid credentials or role. Please try again.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.errorMsg}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${param.errorMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.admin == '1'}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            Admin mode active. Use the Admin Panel to manage users and bookings.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
</div>

<!-- Hero Section -->
<div class="container mt-4">
    <div class="p-5 hero">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="display-5 mb-3">Drive Your Journey with Ease</h1>
                <p class="lead mb-4">Book cars online anytime, anywhere with secure payments.</p>
                <a href="#booking" class="btn btn-light btn-lg fw-semibold">Book a Car Now</a>
            </div>
        </div>
    </div>
    </div>

<!-- Available Vehicles Section -->
<div class="container mt-5" id="vehicles">
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-3">
        <h2 class="m-0 section-title">Available Vehicles</h2>
        <form class="d-flex gap-2" role="search" onsubmit="event.preventDefault();">
            <input id="searchInput" class="form-control" type="search" placeholder="Search vehicles" aria-label="Search">
            <button class="btn btn-outline-primary" type="button" onclick="applyFilters()">Search</button>
        </form>
    </div>

    <div class="row g-3 mb-3">
        <div class="col-12 col-md-3">
            <select id="filterType" class="form-select">
                <option value="">All Types</option>
                <option value="Sedan">Sedan</option>
                <option value="SUV">SUV</option>
                <option value="Hatchback">Hatchback</option>
                <option value="Van">Van</option>
            </select>
        </div>
        <div class="col-12 col-md-3">
            <select id="filterAvailability" class="form-select">
                <option value="">All Availability</option>
                <option value="true">Available</option>
                <option value="false">Unavailable</option>
            </select>
        </div>
        <div class="col-12 col-md-4">
            <input id="filterMaxPrice" type="number" min="0" step="1" class="form-control" placeholder="Max daily price">
        </div>
        <div class="col-12 col-md-2 d-grid">
            <button class="btn btn-primary" type="button" onclick="applyFilters()">Apply Filters</button>
        </div>
    </div>

    <div class="row" id="vehicleGrid">
        <c:forEach var="car" items="${carList}">
            <div class="col-md-4 mb-4 vehicle-item" data-type="${car.vehicleType}" data-availability="${car.available}" data-price="${car.dailyPrice}">
                <div class="card car-card shadow h-100">
                    <img src="${car.imageUrl}" class="card-img-top" alt="${car.vehicleName}">
                    <div class="card-body d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <h5 class="card-title mb-0">${car.vehicleName}</h5>
                            <span class="badge ${car.available ? 'badge-available' : 'badge-unavailable'}">${car.available ? 'Available' : 'Unavailable'}</span>
                        </div>
                        <p class="text-muted mb-1">Type: ${car.vehicleType}</p>
                        <p class="fw-semibold brand-primary mb-3">$${car.dailyPrice} / day</p>
                        <div class="mt-auto d-grid">
                            <a href="#booking" class="btn btn-primary" onclick="prefillBooking('${car.vehicleId}','${car.vehicleName}')">Select</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty carList}">
            <div class="col-12">
                <div class="alert alert-info">No vehicles found. Please add some cars to the catalogue.</div>
            </div>
        </c:if>
    </div>
</div>

<!-- Customer Hub (visible after customer login) -->
<c:if test="${sessionScope.role == 'customer'}">
<div class="container mt-4">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card shadow h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Make a Reservation</h5>
                    <p class="text-muted">Choose dates and confirm your booking.</p>
                    <div class="mt-auto d-grid"><a class="btn btn-primary" href="#booking">Book Now</a></div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Make a Payment</h5>
                    <p class="text-muted">Pay for an existing booking.</p>
                    <form action="PaymentController" method="post" class="mt-auto">
                        <div class="mb-2"><input name="bookingId" type="number" class="form-control" placeholder="Booking ID" required></div>
                        <div class="mb-2"><input name="amount" type="number" step="0.01" class="form-control" placeholder="Amount" required></div>
                        <div class="mb-2">
                            <select name="paymentMethod" class="form-select" required>
                                <option value="" selected>Payment Method</option>
                                <option>Credit Card</option>
                                <option>Debit Card</option>
                                <option>Cash</option>
                                <option>PayPal</option>
                            </select>
                        </div>
                        <button class="btn btn-outline-primary w-100" type="submit">Pay</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow h-100">
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Leave Feedback</h5>
                    <p class="text-muted">Tell us how your trip went.</p>
                    <form action="FeedbackController" method="post" class="mt-auto">
                        <div class="mb-2"><input name="bookingId" type="number" class="form-control" placeholder="Booking ID (optional)"></div>
                        <div class="mb-2"><select name="rating" class="form-select" required>
                            <option value="" selected>Rating</option>
                            <option value="1">1 - Poor</option>
                            <option value="2">2 - Fair</option>
                            <option value="3">3 - Good</option>
                            <option value="4">4 - Very Good</option>
                            <option value="5">5 - Excellent</option>
                        </select></div>
                        <div class="mb-2"><textarea name="comments" rows="2" class="form-control" placeholder="Comments" required></textarea></div>
                        <button class="btn btn-outline-primary w-100" type="submit">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</c:if>

<!-- Booking Section -->
<div class="container mt-5" id="booking">
    <h2 class="section-title mb-3">Book a Vehicle</h2>
    <div class="row g-4">
        <div class="col-lg-8">
            <form class="card shadow p-4" action="BookingController" method="post" onsubmit="showBooked()">
                <input type="hidden" name="action" value="create">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Pick-up Date</label>
                        <input type="date" class="form-control" name="pickupDate" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Return Date</label>
                        <input type="date" class="form-control" name="returnDate" required>
                    </div>
                    <div class="col-md-8">
                        <label class="form-label">Car Model</label>
                        <select id="bookingCar" class="form-select" name="vehicleId" required>
                            <c:forEach var="car" items="${carList}">
                                <option value="${car.vehicleId}">${car.vehicleName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-4 d-grid align-self-end">
                        <button type="submit" class="btn btn-primary">Confirm Booking</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-lg-4">
            <div class="card stat-card shadow p-4 mb-3">
                <h6 class="text-muted">Secure Payments</h6>
                <p class="mb-0">All transactions are encrypted for your safety.</p>
            </div>
            <div class="card stat-card shadow p-4">
                <h6 class="text-muted">Need help?</h6>
                <p class="mb-0">Contact our support for booking assistance.</p>
            </div>
        </div>
    </div>
</div>

<!-- Promotions Section (customer-friendly cards) -->
<div class="container mt-5" id="promotions">
    <h2 class="section-title mb-3">Promotions</h2>
    <c:choose>
        <c:when test="${not empty promotions}">
            <div class="row g-4">
                <c:forEach var="p" items="${promotions}">
                    <div class="col-md-4">
                        <div class="card h-100 shadow">
                            <div class="card-body">
                                <h5 class="card-title">${p.title}</h5>
                                <p class="card-text">${p.description}</p>
                                <c:if test="${not empty p.badge}"><span class="badge bg-primary">${p.badge}</span></c:if>
                                <c:if test="${not empty p.validTill}"><div class="text-muted mt-2">Valid till: ${p.validTill}</div></c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100 shadow"><div class="card-body">
                        <h5 class="card-title">10% off weekend rentals</h5>
                        <p class="card-text">Book Friday to Sunday and save on your trip.</p>
                    </div></div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 shadow"><div class="card-body">
                        <h5 class="card-title">Special holiday discounts</h5>
                        <p class="card-text">Celebrate with reduced rates during holidays.</p>
                    </div></div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 shadow"><div class="card-body">
                        <h5 class="card-title">Early bird offer</h5>
                        <p class="card-text">Book 14+ days in advance and get extra savings.</p>
                    </div></div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Optional: customers can suggest a promotion -->
    <c:if test="${sessionScope.role == 'customer'}">
        <div class="card shadow mt-4">
            <div class="card-body">
                <h5 class="card-title">Suggest a Promotion</h5>
                <form class="row g-2" method="post" action="PromotionController">
                    <input type="hidden" name="action" value="add">
                    <div class="col-md-3"><input class="form-control" name="title" placeholder="Title" required></div>
                    <div class="col-md-5"><input class="form-control" name="description" placeholder="Description" required></div>
                    <div class="col-md-2"><input class="form-control" name="badge" placeholder="Badge"></div>
                    <div class="col-md-2"><input type="date" class="form-control" name="validTill" placeholder="Valid Till"></div>
                    <div class="col-12">
                        <small class="text-muted">Note: Suggestions are added immediately; admin may adjust later.</small>
                    </div>
                    <div class="col-12 d-grid d-md-block"><button class="btn btn-primary" type="submit">Submit</button></div>
                </form>
            </div>
        </div>
    </c:if>
</div>

<!-- Reports Section -->
<div class="container mt-5" id="reports">
    <h2 class="section-title mb-3">Reports</h2>
    <div class="row g-3">
        <div class="col-md-4">
            <div class="card stat-card shadow p-4 text-center">
                <div class="display-6 brand-primary">${totalBookings != null ? totalBookings : 0}</div>
                <div class="text-muted">Total Bookings</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card stat-card shadow p-4 text-center">
                <div class="display-6 brand-primary">$${revenue != null ? revenue : 0}</div>
                <div class="text-muted">Revenue</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card stat-card shadow p-4 text-center">
                <div class="display-6 brand-primary">${utilization != null ? utilization : 0}%</div>
                <div class="text-muted">Vehicle Utilization</div>
            </div>
        </div>
    </div>
</div>

<!-- Login / Signup Section -->
<div class="container mt-5" id="contact">
    <h2 class="section-title mb-3">Login / Sign Up</h2>
    <div class="row g-4">
        <div class="col-lg-6">
            <form class="card shadow p-4" action="AuthController" method="post">
                <input type="hidden" name="action" value="login">
                <h5 class="mb-3">Login</h5>
                <div class="mb-3">
                    <label class="form-label">Role</label>
                    <select name="role" class="form-select" required>
                        <option value="customer">Customer</option>
                        <option value="user">User</option>
                        <option value="admin">Admin</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" class="form-control" name="username" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" class="form-control" name="password" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>
        </div>
        <div class="col-lg-6">
            <form class="card shadow p-4" action="AuthController" method="post">
                <input type="hidden" name="action" value="register">
                <h5 class="mb-3">Sign Up</h5>
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="fullName" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Phone</label>
                        <input type="text" class="form-control" name="phone" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Role</label>
                        <select name="role" class="form-select" required>
                            <option value="customer">Customer</option>
                            <option value="user">User</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    <div class="col-12 d-grid">
                        <button type="submit" class="btn btn-primary">Create Account</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Footer -->
<div class="footer mt-5">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <h5>CarGo Rentals</h5>
                <p class="mb-1">123 Main Street, City</p>
                <p class="mb-0">support@cargo-rentals.com | +1 555-0100</p>
            </div>
            <div class="col-md-4">
                <h6>Quick Links</h6>
                <ul class="list-unstyled mb-0">
                    <li><a href="#vehicles">Vehicles</a></li>
                    <li><a href="#booking">Book Now</a></li>
                    <li><a href="#promotions">Promotions</a></li>
                    <li><a href="#reports">Reports</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h6>Feedback</h6>
                <form action="FeedbackController" method="post">
                    <input type="hidden" name="action" value="create">
                    <div class="mb-2">
                        <input type="text" class="form-control" name="name" placeholder="Your name">
                    </div>
                    <div class="mb-2">
                        <input type="email" class="form-control" name="email" placeholder="Your email">
                    </div>
                    <div class="mb-2">
                        <textarea class="form-control" name="message" rows="2" placeholder="Your feedback"></textarea>
                    </div>
                    <button class="btn btn-outline-light btn-sm" type="submit">Send</button>
                </form>
            </div>
        </div>
        <div class="text-center mt-4">&copy; 2025 CarRent. All Rights Reserved.</div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function applyFilters() {
        const q = (document.getElementById('searchInput')?.value || '').toLowerCase();
        const type = document.getElementById('filterType')?.value || '';
        const avail = document.getElementById('filterAvailability')?.value || '';
        const max = parseFloat(document.getElementById('filterMaxPrice')?.value || 'NaN');
        document.querySelectorAll('#vehicleGrid .vehicle-item').forEach(function(card){
            const name = card.querySelector('.card-title')?.textContent.toLowerCase() || '';
            const ctype = card.getAttribute('data-type') || '';
            const cavail = card.getAttribute('data-availability') || '';
            const price = parseFloat(card.getAttribute('data-price') || '0');
            let ok = true;
            if (q && !name.includes(q)) ok = false;
            if (type && ctype !== type) ok = false;
            if (avail && cavail !== avail) ok = false;
            if (!isNaN(max) && price > max) ok = false;
            card.style.display = ok ? '' : 'none';
        });
    }
    function prefillBooking(id, name){
        const select = document.getElementById('bookingCar');
        if (select) {
            select.value = id;
            document.getElementById('notify').classList.remove('d-none');
            document.getElementById('notifyText').innerText = 'Selected ' + name + ' for booking.';
        }
    }
    function showBooked(){
        const container = document.getElementById('notify');
        if (container) {
            container.classList.remove('d-none');
            document.getElementById('notifyText').innerText = 'Your booking request has been submitted!';
        }
    }
</script>
</body>
</html>
