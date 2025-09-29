<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment History - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; padding-top: 70px; background-color: #f8fafc; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .brand-primary { color: #667eea; }
        .payment-card { transition: transform 0.3s ease, box-shadow 0.3s ease; border: none; border-radius: 1rem; overflow: hidden; }
        .payment-card:hover { transform: translateY(-5px); box-shadow: 0 15px 35px rgba(0,0,0,0.1); }
        .status-success { background: linear-gradient(135deg, #10b981, #059669); }
        .status-pending { background: linear-gradient(135deg, #f59e0b, #d97706); }
        .status-failed { background: linear-gradient(135deg, #ef4444, #dc2626); }
        .btn-primary { background: linear-gradient(135deg, #667eea, #764ba2); border: none; transition: all 0.3s ease; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
        .btn-success { background: linear-gradient(135deg, #10b981, #059669); border: none; transition: all 0.3s ease; }
        .btn-success:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(16,185,129,0.4); }
        .card { border-radius: 1rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: none; }
        .form-control, .form-select { border-radius: 0.5rem; border: 2px solid #e2e8f0; transition: border-color 0.3s ease; }
        .form-control:focus, .form-select:focus { border-color: #667eea; box-shadow: 0 0 0 0.2rem rgba(102,126,234,0.25); }
        .payment-method-option { border: 2px solid #e2e8f0; border-radius: 0.5rem; padding: 0.75rem; transition: all 0.3s ease; cursor: pointer; }
        .payment-method-option:hover { border-color: #667eea; background-color: rgba(102,126,234,0.05); }
        .payment-method-option input:checked ~ label { color: #667eea; font-weight: 600; }
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
            <c:choose>
                <c:when test="${not empty param.bookingId and not empty param.amount}">
                    <h1 class="display-6 mb-0">Complete Your Booking</h1>
                    <p class="text-muted">Secure checkout process for your car rental</p>
                </c:when>
                <c:otherwise>
                    <h1 class="display-6 mb-0">Payment Management</h1>
                    <p class="text-muted">View payment history and manage your transactions</p>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="col-auto">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="HomeServlet">Home</a></li>
                    <li class="breadcrumb-item"><a href="HomeServlet?page=customer-dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item active" aria-current="page">
                        <c:choose>
                            <c:when test="${not empty param.bookingId and not empty param.amount}">Checkout</c:when>
                            <c:otherwise>Payments</c:otherwise>
                        </c:choose>
                    </li>
                </ol>
            </nav>
        </div>
    </div>
</div>

<!-- Checkout Process -->
<c:if test="${not empty param.bookingId and not empty param.amount}">
<div class="container">
    <div class="row g-4">
        <!-- Personal Details & Payment Information -->
        <div class="col-lg-8">
            <!-- Progress Indicator -->
            <div class="card mb-4">
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-4">
                            <div class="rounded-circle bg-primary text-white d-inline-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="mt-2">
                                <small class="text-primary fw-semibold">Personal Details</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="rounded-circle bg-primary text-white d-inline-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                <i class="fas fa-credit-card"></i>
                            </div>
                            <div class="mt-2">
                                <small class="text-primary fw-semibold">Payment Info</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="rounded-circle bg-success text-white d-inline-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="mt-2">
                                <small class="text-success fw-semibold">Confirmation</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Personal Details -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-user me-2"></i>Personal Details</h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">First Name</label>
                            <input type="text" class="form-control" value="${sessionScope.userFirstName}" readonly>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Last Name</label>
                            <input type="text" class="form-control" value="${sessionScope.userLastName}" readonly>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" value="${sessionScope.username}" readonly>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Phone</label>
                            <input type="tel" class="form-control" value="${sessionScope.userPhone}" readonly>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Payment Information -->
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-credit-card me-2"></i>Payment Information</h5>
                </div>
                <div class="card-body">
                    <form action="PaymentController" method="post" id="paymentForm">
                        <input type="hidden" name="action" value="create">
                        <input type="hidden" name="bookingId" value="${param.bookingId}">
                        <input type="hidden" name="amount" value="${param.amount}">

                        <div class="mb-3">
                            <label class="form-label">Payment Method</label>
                            <div class="row g-2">
                                <div class="col-6">
                                    <div class="form-check payment-method-option">
                                        <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="Credit Card" required>
                                        <label class="form-check-label" for="creditCard">
                                            <i class="fas fa-credit-card me-2"></i>Credit Card
                                        </label>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-check payment-method-option">
                                        <input class="form-check-input" type="radio" name="paymentMethod" id="debitCard" value="Debit Card">
                                        <label class="form-check-label" for="debitCard">
                                            <i class="fas fa-credit-card me-2"></i>Debit Card
                                        </label>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-check payment-method-option">
                                        <input class="form-check-input" type="radio" name="paymentMethod" id="paypal" value="PayPal">
                                        <label class="form-check-label" for="paypal">
                                            <i class="fab fa-paypal me-2"></i>Online
                                        </label>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-check payment-method-option">
                                        <input class="form-check-input" type="radio" name="paymentMethod" id="bankTransfer" value="Bank Transfer">
                                        <label class="form-check-label" for="bankTransfer">
                                            <i class="fas fa-university me-2"></i>Bank Transfer
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Credit/Debit Card Fields -->
                        <div id="cardFields" style="display: none;">
                            <div class="row g-3">
                                <div class="col-12">
                                    <label class="form-label">Card Number</label>
                                    <input type="text" class="form-control" name="cardNumber" placeholder="1234 5678 9012 3456" maxlength="19">
                                </div>
                                <div class="col-6">
                                    <label class="form-label">Expiry Date</label>
                                    <input type="text" class="form-control" name="expiryDate" placeholder="MM/YY" maxlength="5">
                                </div>
                                <div class="col-6">
                                    <label class="form-label">CVV</label>
                                    <input type="text" class="form-control" name="cvv" placeholder="123" maxlength="4">
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Cardholder Name</label>
                                    <input type="text" class="form-control" name="cardholderName" placeholder="John Doe">
                                </div>
                            </div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-success btn-lg">
                                <i class="fas fa-lock me-2"></i>Complete Payment - $${param.amount}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Booking Summary -->
        <div class="col-lg-4">
            <div class="card sticky-top" style="top: 20px;">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-receipt me-2"></i>Booking Summary</h5>
                </div>
                <div class="card-body">
                    <c:if test="${not empty bookingDetails}">
                        <div class="mb-3">
                            <div class="d-flex justify-content-between">
                                <span>Vehicle:</span>
                                <strong>${bookingDetails.vehicleName}</strong>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span>Pickup:</span>
                                <span>${bookingDetails.pickupDate}</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span>Return:</span>
                                <span>${bookingDetails.returnDate}</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span>Duration:</span>
                                <span>${bookingDetails.duration} days</span>
                            </div>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Subtotal:</span>
                            <span>$${bookingDetails.subtotal}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tax:</span>
                            <span>$${bookingDetails.tax}</span>
                        </div>
                        <c:if test="${bookingDetails.discount > 0}">
                            <div class="d-flex justify-content-between mb-2 text-success">
                                <span>Discount:</span>
                                <span>-$${bookingDetails.discount}</span>
                            </div>
                        </c:if>
                        <hr>
                        <div class="d-flex justify-content-between">
                            <strong>Total:</strong>
                            <strong class="text-primary">$${param.amount}</strong>
                        </div>
                    </c:if>
                    <c:if test="${empty bookingDetails}">
                        <div class="text-center py-4">
                            <div class="d-flex justify-content-between">
                                <span>Booking #${param.bookingId}</span>
                            </div>
                            <div class="d-flex justify-content-between mt-2">
                                <strong>Total Amount:</strong>
                                <strong class="text-primary">$${param.amount}</strong>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</c:if>

<!-- Payment History (shown when not in checkout mode) -->
<c:if test="${empty param.bookingId or empty param.amount}">
<div class="container">
    <div class="row g-4">
        <!-- Payment Summary -->
        <div class="col-lg-4">
            <div class="card">
                <div class="card-header">
                    <h6 class="mb-0">Payment Summary</h6>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-6">
                            <div class="h4 text-success mb-1">${totalPayments != null ? totalPayments : 0}</div>
                            <small class="text-muted">Total Payments</small>
                        </div>
                        <div class="col-6">
                            <div class="h4 text-primary mb-1">$${totalAmount != null ? totalAmount : 0}</div>
                            <small class="text-muted">Total Amount</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Payment History -->
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Payment History</h5>
                    <span class="badge bg-primary">${totalPayments != null ? totalPayments : 0} Payments</span>
                </div>
                <div class="card-body">
                    <c:if test="${empty customerPayments}">
                        <div class="text-center py-5">
                            <h6 class="text-muted mb-3">No Payment History</h6>
                            <p class="text-muted">Your payment history will appear here once you make your first payment.</p>
                            <a href="customer-booking.jsp" class="btn btn-primary">View Bookings</a>
                        </div>
                    </c:if>
                    <c:if test="${not empty customerPayments}">
                        <div class="row g-3">
                            <c:forEach var="payment" items="${customerPayments}">
                                <div class="col-12">
                                    <div class="card payment-card">
                                        <div class="card-body">
                                            <div class="row align-items-center">
                                                <div class="col-md-2">
                                                    <div class="text-center">
                                                        <div class="h5 mb-0">#${payment.paymentId}</div>
                                                        <small class="text-muted">Payment ID</small>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="fw-semibold">Booking #${payment.bookingId}</div>
                                                    <small class="text-muted">${payment.vehicleName}</small>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="h6 mb-0 text-primary">$${payment.amount}</div>
                                                    <small class="text-muted">${payment.paymentMethod}</small>
                                                </div>
                                                <div class="col-md-2">
                                                    <small class="text-muted">${payment.paymentDate}</small>
                                                </div>
                                                <div class="col-md-2">
                                                    <span class="badge status-success">Completed</span>
                                                </div>
                                                <div class="col-md-1">
                                                    <button class="btn btn-outline-primary btn-sm" onclick="viewPaymentDetails('${payment.paymentId}')">
                                                        Details
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Transactions -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0">Recent Transactions</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Booking</th>
                                    <th>Amount</th>
                                    <th>Method</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="payment" items="${recentPayments}" varStatus="loop">
                                    <c:if test="${loop.index < 5}">
                                        <tr>
                                            <td>${payment.paymentDate}</td>
                                            <td>Booking #${payment.bookingId}</td>
                                            <td class="fw-semibold">$${payment.amount}</td>
                                            <td>${payment.paymentMethod}</td>
                                            <td><span class="badge status-success">Completed</span></td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${empty recentPayments or recentPayments.size() == 0}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">
                                            No recent transactions found
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
</c:if>

<!-- Payment Details Modal -->
<div class="modal fade" id="paymentDetailsModal" tabindex="-1" aria-labelledby="paymentDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="paymentDetailsModalLabel">Payment Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="paymentDetailsContent">
                <!-- Payment details will be loaded here -->
            </div>
        </div>
    </div>
</div>

<!-- Success/Error Messages -->
<c:if test="${param.paymentSuccess == '1'}">
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1100">
        <div class="toast show" role="alert">
            <div class="toast-header">
                <strong class="me-auto text-success">Payment Successful!</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body">
                Your payment has been processed successfully.
            </div>
        </div>
    </div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function viewPaymentDetails(paymentId) {
        // In a real application, you'd fetch payment details via AJAX
        const modal = new bootstrap.Modal(document.getElementById('paymentDetailsModal'));
        document.getElementById('paymentDetailsContent').innerHTML =
            '<div class="text-center">' +
                '<h4>Payment #' + paymentId + '</h4>' +
                '<p>Detailed payment information would be loaded here via AJAX call to the server.</p>' +
                '<p>This could include transaction details, receipts, payment method info, etc.</p>' +
            '</div>';
        modal.show();
    }

    // Payment method selection and card field visibility
    document.addEventListener('DOMContentLoaded', function() {
        const paymentMethods = document.querySelectorAll('input[name="paymentMethod"]');
        const cardFields = document.getElementById('cardFields');

        paymentMethods.forEach(method => {
            method.addEventListener('change', function() {
                if (this.value === 'Credit Card' || this.value === 'Debit Card') {
                    cardFields.style.display = 'block';
                    // Make card fields required
                    cardFields.querySelectorAll('input').forEach(input => {
                        input.required = true;
                    });
                } else {
                    cardFields.style.display = 'none';
                    // Remove required from card fields
                    cardFields.querySelectorAll('input').forEach(input => {
                        input.required = false;
                    });
                }
            });
        });

        // Format card number input
        const cardNumberInput = document.querySelector('input[name="cardNumber"]');
        if (cardNumberInput) {
            cardNumberInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
                let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
                e.target.value = formattedValue;
            });
        }

        // Format expiry date input
        const expiryInput = document.querySelector('input[name="expiryDate"]');
        if (expiryInput) {
            expiryInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length >= 2) {
                    value = value.substring(0, 2) + '/' + value.substring(2, 4);
                }
                e.target.value = value;
            });
        }
    });

    // Auto-hide success message after 5 seconds
    setTimeout(function() {
        const toast = document.querySelector('.toast');
        if (toast) {
            toast.classList.remove('show');
        }
    }, 5000);
</script>
</body>
</html>