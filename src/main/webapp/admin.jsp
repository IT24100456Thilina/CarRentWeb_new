<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - CarGo Rentals</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding-top: 70px; }
        .brand-primary { color: #0d6efd; }
        .stat-card { background: #f8fbff; border: 1px solid #e8f0ff; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">CarRent</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="AdminServlet">Admin Panel</a></li>
                <c:choose>
                    <c:when test="${not empty sessionScope.username}">
                        <c:if test="${sessionScope.role == 'admin'}">
                            <li class="nav-item"><a class="nav-link" href="booking.jsp">Bookings</a></li>
                            <li class="nav-item"><a class="nav-link" href="payment.jsp">Payments</a></li>
                            <li class="nav-item"><a class="nav-link" href="feedback.jsp">Feedback</a></li>
                        </c:if>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                ${sessionScope.userFullName}
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

<div class="container mt-4">
    <c:choose>
        <c:when test="${empty sessionScope.username || sessionScope.role != 'admin'}">
            <div class="row g-4">
                <div class="col-lg-6">
                    <form class="card shadow p-4" action="AuthController" method="post">
                        <input type="hidden" name="action" value="login">
                        <h5 class="mb-3">Admin Login</h5>
                        <input type="hidden" name="role" value="admin">
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
                        <h5 class="mb-3">Create Admin Account</h5>
                        <input type="hidden" name="role" value="admin">
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
        </c:when>
        <c:otherwise>
            <h2 class="mb-3">Admin Dashboard</h2>

    <div class="row g-3 mb-4">
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

    <!-- Quick Links -->
    <div class="d-flex flex-wrap gap-2 mb-3">
        <a href="booking.jsp" class="btn btn-outline-primary btn-sm">Go to Bookings page</a>
        <a href="payment.jsp" class="btn btn-outline-primary btn-sm">Go to Payments page</a>
        <a href="feedback.jsp" class="btn btn-outline-primary btn-sm">Go to Feedback page</a>
        <a href="#" class="btn btn-outline-primary btn-sm" onclick="window.location='#promotions-manager'">Go to Promotions manager</a>
    </div>

    <!-- Vehicles Manager -->
    <div class="card shadow mb-4">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>Vehicles Catalogue</span>
            <div>
                <button class="btn btn-sm btn-primary" data-bs-toggle="collapse" data-bs-target="#vehicleForm">Add Vehicle</button>
            </div>
        </div>
        <div class="card-body">
            <div id="vehicleForm" class="collapse mb-3">
                <form class="row g-2" method="post" action="VehicleController">
                    <input type="hidden" name="action" value="add">
                    <div class="col-md-2"><input class="form-control" name="vehicleId" placeholder="ID" required></div>
                    <div class="col-md-3"><input class="form-control" name="vehicleName" placeholder="Name" required></div>
                    <div class="col-md-2"><input class="form-control" name="vehicleType" placeholder="Type" required></div>
                    <div class="col-md-2"><input class="form-control" name="dailyPrice" placeholder="Price" required></div>
                    <div class="col-md-2"><input class="form-control" name="imageUrl" placeholder="Image URL"></div>
                    <div class="col-md-1 d-grid"><button class="btn btn-success" type="submit">Save</button></div>
                </form>
            </div>
            <c:if test="${empty carList}">
                <div class="alert alert-info mb-0">No vehicles to display.</div>
            </c:if>
            <c:if test="${not empty carList}">
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Daily Price</th>
                            <th>Availability</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="car" items="${carList}">
                            <tr>
                                <td>${car.vehicleId}</td>
                                <td>${car.vehicleName}</td>
                                <td>${car.vehicleType}</td>
                                <td>$${car.dailyPrice}</td>
                                <td>
                                    <span class="badge ${car.available ? 'bg-success' : 'bg-danger'}">${car.available ? 'Available' : 'Unavailable'}</span>
                                </td>
                                <td class="d-flex gap-2">
                                    <form method="post" action="VehicleController" class="d-flex gap-1">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="vehicleId" value="${car.vehicleId}">
                                        <input type="hidden" name="vehicleName" value="${car.vehicleName}">
                                        <input type="hidden" name="vehicleType" value="${car.vehicleType}">
                                        <input type="hidden" name="dailyPrice" value="${car.dailyPrice}">
                                        <input type="hidden" name="available" value="${!car.available}">
                                        <input type="hidden" name="imageUrl" value="${car.imageUrl}">
                                        <button class="btn btn-sm btn-outline-secondary" type="submit">${car.available ? 'Mark Unavailable' : 'Mark Available'}</button>
                                    </form>
                                    <form method="post" action="VehicleController" onsubmit="return confirm('Delete vehicle?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="vehicleId" value="${car.vehicleId}">
                                        <button class="btn btn-sm btn-outline-danger" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Bookings Manager (update booking status via BookingController) -->
    <div class="card shadow mb-4">
        <div class="card-header">Bookings</div>
        <div class="card-body">
            <c:if test="${empty bookingList}">
                <div class="alert alert-info mb-0">No bookings to display.</div>
            </c:if>
            <c:if test="${not empty bookingList}">
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Vehicle</th>
                            <th>Pickup</th>
                            <th>Return</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="b" items="${bookingList}">
                            <tr>
                                <td>${b.bookingId}</td>
                                <td>${b.customerName}</td>
                                <td>${b.vehicleName}</td>
                                <td>${b.pickupDate}</td>
                                <td>${b.returnDate}</td>
                                <td><span class="badge bg-secondary">${b.status}</span></td>
                                <td>
                                    <form class="d-flex gap-2" method="post" action="BookingController">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="bookingId" value="${b.bookingId}">
                                        <select class="form-select form-select-sm" name="status">
                                            <option ${b.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                            <option ${b.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                            <option ${b.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                            <option ${b.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                        </select>
                                        <button class="btn btn-sm btn-primary" type="submit">Save</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Payments -->
    <div class="card shadow mb-4">
        <div class="card-header">Payments</div>
        <div class="card-body">
            <c:if test="${empty paymentList}">
                <div class="alert alert-info mb-0">No payments to display.</div>
            </c:if>
            <c:if test="${not empty paymentList}">
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Booking</th>
                            <th>Customer</th>
                            <th>Amount</th>
                            <th>Method</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="p" items="${paymentList}">
                            <tr>
                                <td>${p.paymentId}</td>
                                <td>${p.bookingId}</td>
                                <td>${p.customerName}</td>
                                <td>$${p.amount}</td>
                                <td>${p.paymentMethod}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Feedbacks -->
    <div class="card shadow mb-4">
        <div class="card-header">Feedbacks</div>
        <div class="card-body">
            <c:if test="${empty feedbackList}">
                <div class="alert alert-info mb-0">No feedbacks to display.</div>
            </c:if>
            <c:if test="${not empty feedbackList}">
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Booking</th>
                            <th>Customer</th>
                            <th>Rating</th>
                            <th>Comments</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="f" items="${feedbackList}">
                            <tr>
                                <td>${f.feedbackId}</td>
                                <td>${f.bookingId}</td>
                                <td>${f.customerName}</td>
                                <td>${f.rating}</td>
                                <td>${f.comments}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Users & Roles (if provided) -->
    <div class="card shadow mb-5">
        <div class="card-header">Users & Roles</div>
        <div class="card-body">
            <c:if test="${empty userList}">
                <div class="alert alert-info mb-0">No users to display.</div>
            </c:if>
            <c:if test="${not empty userList}">
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="u" items="${userList}">
                            <tr>
                                <td>${u.userId}</td>
                                <td>${u.fullName}</td>
                                <td>${u.username}</td>
                                <td>${u.email}</td>
                                <td>${u.role}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Promotions Manager -->
    <div class="card shadow mb-5" id="promotions-manager">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>Promotions</span>
            <button class="btn btn-sm btn-primary" data-bs-toggle="collapse" data-bs-target="#promoForm">Add Promotion</button>
        </div>
        <div class="card-body">
            <div id="promoForm" class="collapse mb-3">
                <form class="row g-2" method="post" action="PromotionController">
                    <input type="hidden" name="action" value="add">
                    <div class="col-md-3"><input class="form-control" name="title" placeholder="Title" required></div>
                    <div class="col-md-4"><input class="form-control" name="description" placeholder="Description" required></div>
                    <div class="col-md-2"><input class="form-control" name="badge" placeholder="Badge"></div>
                    <div class="col-md-2"><input type="date" class="form-control" name="validTill" placeholder="Valid Till"></div>
                    <div class="col-md-1 d-grid"><button class="btn btn-success" type="submit">Save</button></div>
                </form>
            </div>

            <c:if test="${empty promotions}">
                <div class="alert alert-info mb-0">No promotions found.</div>
            </c:if>
            <c:if test="${not empty promotions}">
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Badge</th>
                            <th>Valid Till</th>
                            <th>Active</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="p" items="${promotions}">
                            <tr>
                                <td>${p.id}</td>
                                <td>${p.title}</td>
                                <td>${p.description}</td>
                                <td>${p.badge}</td>
                                <td>${p.validTill}</td>
                                <td>
                                    <span class="badge ${p.active ? 'bg-success' : 'bg-secondary'}">${p.active ? 'Active' : 'Inactive'}</span>
                                </td>
                                <td class="d-flex gap-2">
                                    <form method="post" action="PromotionController" class="d-flex gap-2">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <input type="hidden" name="title" value="${p.title}">
                                        <input type="hidden" name="description" value="${p.description}">
                                        <input type="hidden" name="badge" value="${p.badge}">
                                        <input type="hidden" name="validTill" value="${p.validTill}">
                                        <input type="hidden" name="active" value="${!p.active}">
                                        <button class="btn btn-sm btn-outline-secondary" type="submit">${p.active ? 'Deactivate' : 'Activate'}</button>
                                    </form>
                                    <form method="post" action="PromotionController" onsubmit="return confirm('Delete this promotion?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button class="btn btn-sm btn-outline-danger" type="submit">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


