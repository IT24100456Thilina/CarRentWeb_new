<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.example.carrentweb.ControlSql.DBConnection" %>
<%
    // No access control - accessible to anyone
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Service Dashboard - Car Rental System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #0f172a;
            --primary-light: #1e293b;
            --accent-color: #3b82f6;
            --accent-light: #60a5fa;
            --accent-dark: #1d4ed8;
            --text-dark: #0f172a;
            --text-light: #64748b;
            --text-white: #ffffff;
            --bg-white: #ffffff;
            --bg-gray: #f8fafc;
            --bg-dark: #0f172a;
            --border-color: #e2e8f0;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            --success-color: #10b981;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
            --info-color: #06b6d4;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-gray);
        }

        .sidebar {
            background: var(--bg-white);
            min-height: 100vh;
            box-shadow: var(--shadow);
            position: fixed;
            width: 280px;
            z-index: 1000;
        }

        .sidebar .nav-link {
            color: var(--text-dark);
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            margin: 0.25rem 1rem;
            transition: all 0.3s ease;
        }

        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background: rgba(59, 130, 246, 0.1);
            color: var(--accent-color);
        }

        .sidebar .nav-link i {
            width: 20px;
            margin-right: 0.75rem;
        }

        .main-content {
            margin-left: 280px;
            padding: 1rem;
        }

        .navbar {
            background: var(--bg-white);
            box-shadow: var(--shadow);
            border-bottom: 1px solid var(--border-color);
        }

        .card {
            border-radius: 16px;
            box-shadow: var(--shadow);
            border: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--accent-color), var(--accent-dark));
            border: none;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
        }

        .table {
            border-radius: 12px;
            overflow: hidden;
            margin-top: 0;
        }

        .form-control,
        .form-select {
            border-radius: 8px;
            border: 2px solid var(--border-color);
            transition: border-color 0.3s ease;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25);
        }

        .section-header {
            background: var(--bg-white);
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 0.75rem;
            box-shadow: var(--shadow);
        }

        .section-header h3 {
            color: var(--text-dark);
            font-weight: 600;
            margin: 0;
        }

        .action-btn {
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
            border-radius: 6px;
        }

        .status-badge {
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .booking-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .booking-card:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        @media (max-width: 768px) {
            .sidebar { width: 100%; position: relative; min-height: auto; }
            .main-content { margin-left: 0; }
            .navbar { display: none; }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="p-3">
            <div class="d-flex align-items-center mb-4">
                <div class="logo me-3" style="width: 40px; height: 40px; background: linear-gradient(135deg, var(--accent-color), var(--accent-light)); border-radius: 10px; display: flex; align-items: center; justify-content: center; color: white; font-weight: 700;">CS</div>
                <h5 class="mb-0">Customer Service</h5>
            </div>
            <nav class="nav flex-column">
                <a class="nav-link active" href="CustomerServiceServlet"><i class="fas fa-calendar-check"></i>Approve/Cancel Bookings</a>
                <a class="nav-link" href="PromotionController?action=view"><i class="fas fa-tags"></i>View Promotions</a>
                <a class="nav-link" href="cargo-landing.jsp"><i class="fas fa-home"></i>Back to Site</a>
                <hr class="my-3">
                <a class="nav-link" href="AuthController?action=logout"><i class="fas fa-sign-out-alt"></i>Logout</a>
            </nav>
        </div>
    </div>

    <!-- Top Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <div class="d-flex align-items-center">
                <button class="btn btn-outline-secondary d-lg-none me-2" type="button" data-bs-toggle="collapse" data-bs-target="#sidebar" aria-controls="sidebar" aria-expanded="false">
                    <i class="fas fa-bars"></i>
                </button>
                <h4 class="mb-0">Booking Approval Dashboard</h4>
            </div>
            <div class="d-flex align-items-center">
                <span class="me-3 text-muted">Welcome, ${sessionScope.userFullName}</span>
                <span class="badge bg-info me-3">${sessionScope.position}</span>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Success/Error Messages -->
        <c:if test="${not empty param.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                Booking ${param.success} successfully!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <c:choose>
                    <c:when test="${param.error == 'booking_not_found'}">Booking not found or already processed.</c:when>
                    <c:otherwise>Error: ${param.error}</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="section-header">
            <h3><i class="fas fa-calendar-check me-2"></i>Pending & Active Bookings</h3>
            <p class="text-muted mb-0">Review booking details and approve or cancel reservations</p>
        </div>

        <div class="row">
            <c:forEach var="booking" items="${bookings}">
                <div class="col-lg-6 mb-4">
                    <div class="card booking-card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h6 class="mb-0">
                                <i class="fas fa-calendar-alt me-2"></i>
                                Booking #${booking.bookingId}
                            </h6>
                            <span class="status-badge ${booking.status == 'Pending' ? 'bg-warning text-dark' : 'bg-success'}">
                                ${booking.status}
                            </span>
                        </div>
                        <div class="card-body">
                            <!-- Customer Information -->
                            <div class="row mb-3">
                                <div class="col-sm-6">
                                    <h6 class="text-muted mb-2"><i class="fas fa-user me-1"></i>Customer Details</h6>
                                    <p class="mb-1"><strong>${booking.customerName}</strong></p>
                                    <p class="mb-1 small text-muted">${booking.customerEmail}</p>
                                    <p class="mb-0 small text-muted">${booking.customerPhone}</p>
                                </div>
                                <div class="col-sm-6">
                                    <h6 class="text-muted mb-2"><i class="fas fa-car me-1"></i>Vehicle Details</h6>
                                    <p class="mb-1"><strong>${booking.vehicleName}</strong></p>
                                    <p class="mb-1 small text-muted">${booking.vehicleType}</p>
                                    <p class="mb-0 small text-muted">$${booking.dailyPrice}/day</p>
                                </div>
                            </div>

                            <!-- Booking Dates -->
                            <div class="row mb-3">
                                <div class="col-sm-6">
                                    <h6 class="text-muted mb-2"><i class="fas fa-calendar-plus me-1"></i>Pickup Date</h6>
                                    <p class="mb-0">${booking.startDate}</p>
                                </div>
                                <div class="col-sm-6">
                                    <h6 class="text-muted mb-2"><i class="fas fa-calendar-minus me-1"></i>Return Date</h6>
                                    <p class="mb-0">${booking.endDate}</p>
                                </div>
                            </div>

                            <!-- Payment Information -->
                            <div class="mb-3">
                                <h6 class="text-muted mb-2"><i class="fas fa-credit-card me-1"></i>Payment Status</h6>
                                <c:choose>
                                    <c:when test="${not empty booking.paymentAmount}">
                                        <p class="mb-1"><strong>$${booking.paymentAmount}</strong> via ${booking.paymentMethod}</p>
                                        <p class="mb-0 small text-success"><i class="fas fa-check-circle me-1"></i>Payment Confirmed</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="mb-0 small text-warning"><i class="fas fa-exclamation-triangle me-1"></i>Payment Pending</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Vehicle Availability -->
                            <div class="mb-3">
                                <h6 class="text-muted mb-2"><i class="fas fa-info-circle me-1"></i>Vehicle Status</h6>
                                <span class="badge ${booking.vehicleAvailable ? 'bg-success' : 'bg-danger'}">
                                    ${booking.vehicleAvailable ? 'Available' : 'Currently Unavailable'}
                                </span>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex gap-2">
                                <form method="post" action="CustomerServiceServlet" class="d-inline" onsubmit="return confirm('Approve this booking?')">
                                    <input type="hidden" name="action" value="approve">
                                    <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                    <button type="submit" class="btn btn-success btn-sm action-btn" ${!booking.vehicleAvailable ? 'disabled' : ''}>
                                        <i class="fas fa-check me-1"></i>Approve
                                    </button>
                                </form>
                                <form method="post" action="CustomerServiceServlet" class="d-inline" onsubmit="return confirm('Cancel this booking?')">
                                    <input type="hidden" name="action" value="cancel">
                                    <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                    <button type="submit" class="btn btn-danger btn-sm action-btn">
                                        <i class="fas fa-times me-1"></i>Cancel
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty bookings}">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body text-center py-5">
                            <i class="fas fa-calendar-check fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">No Pending Bookings</h5>
                            <p class="text-muted">All bookings have been processed. Check back later for new requests.</p>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>