<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Bill - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="${pageContext.request.contextPath}/notifications.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; padding-top: 70px; background-color: #f8fafc; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .brand-primary { color: #667eea; }
        .bill-card { transition: transform 0.3s ease, box-shadow 0.3s ease; border: none; border-radius: 1rem; overflow: hidden; }
        .bill-card:hover { transform: translateY(-5px); box-shadow: 0 15px 35px rgba(0,0,0,0.1); }
        .btn-primary { background: linear-gradient(135deg, #667eea, #764ba2); border: none; transition: all 0.3s ease; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
        .btn-success { background: linear-gradient(135deg, #10b981, #059669); border: none; transition: all 0.3s ease; }
        .btn-success:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(16,185,129,0.4); }
        .card { border-radius: 1rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: none; }
        .bill-header { background: linear-gradient(135deg, #667eea, #764ba2); color: white; }
        .bill-total { background: linear-gradient(135deg, #10b981, #059669); color: white; }
        .print-btn { background: linear-gradient(135deg, #f59e0b, #d97706); border: none; transition: all 0.3s ease; }
        .print-btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(245,158,11,0.4); }
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
            <h1 class="display-6 mb-0"><i class="fas fa-receipt me-2"></i>Booking Bill</h1>
            <c:choose>
                <c:when test="${billDetails.isPreview}">
                    <p class="text-muted">Preview of your booking bill - Payment pending</p>
                </c:when>
                <c:otherwise>
                    <p class="text-muted">Your booking has been confirmed successfully</p>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="col-auto">
            <a href="bill-download.jsp?bookingId=${billDetails.bookingId}" class="btn btn-success me-2">
                <i class="fas fa-download me-2"></i>Download PDF
            </a>
            <button onclick="window.print()" class="btn print-btn">
                <i class="fas fa-print me-2"></i>Print Bill
            </button>
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
                            <p class="card-text">You need to be logged in to view your bill.</p>
                            <a href="cargo-landing.jsp" class="btn btn-primary">Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${not empty billError}">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body text-center">
                            <h5 class="card-title">Bill Error</h5>
                            <p class="card-text">${billError}</p>
                            <a href="HomeServlet?page=customer-dashboard" class="btn btn-primary">Go to Dashboard</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:when>
    <c:when test="${empty billDetails}">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body text-center">
                            <h5 class="card-title">Bill Not Found</h5>
                            <p class="card-text">Unable to load bill details. Please check your booking ID or contact support.</p>
                            <a href="HomeServlet?page=customer-dashboard" class="btn btn-primary">Go to Dashboard</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>

<div class="container">
    <div class="row g-4">
        <!-- Bill Details -->
        <div class="col-lg-8">
            <div class="card bill-card">
                <div class="card-header bill-header">
                    <h5 class="mb-0"><i class="fas fa-file-invoice-dollar me-2"></i>Bill Details</h5>
                </div>
                <div class="card-body">
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h6><i class="fas fa-user me-2"></i>Customer Information</h6>
                            <p class="mb-1"><strong>Name:</strong> ${sessionScope.userFullName}</p>
                            <p class="mb-1"><strong>Email:</strong> ${sessionScope.userEmail}</p>
                            <p class="mb-1"><strong>Phone:</strong> ${sessionScope.userPhone}</p>
                        </div>
                        <div class="col-md-6">
                            <h6><i class="fas fa-calendar-check me-2"></i>Booking Information</h6>
                            <p class="mb-1"><strong>Booking ID:</strong> #${billDetails.bookingId}</p>
                            <c:if test="${not billDetails.isPreview}">
                                <p class="mb-1"><strong>Payment ID:</strong> #${billDetails.paymentId}</p>
                                <p class="mb-1"><strong>Payment Date:</strong> ${billDetails.paymentDate}</p>
                            </c:if>
                            <p class="mb-1"><strong>Booking Date:</strong> ${billDetails.bookingDate}</p>
                            <c:if test="${billDetails.isPreview}">
                                <p class="mb-1"><span class="badge bg-warning text-dark">Payment Pending</span></p>
                            </c:if>
                        </div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-12">
                            <h6><i class="fas fa-car me-2"></i>Vehicle Details</h6>
                            <div class="card bg-light">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <c:if test="${not empty billDetails.vehicleImage}">
                                                <img src="${billDetails.vehicleImage}" alt="${billDetails.vehicleName}" class="img-fluid rounded" style="max-height: 150px;">
                                            </c:if>
                                        </div>
                                        <div class="col-md-8">
                                            <h5 class="card-title">${billDetails.vehicleName}</h5>
                                            <p class="card-text mb-2">${billDetails.vehicleDescription}</p>
                                            <div class="row">
                                                <div class="col-6">
                                                    <small class="text-muted">Pickup Date</small>
                                                    <p class="mb-1">${billDetails.startDate}</p>
                                                </div>
                                                <div class="col-6">
                                                    <small class="text-muted">Return Date</small>
                                                    <p class="mb-1">${billDetails.endDate}</p>
                                                </div>
                                            </div>
                                            <p class="mb-0"><strong>Duration:</strong> ${billDetails.duration} days</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-12">
                            <h6><i class="fas fa-credit-card me-2"></i>Payment Details</h6>
                            <div class="table-responsive">
                                <table class="table table-borderless">
                                    <tbody>
                                        <c:if test="${not billDetails.isPreview}">
                                            <tr>
                                                <td><strong>Payment Method:</strong></td>
                                                <td>${billDetails.paymentMethod}</td>
                                            </tr>
                                        </c:if>
                                        <tr>
                                            <td><strong>Daily Rate:</strong></td>
                                            <td>Rs${billDetails.dailyRate}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>Duration:</strong></td>
                                            <td>${billDetails.duration} days</td>
                                        </tr>
                                        <tr class="border-top">
                                            <td><strong class="text-primary">Total Amount:</strong></td>
                                            <td><strong class="text-primary h5">Rs${billDetails.totalAmount}</strong></td>
                                        </tr>
                                        <c:if test="${billDetails.isPreview}">
                                            <tr class="border-top">
                                                <td colspan="2">
                                                    <div class="alert alert-info">
                                                        <i class="fas fa-info-circle me-2"></i>
                                                        This is a bill preview. Payment has not been processed yet.
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bill Summary & Actions -->
        <div class="col-lg-4">
            <div class="card bill-card sticky-top" style="top: 20px;">
                <div class="card-header bill-total">
                    <c:choose>
                        <c:when test="${billDetails.isPreview}">
                            <h5 class="mb-0"><i class="fas fa-file-invoice me-2"></i>Bill Preview</h5>
                        </c:when>
                        <c:otherwise>
                            <h5 class="mb-0"><i class="fas fa-check-circle me-2"></i>Payment Successful</h5>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${billDetails.isPreview}">
                            <div class="text-center mb-4">
                                <div class="h1 text-warning mb-2">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <h4 class="text-warning">Payment Pending</h4>
                                <p class="text-muted">Complete your payment to confirm booking</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center mb-4">
                                <div class="h1 text-success mb-2">
                                    <i class="fas fa-check-circle"></i>
                                </div>
                                <h4 class="text-success">Payment Completed</h4>
                                <p class="text-muted">Your booking has been confirmed</p>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="mb-4">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Booking ID:</span>
                            <strong>#${billDetails.bookingId}</strong>
                        </div>
                        <c:if test="${not billDetails.isPreview}">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Payment ID:</span>
                                <strong>#${billDetails.paymentId}</strong>
                            </div>
                        </c:if>
                        <div class="d-flex justify-content-between">
                            <span>Total Amount:</span>
                            <strong class="text-primary h5">Rs${billDetails.totalAmount}</strong>
                        </div>
                    </div>

                    <div class="d-grid gap-2">
                        <c:if test="${not billDetails.isPreview}">
                            <a href="HomeServlet?page=customer-feedback&bookingId=${billDetails.bookingId}" class="btn btn-success">
                                <i class="fas fa-star me-2"></i>Share Your Feedback
                            </a>
                            <a href="BookingController?action=cancel&bookingId=${billDetails.bookingId}" class="btn btn-danger" onclick="return confirm('Are you sure you want to cancel this booking?')">
                                <i class="fas fa-times me-2"></i>Cancel Booking
                            </a>
                            <a href="PaymentController?action=refund&paymentId=${billDetails.paymentId}" class="btn btn-warning" onclick="return confirm('Are you sure you want to request a refund?')">
                                <i class="fas fa-undo me-2"></i>Refund Payment
                            </a>
                        </c:if>
                        <c:if test="${billDetails.isPreview}">
                            <a href="customer-payment.jsp?bookingId=${billDetails.bookingId}&amount=${billDetails.totalAmount}" class="btn btn-success">
                                <i class="fas fa-credit-card me-2"></i>Complete Payment
                            </a>
                        </c:if>
                        <a href="HomeServlet?page=customer-dashboard" class="btn btn-primary">
                            <i class="fas fa-tachometer-alt me-2"></i>Go to Dashboard
                        </a>
                        <a href="HomeServlet?page=customer-booking" class="btn btn-outline-primary">
                            <i class="fas fa-list me-2"></i>View All Bookings
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Success Message -->
    <c:if test="${param.success == '1'}">
        <div class="position-fixed top-0 end-0 p-3" style="z-index: 1100">
            <div class="toast show" role="alert">
                <div class="toast-header">
                    <strong class="me-auto text-success">Success!</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
                </div>
                <div class="toast-body">
                    Your payment has been processed successfully! Your booking is now confirmed.
                </div>
            </div>
        </div>
    </c:if>
</div>

    </c:otherwise>
</c:choose>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto-hide success message after 5 seconds
    setTimeout(function() {
        const toast = document.querySelector('.toast');
        if (toast) {
            toast.classList.remove('show');
        }
    }, 5000);

    // Print functionality
    function printBill() {
        window.print();
    }
</script>
</body>
</html>