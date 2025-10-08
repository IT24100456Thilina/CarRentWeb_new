<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Download Bill - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; padding-top: 70px; background-color: #f8fafc; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .brand-primary { color: #667eea; }
        .download-card { transition: transform 0.3s ease, box-shadow 0.3s ease; border: none; border-radius: 1rem; overflow: hidden; }
        .download-card:hover { transform: translateY(-5px); box-shadow: 0 15px 35px rgba(0,0,0,0.1); }
        .btn-primary { background: linear-gradient(135deg, #667eea, #764ba2); border: none; transition: all 0.3s ease; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
        .btn-success { background: linear-gradient(135deg, #10b981, #059669); border: none; transition: all 0.3s ease; }
        .btn-success:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(16,185,129,0.4); }
        .card { border-radius: 1rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: none; }
        .breadcrumb { background: transparent; }
    </style>
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
                <li class="nav-item"><a class="nav-link" href="HomeServlet?page=customer-promotions">Promotions</a></li>
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
            <h1 class="display-6 mb-0"><i class="fas fa-download me-2"></i>Download Bill</h1>
            <p class="text-muted">Download your booking bill as PDF</p>
        </div>
        <div class="col-auto">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                    <li class="breadcrumb-item"><a href="HomeServlet?page=customer-dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="HomeServlet?page=customer-payment">Payments</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Download Bill</li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<!-- Check if user is logged in -->
<c:choose>
    <c:when test="${empty sessionScope.username}">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body text-center">
                            <h5 class="card-title">Login Required</h5>
                            <p class="card-text">You need to be logged in to download bills.</p>
                            <a href="cargo-landing.jsp" class="btn btn-primary">Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card download-card">
                <div class="card-header text-center">
                    <h5 class="mb-0"><i class="fas fa-file-pdf me-2"></i>Bill Download</h5>
                </div>
                <div class="card-body text-center">

                    <!-- Booking ID Input -->
                    <c:if test="${empty param.bookingId}">
                        <div class="mb-4">
                            <h6 class="text-muted mb-3">Enter your booking ID to download the bill</h6>
                            <form action="bill-download.jsp" method="get" class="d-inline-flex gap-2">
                                <input type="number" name="bookingId" class="form-control" placeholder="Enter Booking ID" required min="1">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Find Bill
                                </button>
                            </form>
                        </div>
                    </c:if>

                    <!-- Bill Download Section -->
                    <c:if test="${not empty param.bookingId}">
                        <div class="mb-4">
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>
                                Ready to download bill for Booking ID: <strong>#${param.bookingId}</strong>
                            </div>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="card bg-light">
                                    <div class="card-body text-center">
                                        <i class="fas fa-file-pdf fa-3x text-danger mb-3"></i>
                                        <h6>Download PDF Bill</h6>
                                        <p class="text-muted small">Get a professional PDF version of your bill</p>
                                        <a href="BillDownloadServlet?bookingId=${param.bookingId}" class="btn btn-success btn-lg w-100" target="_blank">
                                            <i class="fas fa-download me-2"></i>Download PDF
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card bg-light">
                                    <div class="card-body text-center">
                                        <i class="fas fa-eye fa-3x text-primary mb-3"></i>
                                        <h6>View Bill Details</h6>
                                        <p class="text-muted small">View detailed bill information in browser</p>
                                        <a href="HomeServlet?page=customer-bill&bookingId=${param.bookingId}" class="btn btn-primary btn-lg w-100">
                                            <i class="fas fa-eye me-2"></i>View Bill
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4">
                            <a href="bill-download.jsp" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>Download Another Bill
                            </a>
                        </div>
                    </c:if>

                </div>
            </div>

            <!-- Instructions -->
            <div class="card mt-4">
                <div class="card-header">
                    <h6 class="mb-0"><i class="fas fa-question-circle me-2"></i>How to Download Your Bill</h6>
                </div>
                <div class="card-body">
                    <ol class="text-start">
                        <li>Find your Booking ID from your booking confirmation email or dashboard</li>
                        <li>Enter the Booking ID in the field above</li>
                        <li>Click "Download PDF" to get your bill as a PDF file</li>
                        <li>Alternatively, click "View Bill" to see the bill details in your browser</li>
                    </ol>
                    <div class="alert alert-light">
                        <small class="text-muted">
                            <i class="fas fa-info-circle me-1"></i>
                            PDF bills include complete booking details, customer information, vehicle details, and payment information.
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

    </c:otherwise>
</c:choose>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>