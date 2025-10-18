<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Fleet Management Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        :root {
            --primary-color: #0f172a;
            --primary-light: #1e293b;
            --accent-color: #3b82f6;
            --accent-light: #60a5fa;
            --text-dark: #0f172a;
            --text-light: #64748b;
            --text-white: #ffffff;
            --bg-white: #ffffff;
            --bg-gray: #f8fafc;
            --bg-dark: #0f172a;
            --border-color: #e2e8f0;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-gray); }
        .sidebar { background: var(--bg-white); min-height: 100vh; box-shadow: var(--shadow); position: fixed; width: 250px; z-index: 1000; }
        .sidebar .nav-link { color: var(--text-dark); padding: 0.75rem 1.5rem; border-radius: 8px; margin: 0.25rem 1rem; transition: all 0.3s ease; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background: rgba(59, 130, 246, 0.1); color: var(--accent-color); }
        .sidebar .nav-link i { width: 20px; margin-right: 0.75rem; }
        .main-content { margin-left: 250px; padding: 2rem; }
        .navbar { background: var(--bg-white); box-shadow: var(--shadow); border-bottom: 1px solid var(--border-color); }
        .stat-card { background: var(--bg-white); border: 1px solid var(--border-color); border-radius: 16px; box-shadow: var(--shadow); transition: all 0.3s ease; }
        .stat-card:hover { transform: translateY(-5px); box-shadow: var(--shadow-lg); }
        .card { border-radius: 16px; box-shadow: var(--shadow); border: none; }
        .btn-primary { background: linear-gradient(135deg, var(--accent-color), var(--accent-dark)); border: none; transition: all 0.3s ease; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3); }
        .table { border-radius: 12px; overflow: hidden; }
        .form-control, .form-select { border-radius: 8px; border: 2px solid var(--border-color); transition: border-color 0.3s ease; }
        .form-control:focus, .form-select:focus { border-color: var(--accent-color); box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25); }
        h2 { color: var(--text-dark); font-weight: 700; }
        .badge { border-radius: 20px; }
        .section-header { background: var(--bg-white); padding: 1.5rem; border-radius: 12px; margin-bottom: 1.5rem; box-shadow: var(--shadow); }
        .section-header h3 { color: var(--text-dark); font-weight: 600; margin: 0; }
        .stat-icon { width: 60px; height: 60px; background: linear-gradient(135deg, var(--accent-color), var(--accent-light)); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.5rem; margin-bottom: 1rem; }

        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar { width: 100%; position: relative; min-height: auto; }
            .main-content { margin-left: 0; }
            .navbar { display: none; }
            .section-header { padding: 1rem; }
            .stat-card { margin-bottom: 1rem; }
        }

        @media (min-width: 769px) {
            .sidebar { display: block !important; }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="p-3">
            <div class="d-flex align-items-center mb-4">
                <div class="logo me-3" style="width: 40px; height: 40px; background: linear-gradient(135deg, var(--accent-color), var(--accent-light)); border-radius: 10px; display: flex; align-items: center; justify-content: center; color: white; font-weight: 700;">CG</div>
                <h5 class="mb-0">CarGO Admin</h5>
            </div>
            <nav class="nav flex-column">
                <a class="nav-link active" href="#dashboard"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                <a class="nav-link" href="admin-crud.jsp"><i class="fas fa-database"></i>CRUD Management</a>
                <a class="nav-link" href="#vehicles"><i class="fas fa-car"></i>Vehicles</a>
                <a class="nav-link" href="#bookings"><i class="fas fa-calendar-check"></i>Bookings</a>
                <a class="nav-link" href="#payments"><i class="fas fa-credit-card"></i>Payments</a>
                <a class="nav-link" href="#users"><i class="fas fa-users"></i>Users</a>
                <a class="nav-link" href="#promotions"><i class="fas fa-tags"></i>Promotions</a>
                <a class="nav-link" href="CampaignController"><i class="fas fa-envelope"></i>Campaigns</a>
                <c:if test="${sessionScope.position == 'Manager' && sessionScope.department == 'Operations'}">
                    <a class="nav-link" href="OperationalReportServlet"><i class="fas fa-chart-line"></i>Operational Reports</a>
                </c:if>
                <a class="nav-link" href="#feedback"><i class="fas fa-star"></i>Feedback</a>
                <a class="nav-link" href="cargo-landing.jsp"><i class="fas fa-home"></i>Back to Site</a>
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
                <h4 class="mb-0">Fleet Management Dashboard</h4>
            </div>
            <div class="d-flex align-items-center">
                <c:if test="${not empty sessionScope.username}">
                    <span class="me-3 text-muted">
                        Welcome, ${sessionScope.userFullName}
                        <c:if test="${not empty sessionScope.position}">
                            <br><small class="text-primary">${sessionScope.position} - ${sessionScope.department}</small>
                        </c:if>
                    </span>
                    <a href="AuthController?action=logout" class="btn btn-outline-danger btn-sm">
                        <i class="fas fa-sign-out-alt me-1"></i>Logout
                    </a>
                </c:if>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <c:choose>
            <c:when test="${empty sessionScope.username || sessionScope.role != 'admin'}">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body p-5">
                                <div class="text-center mb-4">
                                    <div class="stat-icon mx-auto">
                                        <i class="fas fa-user-shield"></i>
                                    </div>
                                    <h3>Admin Access Required</h3>
                                    <p class="text-muted">Please login to access the fleet management dashboard.</p>
                                </div>
                                <div class="row g-4">
                                    <div class="col-md-6">
                                        <form action="AuthController" method="post">
                                            <input type="hidden" name="action" value="login">
                                            <input type="hidden" name="role" value="admin">
                                            <h5 class="mb-3">Admin Login</h5>
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
                                        <div class="mt-3">
                                            <small class="text-muted">
                                                <i class="fas fa-info-circle me-1"></i>
                                                <strong>Admin Job Roles:</strong> Marketing, Executive, Account
                                            </small>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <form action="AuthController" method="post">
                                            <input type="hidden" name="action" value="register">
                                            <input type="hidden" name="role" value="admin">
                                            <h5 class="mb-3">Create Admin Account</h5>
                                            <div class="row g-3">
                                                <div class="col-12">
                                                    <label class="form-label">Full Name</label>
                                                    <input type="text" class="form-control" name="fullName" required>
                                                </div>
                                                <div class="col-12">
                                                    <label class="form-label">Email</label>
                                                    <input type="email" class="form-control" name="email" required>
                                                </div>
                                                <div class="col-12">
                                                    <label class="form-label">Phone</label>
                                                    <input type="tel" class="form-control" name="phone" required>
                                                </div>
                                                <div class="col-12">
                                                    <label class="form-label">Username</label>
                                                    <input type="text" class="form-control" name="username" required>
                                                </div>
                                                <div class="col-12">
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
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Success/Error Messages -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${login == '1'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>Login successful! Welcome back, ${sessionScope.userFullName}
                        <c:if test="${not empty sessionScope.position}">
                            (${sessionScope.position} - ${sessionScope.department})
                        </c:if>.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Dashboard Overview -->
                <div id="dashboard" class="section-header">
                    <h3><i class="fas fa-chart-line me-2"></i>Dashboard Overview</h3>
                </div>

                <div class="row g-4 mb-5">
                    <div class="col-lg-3 col-md-6">
                        <div class="card stat-card text-center p-4">
                            <div class="stat-icon mx-auto">
                                <i class="fas fa-calendar-check"></i>
                            </div>
                            <div class="display-6 fw-bold text-primary">${totalBookings != null ? totalBookings : 0}</div>
                            <div class="text-muted">Total Bookings</div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card stat-card text-center p-4">
                            <div class="stat-icon mx-auto">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="display-6 fw-bold text-success">Rs${revenue != null ? revenue : 0}</div>
                            <div class="text-muted">Revenue</div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card stat-card text-center p-4">
                            <div class="stat-icon mx-auto">
                                <i class="fas fa-car"></i>
                            </div>
                            <div class="display-6 fw-bold text-info">${utilization != null ? utilization : 0}%</div>
                            <div class="text-muted">Vehicle Utilization</div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="card stat-card text-center p-4">
                            <div class="stat-icon mx-auto">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="display-6 fw-bold text-warning">${totalUsers != null ? totalUsers : 0}</div>
                            <div class="text-muted">Active Users</div>
                        </div>
                    </div>
                </div>

                <!-- Department Dashboards Section -->
                <div class="section-header">
                    <h3><i class="fas fa-tachometer-alt me-2"></i>Department Dashboards</h3>
                </div>

                <div class="row g-4 mb-5">
                    <!-- Operational Reports - Operations Department or System Administrators -->
                    <c:if test="${(sessionScope.position == 'Operations Manager' || sessionScope.position == 'Manager' && sessionScope.department == 'Operations' || sessionScope.department == 'Operations') ||
                                 (sessionScope.position == 'System Administrator' || sessionScope.position == 'Administrator')}">
                        <div class="col-lg-3 col-md-6">
                            <div class="card stat-card text-center p-4">
                                <div class="stat-icon mx-auto mb-3" style="background: linear-gradient(135deg, #f59e0b, #f97316);">
                                    <i class="fas fa-chart-line"></i>
                                </div>
                                <h5 class="mb-3">Operational Reports</h5>
                                <p class="text-muted mb-3">View operational performance and analytics</p>
                                <a href="OperationalReportServlet" class="btn btn-outline-warning">
                                    <i class="fas fa-arrow-right me-2"></i>View Reports
                                </a>
                            </div>
                        </div>
                    </c:if>

                    <!-- Customer Service - Customer Service Department or System Administrators -->
                    <c:if test="${(sessionScope.position == 'Customer Service Executive' || sessionScope.department == 'Customer Service') ||
                                 (sessionScope.position == 'System Administrator' || sessionScope.position == 'Administrator')}">
                        <div class="col-lg-3 col-md-6">
                            <div class="card stat-card text-center p-4">
                                <div class="stat-icon mx-auto mb-3" style="background: linear-gradient(135deg, #06b6d4, #0891b2);">
                                    <i class="fas fa-headset"></i>
                                </div>
                                <h5 class="mb-3">Customer Service</h5>
                                <p class="text-muted mb-3">Manage customer inquiries and support</p>
                                <a href="CustomerServiceServlet" class="btn btn-outline-info">
                                    <i class="fas fa-arrow-right me-2"></i>Open Dashboard
                                </a>
                            </div>
                        </div>
                    </c:if>

                    <!-- Income Reports - Accountants or System Administrators -->
                    <c:if test="${(sessionScope.position == 'Accountant' || sessionScope.department == 'Finance' || sessionScope.department == 'Accounting') ||
                                 (sessionScope.position == 'System Administrator' || sessionScope.position == 'Administrator')}">
                        <div class="col-lg-3 col-md-6">
                            <div class="card stat-card text-center p-4">
                                <div class="stat-icon mx-auto mb-3" style="background: linear-gradient(135deg, #10b981, #059669);">
                                    <i class="fas fa-coins"></i>
                                </div>
                                <h5 class="mb-3">Income Reports</h5>
                                <p class="text-muted mb-3">Financial analysis and revenue tracking</p>
                                <a href="IncomeReportServlet" class="btn btn-outline-success">
                                    <i class="fas fa-arrow-right me-2"></i>View Reports
                                </a>
                            </div>
                        </div>
                    </c:if>

                    <!-- Fleet Status - Fleet Management or System Administrators -->
                    <c:if test="${(sessionScope.position == 'Fleet Supervisor' || sessionScope.department == 'Fleet Management' || sessionScope.department == 'Fleet') ||
                                 (sessionScope.position == 'System Administrator' || sessionScope.position == 'Administrator')}">
                        <div class="col-lg-3 col-md-6">
                            <div class="card stat-card text-center p-4">
                                <div class="stat-icon mx-auto mb-3" style="background: linear-gradient(135deg, #8b5cf6, #7c3aed);">
                                    <i class="fas fa-bus"></i>
                                </div>
                                <h5 class="mb-3">Fleet Status</h5>
                                <p class="text-muted mb-3">Monitor vehicle fleet and availability</p>
                                <a href="FleetSupervisorServlet?action=viewFleet" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-right me-2"></i>View Status
                                </a>
                            </div>
                        </div>
                    </c:if>

                    <!-- Email Campaigns - Marketing or System Administrators -->
                    <c:if test="${(sessionScope.position == 'Marketing Executive' || sessionScope.department == 'Marketing' || sessionScope.position == 'Marketing Manager') ||
                                 (sessionScope.position == 'System Administrator' || sessionScope.position == 'Administrator')}">
                        <div class="col-lg-3 col-md-6">
                            <div class="card stat-card text-center p-4">
                                <div class="stat-icon mx-auto mb-3" style="background: linear-gradient(135deg, #ec4899, #db2777);">
                                    <i class="fas fa-envelope"></i>
                                </div>
                                <h5 class="mb-3">Email Campaigns</h5>
                                <p class="text-muted mb-3">Create and manage marketing campaigns</p>
                                <a href="CampaignController" class="btn btn-outline-danger">
                                    <i class="fas fa-arrow-right me-2"></i>Manage Campaigns
                                </a>
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Vehicles Management -->
                <div id="vehicles" class="section-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3><i class="fas fa-car me-2"></i>Fleet Management</h3>
                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#vehicleForm">
                            <i class="fas fa-plus me-1"></i>Add Vehicle
                        </button>
                    </div>
                </div>

                <div class="card mb-5">
                    <div class="card-body">
                        <div id="vehicleForm" class="collapse mb-4">
                            <form class="row g-3" method="post" action="VehicleController" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="add">
                                <div class="col-md-2"><input class="form-control" name="vehicleId" placeholder="ID" required></div>
                                <div class="col-md-3"><input class="form-control" name="vehicleName" placeholder="Model/Name" required></div>
                                <div class="col-md-2"><input class="form-control" name="vehicleType" placeholder="Type" required></div>
                                <div class="col-md-2"><input class="form-control" name="dailyPrice" placeholder="Price/Day" required></div>
                                <div class="col-md-2">
                                    <select class="form-select" name="available">
                                        <option value="true">Available</option>
                                        <option value="false">Unavailable</option>
                                    </select>
                                </div>
                                <div class="col-md-1 d-grid"><button class="btn btn-success" type="submit">Save</button></div>

                                <!-- Image Upload Section -->
                                <div class="col-12">
                                    <hr>
                                    <h6><i class="fas fa-image me-2"></i>Vehicle Image</h6>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Upload Image File</label>
                                            <input type="file" class="form-control" name="vehicleImage" accept="image/*" onchange="previewImage(this)">
                                            <div class="form-text">Supported formats: JPG, PNG, GIF, WebP</div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Or Enter Image URL</label>
                                            <input type="url" class="form-control" name="imageUrl" placeholder="https://example.com/image.jpg" onchange="previewUrl(this)">
                                        </div>
                                    </div>
                                    <div class="mt-3">
                                        <img id="imagePreview" src="" alt="Image Preview" style="max-width: 200px; max-height: 150px; display: none; border: 1px solid #ddd; border-radius: 5px;">
                                    </div>
                                </div>
                            </form>
                        </div>
                        <c:if test="${empty carList}">
                            <div class="alert alert-info mb-0">
                                <i class="fas fa-info-circle me-2"></i>No vehicles to display.
                            </div>
                        </c:if>
                        <c:if test="${not empty carList}">
                            <div class="table-responsive">
                                <table class="table table-striped align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="fas fa-hashtag me-1"></i>ID</th>
                                            <th><i class="fas fa-car me-1"></i>Name</th>
                                            <th><i class="fas fa-tags me-1"></i>Type</th>
                                            <th><i class="fas fa-dollar-sign me-1"></i>Daily Price</th>
                                            <th><i class="fas fa-check-circle me-1"></i>Status</th>
                                            <th><i class="fas fa-cogs me-1"></i>Actions</th>
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
                                                    <c:choose>
                                                        <c:when test="${car.available == true or car.available == 1 or car.available == 'Available'}">
                                                            <span class="badge bg-success"><i class="fas fa-check me-1"></i>Available</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-danger"><i class="fas fa-times me-1"></i>Unavailable</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="d-flex gap-2">
                                                    <form method="post" action="VehicleController" class="d-flex gap-2">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="vehicleId" value="${car.vehicleId}">
                                                        <input type="hidden" name="vehicleName" value="${car.vehicleName}">
                                                        <input type="hidden" name="vehicleType" value="${car.vehicleType}">
                                                        <input type="hidden" name="dailyPrice" value="${car.dailyPrice}">
                                                        <input type="hidden" name="available" value="${(car.available == true or car.available == 1) ? 'true' : 'false'}">
                                                        <button class="btn btn-sm btn-outline-secondary" type="submit">
                                                            <i class="fas fa-edit me-1"></i>Update
                                                        </button>
                                                    </form>
                                                    <form method="post" action="VehicleController" onsubmit="return confirm('Delete vehicle ${car.vehicleName}?')">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="vehicleId" value="${car.vehicleId}">
                                                        <button class="btn btn-sm btn-outline-danger" type="submit">
                                                            <i class="fas fa-trash me-1"></i>Delete
                                                        </button>
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

                <!-- Bookings Management -->
                <div id="bookings" class="section-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3><i class="fas fa-calendar-check me-2"></i>Bookings Management</h3>
                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#bookingForm">
                            <i class="fas fa-plus me-1"></i>Add Booking
                        </button>
                    </div>
                </div>

                <div class="card mb-5">
                    <div class="card-body">
                        <div id="bookingForm" class="collapse mb-3">
                            <form class="row g-2" method="post" action="BookingController">
                                <input type="hidden" name="action" value="create">
                                <div class="col-md-1"><input class="form-control" name="bookingId" placeholder="ID (auto)" readonly></div>
                                <div class="col-md-2"><input class="form-control" name="userId" placeholder="User ID" required></div>
                                <div class="col-md-2"><input class="form-control" name="vehicleId" placeholder="Vehicle ID" required></div>
                                <div class="col-md-2"><input class="form-control" name="pickupDate" type="date" required></div>
                                <div class="col-md-2"><input class="form-control" name="returnDate" type="date" required></div>
                                <div class="col-md-2">
                                    <select class="form-select" name="status">
                                        <option value="Pending">Pending</option>
                                        <option value="Confirmed">Confirmed</option>
                                        <option value="Cancelled">Cancelled</option>
                                        <option value="Completed">Completed</option>
                                    </select>
                                </div>
                                <div class="col-md-1 d-grid"><button class="btn btn-success" type="submit">Save</button></div>
                            </form>
                        </div>
                        <c:if test="${empty bookingList}">
                            <div class="alert alert-info mb-0">
                                <i class="fas fa-info-circle me-2"></i>No bookings to display.
                            </div>
                        </c:if>
                        <c:if test="${not empty bookingList}">
                            <div class="table-responsive">
                                <table class="table table-striped align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="fas fa-hashtag me-1"></i>ID</th>
                                            <th><i class="fas fa-user me-1"></i>Customer</th>
                                            <th><i class="fas fa-car me-1"></i>Vehicle</th>
                                            <th><i class="fas fa-calendar-plus me-1"></i>Pickup</th>
                                            <th><i class="fas fa-calendar-minus me-1"></i>Return</th>
                                            <th><i class="fas fa-info-circle me-1"></i>Status</th>
                                            <th><i class="fas fa-cogs me-1"></i>Actions</th>
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
                                                <td>
                                                    <span class="badge ${b.status == 'Confirmed' ? 'bg-success' : b.status == 'Pending' ? 'bg-warning' : b.status == 'Cancelled' ? 'bg-danger' : 'bg-secondary'}">${b.status}</span>
                                                </td>
                                                <td class="d-flex gap-2">
                                                    <form class="d-flex gap-2" method="post" action="BookingController">
                                                        <input type="hidden" name="action" value="updateStatus">
                                                        <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                        <select class="form-select form-select-sm" name="status">
                                                            <option ${b.status == 'Pending' ? 'selected' : ''}>Pending</option>
                                                            <option ${b.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                                                            <option ${b.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                                                            <option ${b.status == 'Completed' ? 'selected' : ''}>Completed</option>
                                                        </select>
                                                        <button class="btn btn-sm btn-primary" type="submit">
                                                            <i class="fas fa-save me-1"></i>Update
                                                        </button>
                                                    </form>
                                                    <form method="post" action="BookingController" onsubmit="return confirm('Delete booking #${b.bookingId}?')">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="bookingId" value="${b.bookingId}">
                                                        <button class="btn btn-sm btn-outline-danger" type="submit">
                                                            <i class="fas fa-trash me-1"></i>Delete
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
    
                        <!-- Show message if no department dashboards are accessible (excluding System Administrators) -->
                        <c:if test="${(sessionScope.position != 'System Administrator' && sessionScope.position != 'Administrator') &&
                                     ((sessionScope.position != 'Operations Manager' && sessionScope.position != 'Manager' || sessionScope.department != 'Operations') &&
                                      (sessionScope.position != 'Customer Service Executive' && sessionScope.department != 'Customer Service') &&
                                      (sessionScope.position != 'Accountant' && sessionScope.department != 'Finance' && sessionScope.department != 'Accounting') &&
                                      (sessionScope.position != 'Fleet Supervisor' && sessionScope.department != 'Fleet Management' && sessionScope.department != 'Fleet') &&
                                      (sessionScope.position != 'Marketing Executive' && sessionScope.department != 'Marketing' && sessionScope.position != 'Marketing Manager'))}">
                            <div class="col-12">
                                <div class="alert alert-info text-center">
                                    <i class="fas fa-info-circle me-2"></i>
                                    No department-specific dashboards available for your current role.
                                    <br><small>Contact your system administrator if you need access to specific department functions.</small>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Payments Management -->
                <div id="payments" class="section-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3><i class="fas fa-credit-card me-2"></i>Financial Management</h3>
                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#paymentForm">
                            <i class="fas fa-plus me-1"></i>Add Payment
                        </button>
                    </div>
                </div>

                <div class="card mb-5">
                    <div class="card-body">
                        <div id="paymentForm" class="collapse mb-3">
                            <form class="row g-2" method="post" action="PaymentController">
                                <input type="hidden" name="action" value="create">
                                <div class="col-md-2"><input class="form-control" name="paymentId" placeholder="ID (auto)" readonly></div>
                                <div class="col-md-2"><input class="form-control" name="bookingId" placeholder="Booking ID" required></div>
                                <div class="col-md-2"><input class="form-control" name="amount" type="number" step="0.01" placeholder="Amount" required></div>
                                <div class="col-md-3">
                                    <select class="form-select" name="paymentMethod" required>
                                        <option value="">Select Method</option>
                                        <option value="Credit Card">Credit Card</option>
                                        <option value="Debit Card">Debit Card</option>
                                        <option value="Cash">Cash</option>
                                        <option value="Online">Online</option>
                                    </select>
                                </div>
                                <div class="col-md-3 d-grid"><button class="btn btn-success" type="submit">Save</button></div>
                            </form>
                        </div>
                        <c:if test="${empty paymentList}">
                            <div class="alert alert-info mb-0">
                                <i class="fas fa-info-circle me-2"></i>No payments to display.
                            </div>
                        </c:if>
                        <c:if test="${not empty paymentList}">
                            <div class="table-responsive">
                                <table class="table table-striped align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="fas fa-hashtag me-1"></i>ID</th>
                                            <th><i class="fas fa-calendar-check me-1"></i>Booking</th>
                                            <th><i class="fas fa-user me-1"></i>Customer</th>
                                            <th><i class="fas fa-dollar-sign me-1"></i>Amount</th>
                                            <th><i class="fas fa-credit-card me-1"></i>Method</th>
                                            <th><i class="fas fa-cogs me-1"></i>Actions</th>
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
                                                <td class="d-flex gap-2">
                                                    <form method="post" action="PaymentController" class="d-flex gap-2">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="paymentId" value="${p.paymentId}">
                                                        <input type="hidden" name="bookingId" value="${p.bookingId}">
                                                        <input type="hidden" name="amount" value="${p.amount}">
                                                        <input type="hidden" name="paymentMethod" value="${p.paymentMethod}">
                                                        <button class="btn btn-sm btn-outline-secondary" type="submit">
                                                            <i class="fas fa-edit me-1"></i>Update
                                                        </button>
                                                    </form>
                                                    <form method="post" action="PaymentController" onsubmit="return confirm('Delete payment #${p.paymentId}?')">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="paymentId" value="${p.paymentId}">
                                                        <button class="btn btn-sm btn-outline-danger" type="submit">
                                                            <i class="fas fa-trash me-1"></i>Delete
                                                        </button>
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

                <!-- User Management -->
                <div id="users" class="section-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3><i class="fas fa-users me-2"></i>User Management</h3>
                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#userForm">
                            <i class="fas fa-plus me-1"></i>Add User
                        </button>
                    </div>
                </div>

                <div class="card mb-5">
                    <div class="card-body">
                        <div id="userForm" class="collapse mb-3">
                            <form class="row g-2" method="post" action="UserController">
                                <input type="hidden" name="action" value="create">
                                <div class="col-md-2"><input class="form-control" name="userId" placeholder="ID (auto)" readonly></div>
                                <div class="col-md-3"><input class="form-control" name="fullName" placeholder="Full Name" required></div>
                                <div class="col-md-2"><input class="form-control" name="username" placeholder="Username" required></div>
                                <div class="col-md-2"><input class="form-control" name="email" placeholder="Email" required></div>
                                <div class="col-md-2"><input class="form-control" name="password" placeholder="Password" required></div>
                                <div class="col-md-1 d-grid"><button class="btn btn-success" type="submit">Save</button></div>
                            </form>
                        </div>
                        <c:if test="${empty userList}">
                            <div class="alert alert-info mb-0">
                                <i class="fas fa-info-circle me-2"></i>No users to display.
                            </div>
                        </c:if>
                        <c:if test="${not empty userList}">
                            <div class="table-responsive">
                                <table class="table table-striped align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="fas fa-hashtag me-1"></i>ID</th>
                                            <th><i class="fas fa-user me-1"></i>Name</th>
                                            <th><i class="fas fa-at me-1"></i>Username</th>
                                            <th><i class="fas fa-envelope me-1"></i>Email</th>
                                            <th><i class="fas fa-cogs me-1"></i>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="u" items="${userList}">
                                            <tr>
                                                <td>${u.userId}</td>
                                                <td>${u.fullName}</td>
                                                <td>${u.username}</td>
                                                <td>${u.email}</td>
                                                <td class="d-flex gap-2">
                                                    <form method="post" action="UserController" class="d-flex gap-2">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="userId" value="${u.userId}">
                                                        <input type="hidden" name="fullName" value="${u.fullName}">
                                                        <input type="hidden" name="username" value="${u.username}">
                                                        <input type="hidden" name="email" value="${u.email}">
                                                        <input type="hidden" name="password" value="${u.password}">
                                                        <button class="btn btn-sm btn-outline-secondary" type="submit">
                                                            <i class="fas fa-edit me-1"></i>Update
                                                        </button>
                                                    </form>
                                                    <form method="post" action="UserController" onsubmit="return confirm('Delete user ${u.fullName}?')">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="userId" value="${u.userId}">
                                                        <button class="btn btn-sm btn-outline-danger" type="submit">
                                                            <i class="fas fa-trash me-1"></i>Delete
                                                        </button>
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

                <!-- Marketing & Promotions -->
                <div id="promotions" class="section-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3><i class="fas fa-tags me-2"></i>Marketing & Promotions</h3>
                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#promoForm">
                            <i class="fas fa-plus me-1"></i>Add Promotion
                        </button>
                    </div>
                </div>

                <div class="card mb-5">
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
                            <div class="alert alert-info mb-0">
                                <i class="fas fa-info-circle me-2"></i>No promotions found.
                            </div>
                        </c:if>
                        <c:if test="${not empty promotions}">
                            <div class="table-responsive">
                                <table class="table table-striped align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="fas fa-hashtag me-1"></i>ID</th>
                                            <th><i class="fas fa-tag me-1"></i>Title</th>
                                            <th><i class="fas fa-align-left me-1"></i>Description</th>
                                            <th><i class="fas fa-certificate me-1"></i>Badge</th>
                                            <th><i class="fas fa-calendar me-1"></i>Valid Till</th>
                                            <th><i class="fas fa-toggle-on me-1"></i>Status</th>
                                            <th><i class="fas fa-cogs me-1"></i>Actions</th>
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
                                                        <button class="btn btn-sm btn-outline-secondary" type="submit">
                                                            <i class="fas fa-${p.active ? 'ban' : 'check'} me-1"></i>${p.active ? 'Deactivate' : 'Activate'}
                                                        </button>
                                                    </form>
                                                    <form method="post" action="PromotionController" onsubmit="return confirm('Delete this promotion?')">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${p.id}">
                                                        <button class="btn btn-sm btn-outline-danger" type="submit">
                                                            <i class="fas fa-trash me-1"></i>Delete
                                                        </button>
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

    <!-- Customer Feedback -->
    <div id="feedback" class="section-header">
        <div class="d-flex justify-content-between align-items-center">
            <h3><i class="fas fa-star me-2"></i>Customer Feedback</h3>
            <form method="post" action="FeedbackController" onsubmit="return confirm('Delete ALL feedback? This action cannot be undone!')">
                <input type="hidden" name="action" value="deleteAll">
                <button class="btn btn-danger" type="submit">
                    <i class="fas fa-trash me-1"></i>Delete All Feedback
                </button>
            </form>
        </div>
    </div>

    <div class="card mb-5">
        <div class="card-body">
<c:if test="${empty feedbackList}">
    <div class="alert alert-info mb-0">
        <i class="fas fa-info-circle me-2"></i>No customer feedback available yet.
    </div>
</c:if>
<c:if test="${not empty feedbackList}">
    <div class="table-responsive">
        <table class="table table-striped align-middle">
            <thead class="table-light">
                <tr>
                    <th><i class="fas fa-hashtag me-1"></i>ID</th>
                    <th><i class="fas fa-calendar-check me-1"></i>Booking</th>
                    <th><i class="fas fa-user me-1"></i>Customer</th>
                    <th><i class="fas fa-star me-1"></i>Rating</th>
                    <th><i class="fas fa-comments me-1"></i>Comments</th>
                    <th><i class="fas fa-cogs me-1"></i>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="f" items="${feedbackList}">
                    <tr>
                        <td>${f.feedbackId}</td>
                        <td>${f.bookingId}</td>
                        <td>${f.customerName}</td>
                        <td>
                            <c:forEach begin="1" end="5" var="i">
                                <i class="fas fa-star ${i <= f.rating ? 'text-warning' : 'text-muted'}"></i>
                            </c:forEach>
                            <span class="ms-1">${f.rating}/5</span>
                        </td>
                        <td>${f.comments}</td>
                        <td>
                            <form method="post" action="FeedbackController" onsubmit="return confirm('Delete feedback #${f.feedbackId}?')">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="feedbackId" value="${f.feedbackId}">
                                <button class="btn btn-sm btn-outline-danger" type="submit">
                                    <i class="fas fa-trash me-1"></i>Delete
                                </button>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Show alerts for CRUD operations
    document.addEventListener('DOMContentLoaded', function() {
        showCrudAlerts();
    });

    function showCrudAlerts() {
        const urlParams = new URLSearchParams(window.location.search);

        // Booking alerts
        if (urlParams.get('bookingUpdated') === '1') {
            showAlert('Booking updated successfully!', 'success');
        } else if (urlParams.get('bookingDeleted') === '1') {
            showAlert('Booking deleted successfully!', 'success');
        }

        // Payment alerts
        if (urlParams.get('paymentUpdated') === '1') {
            showAlert('Payment updated successfully!', 'success');
        } else if (urlParams.get('paymentDeleted') === '1') {
            showAlert('Payment deleted successfully!', 'success');
        }

        // Vehicle alerts
        if (urlParams.get('vehiclesUpdated') === '1') {
            showAlert('Vehicle operation completed successfully!', 'success');
        }

        // User alerts
        if (urlParams.get('userCreated') === '1') {
            showAlert('User created successfully!', 'success');
        } else if (urlParams.get('userUpdated') === '1') {
            showAlert('User updated successfully!', 'success');
        } else if (urlParams.get('userDeleted') === '1') {
            showAlert('User deleted successfully!', 'success');
        }

        // Promotion alerts
        if (urlParams.get('promotionsUpdated') === '1') {
            showAlert('Promotion operation completed successfully!', 'success');
        }

        // Staff alerts
        if (urlParams.get('staffAdded') === '1') {
            showAlert('Staff member added successfully!', 'success');
        } else if (urlParams.get('staffUpdated') === '1') {
            showAlert('Staff member updated successfully!', 'success');
        } else if (urlParams.get('staffDeleted') === '1') {
            showAlert('Staff member deleted successfully!', 'success');
        }

        // Campaign alerts
        if (urlParams.get('campaignCreated') === '1') {
            showAlert('Campaign created successfully!', 'success');
        } else if (urlParams.get('campaignUpdated') === '1') {
            showAlert('Campaign updated successfully!', 'success');
        } else if (urlParams.get('campaignDeleted') === '1') {
            showAlert('Campaign deleted successfully!', 'success');
        } else if (urlParams.get('campaignSent') === '1') {
            showAlert('Campaign sent successfully!', 'success');
        }

        // Success messages
        const successMsg = urlParams.get('successMsg');
        if (successMsg) {
            showAlert(decodeURIComponent(successMsg), 'success');
        }

        // Error messages
        const errorMsg = urlParams.get('errorMsg');
        if (errorMsg) {
            showAlert(decodeURIComponent(errorMsg), 'danger');
        }
    }

    function showAlert(message, type) {
        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
        alertDiv.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
        alertDiv.innerHTML = `
            <i class="fas fa-${type == 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        document.body.appendChild(alertDiv);

        // Auto remove after 5 seconds
        setTimeout(() => {
            if (alertDiv.parentNode) {
                alertDiv.remove();
            }
        }, 5000);
    }
// Image preview functionality
function previewImage(input) {
    const preview = document.getElementById('imagePreview');
    const urlInput = document.querySelector('input[name="imageUrl"]');

    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            preview.src = e.target.result;
            preview.style.display = 'block';
            urlInput.value = ''; // Clear URL input when file is selected
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function previewUrl(input) {
    const preview = document.getElementById('imagePreview');
    const fileInput = document.querySelector('input[name="vehicleImage"]');

    if (input.value) {
        preview.src = input.value;
        preview.style.display = 'block';
        fileInput.value = ''; // Clear file input when URL is entered
    } else {
        preview.style.display = 'none';
    }
}

// Form validation
document.querySelector('form[action="VehicleController"]').addEventListener('submit', function(e) {
    const fileInput = document.querySelector('input[name="vehicleImage"]');
    const urlInput = document.querySelector('input[name="imageUrl"]');

    if (!fileInput.files[0] && !urlInput.value) {
        alert('Please either upload an image file or provide an image URL.');
        e.preventDefault();
        return false;
    }

    // Show loading state
    const submitBtn = this.querySelector('button[type="submit"]');
    const originalText = submitBtn.innerHTML;
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
    submitBtn.disabled = true;

    // Re-enable after 3 seconds (in case of slow response)
    setTimeout(() => {
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
    }, 3000);
});
</script>
</body>
</html>


