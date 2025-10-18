<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Bookings - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/notifications.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; padding-top: 70px; background-color: #f8fafc; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .brand-primary { color: #667eea; }
        .booking-card { transition: transform 0.3s ease, box-shadow 0.3s ease; border: none; border-radius: 1rem; overflow: hidden; }
        .booking-card:hover { transform: translateY(-5px); box-shadow: 0 15px 35px rgba(0,0,0,0.1); }
        .status-pending { background: linear-gradient(135deg, #fbbf24, #f59e0b); }
        .status-confirmed { background: linear-gradient(135deg, #10b981, #059669); }
        .status-cancelled { background: linear-gradient(135deg, #ef4444, #dc2626); }
        .status-completed { background: linear-gradient(135deg, #6366f1, #4f46e5); }
        .btn-primary { background: linear-gradient(135deg, #667eea, #764ba2); border: none; transition: all 0.3s ease; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
        .card { border-radius: 1rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: none; }
        .form-control, .form-select { border-radius: 0.5rem; border: 2px solid #e2e8f0; transition: border-color 0.3s ease; }
        .form-control:focus, .form-select:focus { border-color: #667eea; box-shadow: 0 0 0 0.2rem rgba(102,126,234,0.25); }
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
                <li class="nav-item"><a class="nav-link active" href="HomeServlet?page=customer-booking">My Bookings</a></li>
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
    <!-- Error Message Display -->
    <c:if test="${not empty param.errorMsg}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>
            ${param.errorMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.successMsg}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>
            ${param.successMsg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row align-items-center mb-4">
        <div class="col">
            <h1 class="display-6 mb-0">My Bookings</h1>
            <p class="text-muted">Manage your vehicle reservations and bookings</p>
        </div>
        <div class="col-auto">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newBookingModal">
                <i class="fas fa-plus"></i> New Booking
            </button>
        </div>
    </div>
</div>

<!-- Bookings List -->
<div class="container">
    <div class="row">
        <c:forEach var="booking" items="${customerBookings}">
            <div class="col-md-6 mb-4">
                <div class="card booking-card h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <h5 class="card-title mb-0">Booking #${booking.bookingId}</h5>
                            <span class="badge status-${booking.status.toLowerCase()}">${booking.status}</span>
                        </div>
                        <div class="row g-2">
                            <div class="col-sm-6">
                                <small class="text-muted">Vehicle</small>
                                <p class="mb-1 fw-semibold">${booking.vehicleName}</p>
                            </div>
                            <div class="col-sm-6">
                                <small class="text-muted">Pickup Date</small>
                                <p class="mb-1">${booking.pickupDate}</p>
                            </div>
                            <div class="col-sm-6">
                                <small class="text-muted">Return Date</small>
                                <p class="mb-1">${booking.returnDate}</p>
                            </div>
                            <div class="col-sm-6">
                                <small class="text-muted">Total Cost</small>
                                <p class="mb-1 fw-semibold text-primary">$${booking.totalCost}</p>
                            </div>
                        </div>
                        <div class="mt-3 d-flex gap-2">
                            <button class="btn btn-outline-primary btn-sm" onclick="viewBookingDetails('${booking.bookingId}')">
                                View Details
                            </button>
                            <c:if test="${booking.status == 'Pending'}">
                                <button class="btn btn-outline-danger btn-sm" onclick="cancelBooking('${booking.bookingId}')">
                                    Cancel
                                </button>
                            </c:if>
                            <c:if test="${booking.status == 'Confirmed'}">
                                <button class="btn btn-success btn-sm" onclick="makePayment('${booking.bookingId}', '${booking.totalCost}')">
                                    Pay Now
                                </button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty customerBookings}">
            <div class="col-12">
                <div class="card text-center p-5">
                    <div class="card-body">
                        <h4 class="text-muted mb-3">No Bookings Found</h4>
                        <p class="text-muted mb-4">You haven't made any bookings yet. Start by browsing our available vehicles!</p>
                        <a href="customer-vehicles.jsp" class="btn btn-primary">Browse Vehicles</a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</div>

<!-- New Booking Modal -->
<div class="modal fade" id="newBookingModal" tabindex="-1" aria-labelledby="newBookingModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="newBookingModalLabel">Create New Booking</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="bookingForm" action="BookingController" method="post">
                    <input type="hidden" name="action" value="create">
                    <input type="hidden" name="returnPage" value="customer-booking">
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
                            <label class="form-label">Select Vehicle</label>
                            <select id="bookingCar" class="form-select" name="vehicleId" required>
                                <option value="">Choose a vehicle...</option>
                                <c:forEach var="car" items="${carList}">
                                    <c:if test="${car.available == true or car.available == 1}">
                                        <option value="${car.vehicleId}">${car.vehicleName} - $${car.dailyPrice}/day</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-12">
                            <div class="alert alert-info">
                                <strong>Booking Summary:</strong><br>
                                <span id="bookingSummary">Please select dates and vehicle to see summary.</span>
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

<!-- Booking Details Modal -->
<div class="modal fade" id="bookingDetailsModal" tabindex="-1" aria-labelledby="bookingDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="bookingDetailsModalLabel">Booking Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="bookingDetailsContent">
                <!-- Booking details will be loaded here -->
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Pre-fill selected vehicle if coming from vehicles page
    window.onload = function() {
        const selectedVehicleId = sessionStorage.getItem('selectedVehicleId');
        const selectedVehicleName = sessionStorage.getItem('selectedVehicleName');

        if (selectedVehicleId && selectedVehicleName) {
            const select = document.getElementById('bookingCar');
            if (select) {
                select.value = selectedVehicleId;
                // Clear the session storage
                sessionStorage.removeItem('selectedVehicleId');
                sessionStorage.removeItem('selectedVehicleName');
            }
        }
    };

    function viewBookingDetails(bookingId) {
        // In a real application, you'd fetch booking details via AJAX
        const modal = new bootstrap.Modal(document.getElementById('bookingDetailsModal'));
        document.getElementById('bookingDetailsContent').innerHTML = `
            <div class="text-center">
                <h4>Booking #${bookingId}</h4>
                <p>Detailed booking information would be loaded here via AJAX call to the server.</p>
                <p>This could include vehicle details, payment status, booking history, etc.</p>
            </div>
        `;
        modal.show();
    }

    function cancelBooking(bookingId) {
        if (confirm('Are you sure you want to cancel this booking?')) {
            // In a real application, you'd make an AJAX call to cancel the booking
            window.location.href = `BookingController?action=delete&bookingId=${bookingId}`;
        }
    }

    function makePayment(bookingId, amount) {
        // Redirect to payment page with booking details
        window.location.href = `customer-payment.jsp?bookingId=${bookingId}&amount=${amount}`;
    }

    // Update booking summary when dates or vehicle change
    document.getElementById('bookingForm').addEventListener('input', updateBookingSummary);

    function updateBookingSummary() {
        const pickupDate = document.querySelector('input[name="pickupDate"]').value;
        const returnDate = document.querySelector('input[name="returnDate"]').value;
        const vehicleSelect = document.getElementById('bookingCar');
        const selectedOption = vehicleSelect.options[vehicleSelect.selectedIndex];

        if (pickupDate && returnDate && selectedOption.value) {
            const start = new Date(pickupDate);
            const end = new Date(returnDate);
            const days = Math.ceil((end - start) / (1000 * 60 * 60 * 24));

            if (days > 0) {
                const priceText = selectedOption.text.split(' - $')[1];
                const dailyPrice = parseFloat(priceText.split('/')[0]);
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
            document.getElementById('bookingSummary').innerHTML = 'Please select dates and vehicle to see summary.';
        }
    }
</script>
</body>
</html>