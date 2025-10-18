<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Promotions & Offers - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; padding-top: 70px; background-color: #f8fafc; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .brand-primary { color: #667eea; }
        .promo-card { transition: transform 0.3s ease, box-shadow 0.3s ease; border: none; border-radius: 1rem; overflow: hidden; position: relative; }
        .promo-card:hover { transform: translateY(-5px); box-shadow: 0 15px 35px rgba(0,0,0,0.1); }
        .promo-card::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 4px; background: linear-gradient(135deg, #667eea, #764ba2); }
        .promo-badge { position: absolute; top: 10px; right: 10px; background: linear-gradient(135deg, #f59e0b, #d97706); color: white; padding: 5px 10px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
        .btn-primary { background: linear-gradient(135deg, #667eea, #764ba2); border: none; transition: all 0.3s ease; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
        .card { border-radius: 1rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: none; }
        .countdown { background: linear-gradient(135deg, #ef4444, #dc2626); color: white; padding: 10px; border-radius: 0.5rem; text-align: center; margin-top: 1rem; }
        .countdown-text { font-size: 0.9rem; margin-bottom: 5px; }
        .countdown-timer { font-size: 1.2rem; font-weight: 700; }
    </style>
    <script src="${pageContext.request.contextPath}/notifications.js"></script>
</head>
<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="HomeServlet">CarRent</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="HomeServlet">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="<c:choose><c:when test="${sessionScope.role == 'admin'}">AdminServlet</c:when><c:otherwise>HomeServlet?page=customer-dashboard</c:otherwise></c:choose>"><c:choose><c:when test="${sessionScope.role == 'admin'}">Admin Panel</c:when><c:otherwise>Dashboard</c:otherwise></c:choose></a></li>
                <li class="nav-item"><a class="nav-link" href="HomeServlet?page=customer-vehicles">Vehicles</a></li>
                <li class="nav-item"><a class="nav-link" href="HomeServlet?page=customer-booking">My Bookings</a></li>
                <li class="nav-item"><a class="nav-link active" href="HomeServlet?page=customer-promotions">Promotions</a></li>
                <li class="nav-item"><a class="nav-link" href="HomeServlet?page=customer-feedback">Feedback</a></li>
                <c:if test="${not empty sessionScope.username}">
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
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<!-- Header -->
<div class="container mt-4">
    <div class="row align-items-center mb-4">
        <div class="col">
            <h1 class="display-6 mb-0">Special Offers & Promotions</h1>
            <p class="text-muted">Discover amazing deals and exclusive offers on our vehicle rentals</p>
        </div>
        <div class="col-auto">
            <div class="d-flex gap-2">
                <span class="badge bg-primary fs-6">${activePromotionsCount != null ? activePromotionsCount : 0} Active Offers</span>
            </div>
        </div>
    </div>
</div>

<!-- Featured Promotion -->
<c:if test="${not empty featuredPromotion}">
    <div class="container mb-4">
        <div class="card promo-card" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
            <div class="card-body text-center py-5">
                <h2 class="card-title mb-3">🎉 ${featuredPromotion.title}</h2>
                <p class="card-text fs-5 mb-4">${featuredPromotion.description}</p>
                <c:if test="${not empty featuredPromotion.badge}">
                    <span class="badge bg-warning text-dark fs-6 mb-3">${featuredPromotion.badge}</span>
                </c:if>
                <br>
                <a href="customer-vehicles.jsp" class="btn btn-light btn-lg">Book Now & Save</a>
                <c:if test="${not empty featuredPromotion.validTill}">
                    <div class="countdown mt-3">
                        <div class="countdown-text">Offer expires in:</div>
                        <div class="countdown-timer" id="countdown-timer">Loading...</div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</c:if>

<!-- Promotions Grid -->
<div class="container">
    <div class="row g-4">
        <c:forEach var="promo" items="${promotionsList}">
            <div class="col-md-6 col-lg-4">
                <div class="card promo-card h-100">
                    <c:if test="${not empty promo.badge}">
                        <div class="promo-badge">${promo.badge}</div>
                    </c:if>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-primary mb-3">${promo.title}</h5>
                        <p class="card-text flex-grow-1">${promo.description}</p>
                        <c:if test="${not empty promo.validTill}">
                            <div class="mt-auto">
                                <small class="text-muted">Valid until: ${promo.validTill}</small>
                            </div>
                        </c:if>
                        <div class="mt-3 d-grid">
                            <a href="customer-vehicles.jsp" class="btn btn-primary">Take Advantage</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- Default Promotions if none from database -->
        <c:if test="${empty promotionsList}">
            <div class="col-md-6 col-lg-4">
                <div class="card promo-card h-100">
                    <div class="promo-badge">HOT</div>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-primary mb-3">Weekend Special</h5>
                        <p class="card-text flex-grow-1">Get 15% off on all weekend rentals. Book Friday to Sunday and enjoy the savings!</p>
                        <div class="mt-auto">
                            <small class="text-muted">Valid on weekends</small>
                        </div>
                        <div class="mt-3 d-grid">
                            <a href="customer-vehicles.jsp" class="btn btn-primary">Book Weekend</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card promo-card h-100">
                    <div class="promo-badge">NEW</div>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-primary mb-3">Early Bird Discount</h5>
                        <p class="card-text flex-grow-1">Book 14+ days in advance and save 10% on your rental. Perfect for planning ahead!</p>
                        <div class="mt-auto">
                            <small class="text-muted">Advance booking required</small>
                        </div>
                        <div class="mt-3 d-grid">
                            <a href="customer-vehicles.jsp" class="btn btn-primary">Plan Ahead</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-lg-4">
                <div class="card promo-card h-100">
                    <div class="promo-badge">LOYALTY</div>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-primary mb-3">Loyal Customer Reward</h5>
                        <p class="card-text flex-grow-1">Returning customers get 5% off on every booking. Thank you for choosing us!</p>
                        <div class="mt-auto">
                            <small class="text-muted">For existing customers</small>
                        </div>
                        <div class="mt-3 d-grid">
                            <a href="customer-vehicles.jsp" class="btn btn-primary">Claim Reward</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>

<!-- How to Redeem Section -->
<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">How to Redeem Offers</h5>
        </div>
        <div class="card-body">
            <div class="row g-4">
                <div class="col-md-4 text-center">
                    <div class="h1 text-primary mb-3">1</div>
                    <h6>Choose Your Vehicle</h6>
                    <p class="text-muted">Browse our available vehicles and select the one that suits your needs.</p>
                </div>
                <div class="col-md-4 text-center">
                    <div class="h1 text-primary mb-3">2</div>
                    <h6>Apply Promotion Code</h6>
                    <p class="text-muted">During booking, the promotional discount will be automatically applied.</p>
                </div>
                <div class="col-md-4 text-center">
                    <div class="h1 text-primary mb-3">3</div>
                    <h6>Enjoy Savings</h6>
                    <p class="text-muted">Complete your booking and enjoy the discounted rental price.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Newsletter Signup -->
<div class="container mt-4">
    <div class="card" style="background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);">
        <div class="card-body text-center py-4">
            <h5 class="mb-3">Stay Updated with Latest Offers</h5>
            <p class="text-muted mb-4">Subscribe to our newsletter and be the first to know about exclusive deals and promotions.</p>
            <form class="row g-3 justify-content-center">
                <div class="col-md-4">
                    <input type="email" class="form-control" placeholder="Enter your email" required>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">Subscribe</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Countdown timer for featured promotion
    <c:if test="${not empty featuredPromotion and not empty featuredPromotion.validTill}">
        function updateCountdown() {
            const endDate = new Date('${featuredPromotion.validTill}').getTime();
            const now = new Date().getTime();
            const distance = endDate - now;

            if (distance > 0) {
                const days = Math.floor(distance / (1000 * 60 * 60 * 24));
                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));

                document.getElementById('countdown-timer').innerHTML = days + 'd ' + hours + 'h ' + minutes + 'm';
            } else {
                document.getElementById('countdown-timer').innerHTML = 'EXPIRED';
            }
        }

        updateCountdown();
        setInterval(updateCountdown, 60000); // Update every minute
    </c:if>
</script>
</body>
</html>