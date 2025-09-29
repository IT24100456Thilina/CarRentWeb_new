<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="com.example.carrentweb.ControlSql.DBConnection" %>
<%
    // Load data for admin CRUD if not already loaded
    if (request.getAttribute("carList") == null) {
        List<Map<String, Object>> cars = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl FROM Vehicles");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> c = new HashMap<>();
                c.put("vehicleId", rs.getInt("vehicleId"));
                c.put("vehicleName", rs.getString("vehicleName"));
                c.put("vehicleType", rs.getString("vehicleType"));
                c.put("dailyPrice", rs.getDouble("dailyPrice"));
                c.put("available", rs.getObject("available"));
                c.put("imageUrl", rs.getString("imageUrl"));
                cars.add(c);
            }
        } catch (Exception ignore) {}
        request.setAttribute("carList", cars);
    }

    if (request.getAttribute("bookingList") == null) {
        List<Map<String, Object>> bookings = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT b.bookingId, b.startDate, b.endDate, b.status, " +
                "u.fullName as customerName, v.vehicleName " +
                "FROM Bookings b " +
                "JOIN Users u ON b.userId = u.userId " +
                "JOIN Vehicles v ON b.vehicleId = v.vehicleId"
            );
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> b = new HashMap<>();
                b.put("bookingId", rs.getInt("bookingId"));
                b.put("pickupDate", rs.getString("startDate"));
                b.put("returnDate", rs.getString("endDate"));
                b.put("status", rs.getString("status"));
                b.put("customerName", rs.getString("customerName"));
                b.put("vehicleName", rs.getString("vehicleName"));
                bookings.add(b);
            }
        } catch (Exception ignore) {}
        request.setAttribute("bookingList", bookings);
    }

    if (request.getAttribute("paymentList") == null) {
        List<Map<String, Object>> payments = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT p.paymentId, p.bookingId, p.amount, p.paymentMethod, " +
                "u.fullName as customerName " +
                "FROM Payments p " +
                "JOIN Bookings b ON p.bookingId = b.bookingId " +
                "JOIN Users u ON b.userId = u.userId"
            );
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> p = new HashMap<>();
                p.put("paymentId", rs.getInt("paymentId"));
                p.put("bookingId", rs.getInt("bookingId"));
                p.put("amount", rs.getDouble("amount"));
                p.put("paymentMethod", rs.getString("paymentMethod"));
                p.put("customerName", rs.getString("customerName"));
                payments.add(p);
            }
        } catch (Exception ignore) {}
        request.setAttribute("paymentList", payments);
    }

    if (request.getAttribute("userList") == null) {
        List<Map<String, Object>> users = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT userId, fullName, username, email, role FROM Users");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> u = new HashMap<>();
                u.put("userId", rs.getInt("userId"));
                u.put("fullName", rs.getString("fullName"));
                u.put("username", rs.getString("username"));
                u.put("email", rs.getString("email"));
                u.put("role", rs.getString("role"));
                users.add(u);
            }
        } catch (Exception ignore) {}
        request.setAttribute("userList", users);
    }

    if (request.getAttribute("promotions") == null) {
        List<Map<String, String>> promotions = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT id, title, description, badge, validTill, active FROM Promotions ORDER BY id DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, String> p = new HashMap<>();
                p.put("id", String.valueOf(rs.getInt("id")));
                p.put("title", rs.getString("title"));
                p.put("description", rs.getString("description"));
                p.put("badge", rs.getString("badge"));
                p.put("validTill", rs.getString("validTill"));
                p.put("active", String.valueOf(rs.getBoolean("active")));
                promotions.add(p);
            }
        } catch (Exception ignore) {}
        request.setAttribute("promotions", promotions);
    }

    if (request.getAttribute("campaigns") == null) {
        List<Map<String, String>> campaigns = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT campaignId, subject, body, offer, segment, status, createdDate, sentDate, sentCount FROM Campaigns ORDER BY createdDate DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, String> c = new HashMap<>();
                c.put("campaignId", String.valueOf(rs.getInt("campaignId")));
                c.put("subject", rs.getString("subject"));
                c.put("body", rs.getString("body"));
                c.put("offer", rs.getString("offer"));
                c.put("segment", rs.getString("segment"));
                c.put("status", rs.getString("status"));
                c.put("createdDate", rs.getString("createdDate"));
                c.put("sentDate", rs.getString("sentDate"));
                c.put("sentCount", String.valueOf(rs.getInt("sentCount")));
                campaigns.add(c);
            }
        } catch (Exception ignore) {}
        request.setAttribute("campaigns", campaigns);
    }

    if (request.getAttribute("feedbackList") == null) {
        List<Map<String, Object>> feedbackList = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT f.feedbackId, f.bookingId, f.comments, f.rating, f.dateSubmitted, " +
                "u.fullName as customerName " +
                "FROM Feedbacks f " +
                "JOIN Users u ON f.userId = u.userId " +
                "ORDER BY f.dateSubmitted DESC"
            );
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> f = new HashMap<>();
                f.put("feedbackId", rs.getInt("feedbackId"));
                f.put("bookingId", rs.getObject("bookingId"));
                f.put("comments", rs.getString("comments"));
                f.put("rating", rs.getInt("rating"));
                f.put("dateSubmitted", rs.getString("dateSubmitted"));
                f.put("customerName", rs.getString("customerName"));
                feedbackList.add(f);
            }
        } catch (Exception ignore) {}
        request.setAttribute("feedbackList", feedbackList);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CRUD Management - Fleet Management Platform</title>
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
            padding: 1rem;   /* reduced padding to remove excess space */
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
            margin-top: 0;   /* prevent table pushing down */
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
            padding: 1rem;   /* reduced padding */
            border-radius: 12px;
            margin-bottom: 0.75rem; /* reduce gap */
            box-shadow: var(--shadow);
        }

        .section-header h3 {
            color: var(--text-dark);
            font-weight: 600;
            margin: 0;
        }

        .crud-tabs .nav-link {
            border: none;
            color: var(--text-light);
            font-weight: 500;
        }

        .crud-tabs .nav-link.active {
            background: var(--accent-color);
            color: white;
        }

        .action-btn {
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
            border-radius: 6px;
        }

        /* Fix Campaign Management spacing */
        .campaign-section {
            margin-top: 0 !important;
            padding-top: 0 !important;
        }


        /* Responsive Design */
        @media (max-width: 768px) {
            .sidebar { width: 100%; position: relative; min-height: auto; }
            .main-content { margin-left: 0; }
            .navbar { display: none; }
            .section-header { padding: 1rem; }
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
                <a class="nav-link" href="AdminServlet"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                <a class="nav-link active" href="admin-crud.jsp"><i class="fas fa-database"></i>CRUD Management</a>
                <a class="nav-link" href="#vehicles"><i class="fas fa-car"></i>Vehicles</a>
                <a class="nav-link" href="#bookings"><i class="fas fa-calendar-check"></i>Bookings</a>
                <a class="nav-link" href="#payments"><i class="fas fa-credit-card"></i>Payments</a>
                <a class="nav-link" href="#users"><i class="fas fa-users"></i>Users</a>
                <a class="nav-link" href="#promotions"><i class="fas fa-tags"></i>Promotions</a>
                <a class="nav-link" href="#campaigns"><i class="fas fa-envelope"></i>Campaigns</a>
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
                <h4 class="mb-0">CRUD Management System</h4>
            </div>
            <div class="d-flex align-items-center">
                <c:if test="${not empty sessionScope.username}">
                    <span class="me-3 text-muted">Welcome, ${sessionScope.userFullName}</span>
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
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body p-5 text-center">
                                <div class="mb-4">
                                    <i class="fas fa-user-shield fa-3x text-primary mb-3"></i>
                                    <h3>Access Restricted</h3>
                                    <p class="text-muted">Admin privileges required to access CRUD management.</p>
                                </div>
                                <a href="admin-dashboard.jsp" class="btn btn-primary">
                                    <i class="fas fa-arrow-left me-2"></i>Go to Admin Dashboard
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- CRUD Tabs -->
                <div class="section-header">
                    <h3><i class="fas fa-database me-2"></i>Complete CRUD Operations</h3>
                </div>

                <div class="card">
                    <div class="card-body">
                        <ul class="nav nav-tabs crud-tabs mb-4" id="crudTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="vehicles-tab" data-bs-toggle="tab" data-bs-target="#vehicles-tab-pane" type="button" role="tab">
                                    <i class="fas fa-car me-1"></i>Vehicles
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="bookings-tab" data-bs-toggle="tab" data-bs-target="#bookings-tab-pane" type="button" role="tab">
                                    <i class="fas fa-calendar-check me-1"></i>Bookings
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="payments-tab" data-bs-toggle="tab" data-bs-target="#payments-tab-pane" type="button" role="tab">
                                    <i class="fas fa-credit-card me-1"></i>Payments
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="users-tab" data-bs-toggle="tab" data-bs-target="#users-tab-pane" type="button" role="tab">
                                    <i class="fas fa-users me-1"></i>Users
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="promotions-tab" data-bs-toggle="tab" data-bs-target="#promotions-tab-pane" type="button" role="tab">
                                    <i class="fas fa-tags me-1"></i>Promotions
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="feedback-tab" data-bs-toggle="tab" data-bs-target="#feedback-tab-pane" type="button" role="tab">
                                    <i class="fas fa-star me-1"></i>Feedback
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="campaigns-tab" data-bs-toggle="tab" data-bs-target="#campaigns-tab-pane" type="button" role="tab">
                                    <i class="fas fa-envelope me-1"></i>Campaigns
                                </button>
                            </li>
                        </ul>

                        <div class="tab-content" id="crudTabContent">
                            <!-- Vehicles CRUD -->
                            <div class="tab-pane fade show active" id="vehicles-tab-pane" role="tabpanel">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h4><i class="fas fa-car me-2"></i>Vehicle Management</h4>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-danger btn-sm" onclick="deleteSelectedVehicles()">
                                            <i class="fas fa-trash me-1"></i>Delete Selected
                                        </button>
                                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#vehicleForm" onclick="resetVehicleForm()">
                                            <i class="fas fa-plus me-1"></i>Add Vehicle
                                        </button>
                                    </div>
                                </div>

                                <div id="vehicleForm" class="collapse mb-4">
                                     <div class="card">
                                         <div class="card-header">
                                             <h6 id="vehicleFormTitle"><i class="fas fa-plus me-2"></i>Add New Vehicle</h6>
                                         </div>
                                         <div class="card-body">
                                             <form class="row g-3" method="post" action="VehicleController" enctype="multipart/form-data" id="vehicleFormElement">
                                                 <input type="hidden" name="action" value="add" id="vehicleAction">
                                                 <div class="col-md-2"><input class="form-control" name="vehicleId" id="vehicleId" placeholder="ID" required type="number"></div>
                                                 <div class="col-md-3"><input class="form-control" name="vehicleName" id="vehicleName" placeholder="Model/Name" required></div>
                                                 <div class="col-md-2"><input class="form-control" name="vehicleType" id="vehicleType" placeholder="Type" required></div>
                                                 <div class="col-md-2"><input class="form-control" name="dailyPrice" id="vehiclePrice" placeholder="Price/Day" required></div>
                                                 <div class="col-md-2">
                                                     <select class="form-select" name="available" id="vehicleAvailable">
                                                         <option value="true">Available</option>
                                                         <option value="false">Unavailable</option>
                                                     </select>
                                                 </div>
                                                 <div class="col-md-1 d-grid"><button class="btn btn-success" type="submit" id="vehicleSubmitBtn">Save</button></div>
                                                 <div class="col-12">
                                                     <hr>
                                                     <h6><i class="fas fa-image me-2"></i>Vehicle Image</h6>
                                                     <div class="row g-3">
                                                         <div class="col-md-6">
                                                             <input type="file" class="form-control" name="vehicleImage" id="vehicleImageFile" accept="image/*">
                                                         </div>
                                                         <div class="col-md-6">
                                                             <input type="url" class="form-control" name="imageUrl" id="vehicleImageUrl" placeholder="Or enter image URL">
                                                         </div>
                                                     </div>
                                                 </div>
                                             </form>
                                         </div>
                                     </div>
                                 </div>

                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead class="table-dark">
                                            <tr>
                                                <th><input type="checkbox" id="selectAllVehicles" onclick="toggleAllVehicles()"></th>
                                                <th>ID</th><th>Name</th><th>Type</th><th>Price/Day</th><th>Status</th><th>Image</th><th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="car" items="${carList}">
                                                <tr>
                                                    <td><input type="checkbox" class="vehicle-checkbox" value="${car.vehicleId}"></td>
                                                    <td>${car.vehicleId}</td>
                                                    <td>${car.vehicleName}</td>
                                                    <td>${car.vehicleType}</td>
                                                    <td>$${car.dailyPrice}</td>
                                                    <td><span class="badge ${car.available ? 'bg-success' : 'bg-danger'}">${car.available ? 'Available' : 'Unavailable'}</span></td>
                                                    <td>
                                                        <c:if test="${not empty car.imageUrl}">
                                                            <img src="${car.imageUrl}" alt="${car.vehicleName}" style="width: 60px; height: 40px; object-fit: cover; border-radius: 4px;">
                                                        </c:if>
                                                        <c:if test="${empty car.imageUrl}">
                                                            <div style="width: 60px; height: 40px; background: #f8f9fa; border: 1px solid #dee2e6; border-radius: 4px; display: flex; align-items: center; justify-content: center;">
                                                                <i class="fas fa-image text-muted"></i>
                                                            </div>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary action-btn me-1" onclick="editVehicle('${car.vehicleId}')">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-danger action-btn" onclick="deleteVehicle('${car.vehicleId}')">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Bookings CRUD -->
                            <div class="tab-pane fade" id="bookings-tab-pane" role="tabpanel">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h4><i class="fas fa-calendar-check me-2"></i>Booking Management</h4>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-danger btn-sm" onclick="deleteSelectedBookings()">
                                            <i class="fas fa-trash me-1"></i>Delete Selected
                                        </button>
                                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#bookingForm" onclick="resetBookingForm()">
                                            <i class="fas fa-plus me-1"></i>Add Booking
                                        </button>
                                    </div>
                                </div>

                                <div id="bookingForm" class="collapse mb-4">
                                     <div class="card">
                                         <div class="card-header">
                                             <h6 id="bookingFormTitle"><i class="fas fa-plus me-2"></i>Add New Booking</h6>
                                         </div>
                                         <div class="card-body">
                                             <form class="row g-3" method="post" action="BookingController" id="bookingFormElement">
                                                 <input type="hidden" name="action" value="create" id="bookingAction">
                                                 <input type="hidden" name="bookingId" id="bookingId">
                                                 <div class="col-md-2"><input class="form-control" name="userId" id="bookingUserId" placeholder="User ID" required></div>
                                                 <div class="col-md-2"><input class="form-control" name="vehicleId" id="bookingVehicleId" placeholder="Vehicle ID" required></div>
                                                 <div class="col-md-2"><input class="form-control" name="startDate" id="bookingStartDate" type="date" required></div>
                                                 <div class="col-md-2"><input class="form-control" name="endDate" id="bookingEndDate" type="date" required></div>
                                                 <div class="col-md-2">
                                                     <select class="form-select" name="status" id="bookingStatus">
                                                         <option value="Pending">Pending</option>
                                                         <option value="Confirmed">Confirmed</option>
                                                         <option value="Completed">Completed</option>
                                                         <option value="Cancelled">Cancelled</option>
                                                     </select>
                                                 </div>
                                                 <div class="col-md-2 d-grid"><button class="btn btn-success" type="submit" id="bookingSubmitBtn">Create</button></div>
                                             </form>
                                         </div>
                                     </div>
                                 </div>

                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead class="table-dark">
                                            <tr>
                                                <th><input type="checkbox" id="selectAllBookings" onclick="toggleAllBookings()"></th>
                                                <th>ID</th><th>Customer</th><th>Vehicle</th><th>Pickup</th><th>Return</th><th>Status</th><th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="b" items="${bookingList}">
                                                <tr>
                                                    <td><input type="checkbox" class="booking-checkbox" value="${b.bookingId}"></td>
                                                    <td>${b.bookingId}</td>
                                                    <td>${b.customerName}</td>
                                                    <td>${b.vehicleName}</td>
                                                    <td>${b.pickupDate}</td>
                                                    <td>${b.returnDate}</td>
                                                    <td><span class="badge bg-secondary">${b.status}</span></td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary action-btn me-1" onclick="editBooking('${b.bookingId}')">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-danger action-btn" onclick="deleteBooking('${b.bookingId}')">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Payments CRUD -->
                            <div class="tab-pane fade" id="payments-tab-pane" role="tabpanel">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h4><i class="fas fa-credit-card me-2"></i>Payment Management</h4>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-danger btn-sm" onclick="deleteSelectedPayments()">
                                            <i class="fas fa-trash me-1"></i>Delete Selected
                                        </button>
                                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#paymentForm" onclick="resetPaymentForm()">
                                            <i class="fas fa-plus me-1"></i>Add Payment
                                        </button>
                                    </div>
                                </div>

                                <div id="paymentForm" class="collapse mb-4">
                                     <div class="card">
                                         <div class="card-header">
                                             <h6 id="paymentFormTitle"><i class="fas fa-plus me-2"></i>Add New Payment</h6>
                                         </div>
                                         <div class="card-body">
                                             <form class="row g-3" method="post" action="PaymentController" id="paymentFormElement">
                                                 <input type="hidden" name="action" value="create" id="paymentAction">
                                                 <input type="hidden" name="paymentId" id="paymentId">
                                                 <div class="col-md-3"><input class="form-control" name="bookingId" id="paymentBookingId" placeholder="Booking ID" required></div>
                                                 <div class="col-md-3"><input class="form-control" name="amount" id="paymentAmount" type="number" step="0.01" placeholder="Amount" required></div>
                                                 <div class="col-md-3">
                                                     <select class="form-select" name="paymentMethod" id="paymentMethod" required>
                                                         <option value="">Select Method</option>
                                                         <option value="Credit Card">Credit Card</option>
                                                         <option value="Debit Card">Debit Card</option>
                                                         <option value="Cash">Cash</option>
                                                         <option value="PayPal">PayPal</option>
                                                     </select>
                                                 </div>
                                                 <div class="col-md-3 d-grid"><button class="btn btn-success" type="submit" id="paymentSubmitBtn">Create</button></div>
                                             </form>
                                         </div>
                                     </div>
                                 </div>

                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead class="table-dark">
                                            <tr>
                                                <th><input type="checkbox" id="selectAllPayments" onclick="toggleAllPayments()"></th>
                                                <th>ID</th><th>Booking</th><th>Customer</th><th>Amount</th><th>Method</th><th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="p" items="${paymentList}">
                                                <tr>
                                                    <td><input type="checkbox" class="payment-checkbox" value="${p.paymentId}"></td>
                                                    <td>${p.paymentId}</td>
                                                    <td>${p.bookingId}</td>
                                                    <td>${p.customerName}</td>
                                                    <td>Rs${p.amount}</td>
                                                    <td>${p.paymentMethod}</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary action-btn me-1" onclick="editPayment('${p.paymentId}')">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-danger action-btn" onclick="deletePayment('${p.paymentId}')">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Users CRUD -->
                            <div class="tab-pane fade" id="users-tab-pane" role="tabpanel">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h4><i class="fas fa-users me-2"></i>User Management</h4>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-danger btn-sm" onclick="deleteSelectedUsers()">
                                            <i class="fas fa-trash me-1"></i>Delete Selected
                                        </button>
                                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#userForm" onclick="resetUserForm()">
                                            <i class="fas fa-plus me-1"></i>Add User
                                        </button>
                                    </div>
                                </div>

                                <div id="userForm" class="collapse mb-4">
                                     <div class="card">
                                         <div class="card-header">
                                             <h6 id="userFormTitle"><i class="fas fa-plus me-2"></i>Add New User</h6>
                                         </div>
                                         <div class="card-body">
                                             <form class="row g-3" method="post" action="UserController" id="userFormElement">
                                                 <input type="hidden" name="action" value="create" id="userAction">
                                                 <input type="hidden" name="userId" id="userId">
                                                 <div class="col-md-3"><input class="form-control" name="fullName" id="userFullName" placeholder="Full Name" required></div>
                                                 <div class="col-md-3"><input class="form-control" name="username" id="userUsername" placeholder="Username" required></div>
                                                 <div class="col-md-3"><input class="form-control" name="email" id="userEmail" placeholder="Email" required></div>
                                                 <div class="col-md-3"><input class="form-control" name="password" id="userPassword" placeholder="Password" required></div>
                                                 <div class="col-12 d-grid"><button class="btn btn-success" type="submit" id="userSubmitBtn">Create User</button></div>
                                             </form>
                                         </div>
                                     </div>
                                 </div>

                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead class="table-dark">
                                            <tr>
                                                <th><input type="checkbox" id="selectAllUsers" onclick="toggleAllUsers()"></th>
                                                <th>ID</th><th>Name</th><th>Username</th><th>Email</th><th>Role</th><th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="u" items="${userList}">
                                                <tr>
                                                    <td><input type="checkbox" class="user-checkbox" value="${u.userId}"></td>
                                                    <td>${u.userId}</td>
                                                    <td>${u.fullName}</td>
                                                    <td>${u.username}</td>
                                                    <td>${u.email}</td>
                                                    <td><span class="badge bg-info">${u.role}</span></td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-secondary action-btn me-1" onclick="editUser('${u.userId}')">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-primary action-btn me-1" onclick="updateRole('${u.userId}', '${u.role}')">
                                                            <i class="fas fa-user-cog"></i> Update Role
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-danger action-btn" onclick="deleteUser('${u.userId}')">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Promotions CRUD -->
                            <div class="tab-pane fade" id="promotions-tab-pane" role="tabpanel">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h4><i class="fas fa-tags me-2"></i>Promotion Management</h4>
                                    <div class="d-flex gap-2">
                                        <button class="btn btn-danger btn-sm" onclick="deleteSelectedPromotions()">
                                            <i class="fas fa-trash me-1"></i>Delete Selected
                                        </button>
                                        <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#promoForm" onclick="resetPromoForm()">
                                            <i class="fas fa-plus me-1"></i>Add Promotion
                                        </button>
                                    </div>
                                </div>

                                <div id="promoForm" class="collapse mb-4">
                                     <div class="card">
                                         <div class="card-header">
                                             <h6 id="promoFormTitle"><i class="fas fa-plus me-2"></i>Add New Promotion</h6>
                                         </div>
                                         <div class="card-body">
                                             <form class="row g-3" method="post" action="PromotionController" id="promoFormElement">
                                                 <input type="hidden" name="action" value="add" id="promoAction">
                                                 <input type="hidden" name="id" id="promoId">
                                                 <div class="col-md-4"><input class="form-control" name="title" id="promoTitle" placeholder="Title" required></div>
                                                 <div class="col-md-4"><input class="form-control" name="description" id="promoDescription" placeholder="Description" required></div>
                                                 <div class="col-md-2"><input class="form-control" name="badge" id="promoBadge" placeholder="Badge"></div>
                                                 <div class="col-md-2"><input type="date" class="form-control" name="validTill" id="promoValidTill" placeholder="Valid Till"></div>
                                                 <div class="col-12 d-grid"><button class="btn btn-success" type="submit" id="promoSubmitBtn">Create Promotion</button></div>
                                             </form>
                                         </div>
                                     </div>
                                 </div>

                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead class="table-dark">
                                            <tr>
                                                <th><input type="checkbox" id="selectAllPromotions" onclick="toggleAllPromotions()"></th>
                                                <th>ID</th><th>Title</th><th>Description</th><th>Badge</th><th>Valid Till</th><th>Status</th><th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="p" items="${promotions}">
                                                <tr>
                                                    <td><input type="checkbox" class="promotion-checkbox" value="${p.id}"></td>
                                                    <td>${p.id}</td>
                                                    <td>${p.title}</td>
                                                    <td>${p.description}</td>
                                                    <td>${p.badge}</td>
                                                    <td>${p.validTill}</td>
                                                    <td><span class="badge ${p.active ? 'bg-success' : 'bg-secondary'}">${p.active ? 'Active' : 'Inactive'}</span></td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary action-btn me-1" onclick="editPromotion('${p.id}')">
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-warning action-btn me-1" onclick="togglePromotion('${p.id}')">
                                                            <i class="fas fa-toggle-${p.active ? 'off' : 'on'}"></i>
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-danger action-btn" onclick="deletePromotion('${p.id}')">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Feedback CRUD -->
                        <div class="tab-pane fade" id="feedback-tab-pane" role="tabpanel">
                            <!-- Success/Error Messages -->
                            <c:if test="${not empty param.success}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>${param.success}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            <c:if test="${not empty param.error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-triangle me-2"></i>${param.error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4><i class="fas fa-star me-2"></i>Feedback Management</h4>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-danger btn-sm" onclick="deleteSelectedFeedback()">
                                        <i class="fas fa-trash me-1"></i>Delete Selected
                                    </button>
                                    <form method="post" action="FeedbackController" onsubmit="return confirm('Delete ALL feedback? This action cannot be undone!')" style="display: inline;">
                                        <input type="hidden" name="action" value="deleteAll">
                                        <button class="btn btn-danger btn-sm" type="submit">
                                            <i class="fas fa-trash me-1"></i>Delete All Feedback
                                        </button>
                                    </form>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead class="table-dark">
                                        <tr>
                                            <th><input type="checkbox" id="selectAllFeedback" onclick="toggleAllFeedback()"></th>
                                            <th>ID</th><th>Customer</th><th>Booking</th><th>Rating</th><th>Comments</th><th>Date</th><th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="f" items="${feedbackList}">
                                            <tr>
                                                <td><input type="checkbox" class="feedback-checkbox" value="${f.feedbackId}"></td>
                                                <td>${f.feedbackId}</td>
                                                <td>${f.customerName}</td>
                                                <td>${f.bookingId != null ? f.bookingId : 'N/A'}</td>
                                                <td>
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="fas fa-star ${i <= f.rating ? 'text-warning' : 'text-muted'}"></i>
                                                    </c:forEach>
                                                    <span class="ms-1">${f.rating}/5</span>
                                                </td>
                                                <td>
                                                    <span title="${f.comments}">
                                                        ${f.comments.length() > 50 ? f.comments.substring(0, 50).concat("...") : f.comments}
                                                    </span>
                                                </td>
                                                <td>${f.dateSubmitted}</td>
                                                <td>
                                                    <form method="post" action="FeedbackController" onsubmit="return confirm('Delete feedback #${f.feedbackId}?')" style="display: inline;">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="feedbackId" value="${f.feedbackId}">
                                                        <button class="btn btn-sm btn-outline-danger action-btn" type="submit">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <!-- Campaigns CRUD -->
                        <div class="tab-pane fade" id="campaigns-tab-pane" role="tabpanel">
                            <!-- Success/Error Messages -->
                            <c:if test="${not empty param.success}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>${param.success}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            <c:if test="${not empty param.error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <i class="fas fa-exclamation-triangle me-2"></i>${param.error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4><i class="fas fa-envelope me-2"></i>Campaign Management</h4>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-danger btn-sm" onclick="deleteSelectedCampaigns()">
                                        <i class="fas fa-trash me-1"></i>Delete Selected
                                    </button>
                                    <button class="btn btn-primary" data-bs-toggle="collapse" data-bs-target="#campaignForm" onclick="resetCampaignForm()">
                                        <i class="fas fa-plus me-1"></i>Add Campaign
                                    </button>
                                </div>
                            </div>

                            <div id="campaignForm" class="collapse mb-4">
                                <div class="card">
                                    <div class="card-header">
                                        <h6 id="campaignFormTitle"><i class="fas fa-plus me-2"></i>Add New Campaign</h6>
                                    </div>
                                    <div class="card-body">
                                        <form class="row g-3" method="post" action="CampaignController" id="campaignFormElement">
                                            <input type="hidden" name="action" value="create" id="campaignAction">
                                            <input type="hidden" name="campaignId" id="campaignId">
                                            <div class="col-md-6"><input class="form-control" name="subject" id="campaignSubject" placeholder="Email Subject" required></div>
                                            <div class="col-md-6">
                                                <select class="form-select" name="segment" id="campaignSegment" required>
                                                    <option value="">Select Segment</option>
                                                    <option value="all">All Customers</option>
                                                    <option value="active_customers">Active Customers</option>
                                                    <option value="new_customers">New Customers</option>
                                                </select>
                                            </div>
                                            <div class="col-12"><textarea class="form-control" name="body" id="campaignBody" rows="4" placeholder="Email Body" required></textarea></div>
                                            <div class="col-12"><input class="form-control" name="offer" id="campaignOffer" placeholder="Special Offer (optional)"></div>
                                            <div class="col-12 d-grid"><button class="btn btn-success" type="submit" id="campaignSubmitBtn">Create Campaign</button></div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead class="table-dark">
                                        <tr>
                                            <th><input type="checkbox" id="selectAllCampaigns" onclick="toggleAllCampaigns()"></th>
                                            <th>ID</th><th>Subject</th><th>Segment</th><th>Status</th><th>Created</th><th>Sent</th><th>Count</th><th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="c" items="${campaigns}">
                                            <tr>
                                                <td><input type="checkbox" class="campaign-checkbox" value="${c.campaignId}"></td>
                                                <td>${c.campaignId}</td>
                                                <td>${c.subject}</td>
                                                <td><span class="badge bg-info">${c.segment}</span></td>
                                                <td><span class="badge bg-secondary">${c.status}</span></td>
                                                <td>${c.createdDate}</td>
                                                <td>${c.sentDate != null ? c.sentDate : 'Not sent'}</td>
                                                <td>${c.sentCount}</td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary action-btn me-1" onclick="editCampaign('${c.campaignId}')">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-success action-btn me-1" onclick="sendCampaign('${c.campaignId}')">
                                                        <i class="fas fa-paper-plane"></i>
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-danger action-btn" onclick="deleteCampaign('${c.campaignId}')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Role Update Modal -->
                            <div class="modal fade" id="roleUpdateModal" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Update User Role & Permissions</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <form id="roleUpdateForm" method="post" action="UserManagementServlet">
                                            <input type="hidden" name="action" value="updateRole">
                                            <input type="hidden" name="userId" id="modalUserId">
                                            <div class="modal-body">
                                                <div class="mb-3">
                                                    <label class="form-label">Role</label>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="role" id="roleCustomer" value="customer" checked>
                                                        <label class="form-check-label" for="roleCustomer">Customer</label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="role" id="roleAdmin" value="admin">
                                                        <label class="form-check-label" for="roleAdmin">Admin</label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="role" id="roleOther" value="other">
                                                        <label class="form-check-label" for="roleOther">Other</label>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Permissions</label>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" name="permissions" value="view" id="permView">
                                                        <label class="form-check-label" for="permView">View</label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" name="permissions" value="edit" id="permEdit">
                                                        <label class="form-check-label" for="permEdit">Edit</label>
                                                    </div>
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="checkbox" name="permissions" value="delete" id="permDelete">
                                                        <label class="form-check-label" for="permDelete">Delete</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                <button type="submit" class="btn btn-primary">Review Changes</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <!-- Review Changes Modal -->
                            <c:if test="${not empty sessionScope.pendingUserId}">
                                <div class="modal fade show" id="reviewModal" tabindex="-1" style="display: block;">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Review Changes</h5>
                                                <button type="button" class="btn-close" onclick="discardChanges()"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p><strong>User ID:</strong> ${sessionScope.pendingUserId}</p>
                                                <p><strong>New Role:</strong> ${sessionScope.pendingRole}</p>
                                                <p><strong>Permissions:</strong> ${sessionScope.pendingPermissions}</p>
                                            </div>
                                            <div class="modal-footer">
                                                <form method="post" action="UserManagementServlet" style="display: inline;">
                                                    <input type="hidden" name="action" value="discardChanges">
                                                    <button type="submit" class="btn btn-secondary">Discard Changes</button>
                                                </form>
                                                <form method="post" action="UserManagementServlet" style="display: inline;">
                                                    <input type="hidden" name="action" value="saveChanges">
                                                    <button type="submit" class="btn btn-success">Save Changes</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Hidden Forms for Delete Operations -->
    <form id="deleteVehicleForm" method="post" action="VehicleController" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="ids" id="deleteVehicleIds">
    </form>

    <form id="deleteBookingForm" method="post" action="BookingController" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="ids" id="deleteBookingIds">
    </form>

    <form id="deletePaymentForm" method="post" action="PaymentController" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="ids" id="deletePaymentIds">
    </form>

    <form id="deleteUserForm" method="post" action="UserController" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="ids" id="deleteUserIds">
    </form>

    <form id="deletePromotionForm" method="post" action="PromotionController" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="ids" id="deletePromotionIds">
    </form>

    <form id="deleteCampaignForm" method="post" action="CampaignController" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="campaignId" id="deleteCampaignId">
    </form>

    <form id="deleteFeedbackForm" method="post" action="FeedbackController" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="ids" id="deleteFeedbackIds">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Select All Functions
        function toggleAllVehicles() {
            const selectAll = document.getElementById('selectAllVehicles');
            const checkboxes = document.querySelectorAll('.vehicle-checkbox');
            checkboxes.forEach(cb => cb.checked = selectAll.checked);
        }

        function toggleAllBookings() {
            const selectAll = document.getElementById('selectAllBookings');
            const checkboxes = document.querySelectorAll('.booking-checkbox');
            checkboxes.forEach(cb => cb.checked = selectAll.checked);
        }

        function toggleAllPayments() {
            const selectAll = document.getElementById('selectAllPayments');
            const checkboxes = document.querySelectorAll('.payment-checkbox');
            checkboxes.forEach(cb => cb.checked = selectAll.checked);
        }

        function toggleAllUsers() {
            const selectAll = document.getElementById('selectAllUsers');
            const checkboxes = document.querySelectorAll('.user-checkbox');
            checkboxes.forEach(cb => cb.checked = selectAll.checked);
        }

        function toggleAllPromotions() {
            const selectAll = document.getElementById('selectAllPromotions');
            const checkboxes = document.querySelectorAll('.promotion-checkbox');
            checkboxes.forEach(cb => cb.checked = selectAll.checked);
        }

        function toggleAllCampaigns() {
            const selectAll = document.getElementById('selectAllCampaigns');
            const checkboxes = document.querySelectorAll('.campaign-checkbox');
            checkboxes.forEach(cb => cb.checked = selectAll.checked);
        }

        function toggleAllFeedback() {
            const selectAll = document.getElementById('selectAllFeedback');
            const checkboxes = document.querySelectorAll('.feedback-checkbox');
            checkboxes.forEach(cb => cb.checked = selectAll.checked);
        }

        // Delete Selected Functions
        function deleteSelectedVehicles() {
            const selected = document.querySelectorAll('.vehicle-checkbox:checked');
            if (selected.length === 0) {
                alert('Please select vehicles to delete.');
                return;
            }
            const ids = Array.from(selected).map(cb => cb.value);
            if (confirm('Delete ' + ids.length + ' selected vehicles?')) {
                document.getElementById('deleteVehicleIds').value = ids.join(',');
                document.getElementById('deleteVehicleForm').submit();
            }
        }

        function deleteSelectedBookings() {
            const selected = document.querySelectorAll('.booking-checkbox:checked');
            if (selected.length === 0) {
                alert('Please select bookings to delete.');
                return;
            }
            const ids = Array.from(selected).map(cb => cb.value);
            if (confirm('Delete ' + ids.length + ' selected bookings?')) {
                document.getElementById('deleteBookingIds').value = ids.join(',');
                document.getElementById('deleteBookingForm').submit();
            }
        }

        function deleteSelectedPayments() {
            const selected = document.querySelectorAll('.payment-checkbox:checked');
            if (selected.length === 0) {
                alert('Please select payments to delete.');
                return;
            }
            const ids = Array.from(selected).map(cb => cb.value);
            if (confirm('Delete ' + ids.length + ' selected payments?')) {
                document.getElementById('deletePaymentIds').value = ids.join(',');
                document.getElementById('deletePaymentForm').submit();
            }
        }

        function deleteSelectedUsers() {
            const selected = document.querySelectorAll('.user-checkbox:checked');
            if (selected.length === 0) {
                alert('Please select users to delete.');
                return;
            }
            const ids = Array.from(selected).map(cb => cb.value);
            if (confirm('Delete ' + ids.length + ' selected users?')) {
                document.getElementById('deleteUserIds').value = ids.join(',');
                document.getElementById('deleteUserForm').submit();
            }
        }

        function deleteSelectedPromotions() {
            const selected = document.querySelectorAll('.promotion-checkbox:checked');
            if (selected.length === 0) {
                alert('Please select promotions to delete.');
                return;
            }
            const ids = Array.from(selected).map(cb => cb.value);
            if (confirm('Delete ' + ids.length + ' selected promotions?')) {
                document.getElementById('deletePromotionIds').value = ids.join(',');
                document.getElementById('deletePromotionForm').submit();
            }
        }

        function deleteSelectedCampaigns() {
            const selected = document.querySelectorAll('.campaign-checkbox:checked');
            if (selected.length === 0) {
                alert('Please select campaigns to delete.');
                return;
            }
            const ids = Array.from(selected).map(cb => cb.value);
            if (confirm('Delete ' + ids.length + ' selected campaigns? This action cannot be undone.')) {
                // For campaigns, we need to delete one by one since the controller expects single campaignId
                ids.forEach(id => {
                    document.getElementById('deleteCampaignId').value = id;
                    document.getElementById('deleteCampaignForm').submit();
                });
            }
        }

        function deleteSelectedFeedback() {
            const selected = document.querySelectorAll('.feedback-checkbox:checked');
            if (selected.length === 0) {
                alert('Please select feedback to delete.');
                return;
            }
            const ids = Array.from(selected).map(cb => cb.value);
            if (confirm('Delete ' + ids.length + ' selected feedback entries?')) {
                document.getElementById('deleteFeedbackIds').value = ids.join(',');
                document.getElementById('deleteFeedbackForm').submit();
            }
        }

        // Individual CRUD Operations
         function editVehicle(id) {
             // Fetch vehicle data and populate form
             fetch('VehicleController?action=get&id=' + id)
                 .then(response => response.json())
                 .then(data => {
                     document.getElementById('vehicleAction').value = 'update';
                     document.getElementById('vehicleId').value = data.vehicleId;
                     document.getElementById('vehicleId').readOnly = true; // ID shouldn't be editable
                     document.getElementById('vehicleName').value = data.vehicleName;
                     document.getElementById('vehicleType').value = data.vehicleType;
                     document.getElementById('vehiclePrice').value = data.dailyPrice;
                     document.getElementById('vehicleAvailable').value = data.available.toString();
                     // For image, show current URL but don't populate file input
                     document.getElementById('vehicleImageUrl').value = data.imageUrl || '';
                     document.getElementById('vehicleImageFile').value = ''; // Clear file input
                     document.getElementById('vehicleFormTitle').innerHTML = '<i class="fas fa-edit me-2"></i>Edit Vehicle';
                     document.getElementById('vehicleSubmitBtn').textContent = 'Update';
                     // Show the form
                     const form = document.getElementById('vehicleForm');
                     if (!form.classList.contains('show')) {
                         new bootstrap.Collapse(form).show();
                     }
                 })
                 .catch(error => {
                     alert('Error loading vehicle data: ' + error);
                 });
         }

         function resetVehicleForm() {
             document.getElementById('vehicleAction').value = 'add';
             document.getElementById('vehicleId').readOnly = false;
             document.getElementById('vehicleId').value = '';
             document.getElementById('vehicleName').value = '';
             document.getElementById('vehicleType').value = '';
             document.getElementById('vehiclePrice').value = '';
             document.getElementById('vehicleAvailable').value = 'true';
             document.getElementById('vehicleImageFile').value = '';
             document.getElementById('vehicleImageUrl').value = '';
             document.getElementById('vehicleFormTitle').innerHTML = '<i class="fas fa-plus me-2"></i>Add New Vehicle';
             document.getElementById('vehicleSubmitBtn').textContent = 'Save';
         }

         function deleteVehicle(id) {
             if (confirm('Delete vehicle ' + id + '?')) {
                 const form = document.createElement('form');
                 form.method = 'post';
                 form.action = 'VehicleController';
                 form.style.display = 'none';

                 const actionInput = document.createElement('input');
                 actionInput.type = 'hidden';
                 actionInput.name = 'action';
                 actionInput.value = 'delete';

                 const idInput = document.createElement('input');
                 idInput.type = 'hidden';
                 idInput.name = 'vehicleId';
                 idInput.value = id;

                 form.appendChild(actionInput);
                 form.appendChild(idInput);
                 document.body.appendChild(form);
                 form.submit();
             }
         }

        function editBooking(id) {
             // Fetch booking data and populate form
             fetch('BookingController?action=get&id=' + id)
                 .then(response => response.json())
                 .then(data => {
                     document.getElementById('bookingAction').value = 'update';
                     document.getElementById('bookingId').value = data.bookingId;
                     document.getElementById('bookingUserId').value = data.userId;
                     document.getElementById('bookingVehicleId').value = data.vehicleId;
                     document.getElementById('bookingStartDate').value = data.startDate;
                     document.getElementById('bookingEndDate').value = data.endDate;
                     document.getElementById('bookingStatus').value = data.status;
                     document.getElementById('bookingFormTitle').innerHTML = '<i class="fas fa-edit me-2"></i>Edit Booking';
                     document.getElementById('bookingSubmitBtn').textContent = 'Update';
                     // Show the form
                     const form = document.getElementById('bookingForm');
                     if (!form.classList.contains('show')) {
                         new bootstrap.Collapse(form).show();
                     }
                 })
                 .catch(error => {
                     alert('Error loading booking data: ' + error);
                 });
         }

         function resetBookingForm() {
             document.getElementById('bookingAction').value = 'create';
             document.getElementById('bookingId').value = '';
             document.getElementById('bookingUserId').value = '';
             document.getElementById('bookingVehicleId').value = '';
             document.getElementById('bookingStartDate').value = '';
             document.getElementById('bookingEndDate').value = '';
             document.getElementById('bookingStatus').value = 'Pending';
             document.getElementById('bookingFormTitle').innerHTML = '<i class="fas fa-plus me-2"></i>Add New Booking';
             document.getElementById('bookingSubmitBtn').textContent = 'Create';
         }

         function deleteBooking(id) {
             if (confirm('Delete booking ' + id + '? This will also delete related payments and feedback.')) {
                 const form = document.createElement('form');
                 form.method = 'post';
                 form.action = 'BookingController';
                 form.style.display = 'none';

                 const actionInput = document.createElement('input');
                 actionInput.type = 'hidden';
                 actionInput.name = 'action';
                 actionInput.value = 'delete';

                 const idInput = document.createElement('input');
                 idInput.type = 'hidden';
                 idInput.name = 'bookingId';
                 idInput.value = id;

                 form.appendChild(actionInput);
                 form.appendChild(idInput);
                 document.body.appendChild(form);
                 form.submit();
             }
         }

        function editPayment(id) {
            // Fetch payment data and populate form
            fetch('PaymentController?action=get&id=' + id)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('paymentAction').value = 'update';
                    document.getElementById('paymentId').value = data.paymentId;
                    document.getElementById('paymentBookingId').value = data.bookingId;
                    document.getElementById('paymentAmount').value = data.amount;
                    document.getElementById('paymentMethod').value = data.paymentMethod;
                    document.getElementById('paymentFormTitle').innerHTML = '<i class="fas fa-edit me-2"></i>Edit Payment';
                    document.getElementById('paymentSubmitBtn').textContent = 'Update';
                    // Show the form
                    const form = document.getElementById('paymentForm');
                    if (!form.classList.contains('show')) {
                        new bootstrap.Collapse(form).show();
                    }
                })
                .catch(error => {
                    alert('Error loading payment data: ' + error);
                });
        }

        function resetPaymentForm() {
            document.getElementById('paymentAction').value = 'create';
            document.getElementById('paymentId').value = '';
            document.getElementById('paymentBookingId').value = '';
            document.getElementById('paymentAmount').value = '';
            document.getElementById('paymentMethod').value = '';
            document.getElementById('paymentFormTitle').innerHTML = '<i class="fas fa-plus me-2"></i>Add New Payment';
            document.getElementById('paymentSubmitBtn').textContent = 'Create';
        }

        function deletePayment(id) {
            if (confirm('Delete payment ' + id + '?')) {
                const form = document.createElement('form');
                form.method = 'post';
                form.action = 'PaymentController';
                form.style.display = 'none';

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';

                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'paymentId';
                idInput.value = id;

                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function updateRole(id, currentRole) {
            document.getElementById('modalUserId').value = id;
            // Set current role
            if (currentRole === 'admin') {
                document.getElementById('roleAdmin').checked = true;
            } else if (currentRole === 'other') {
                document.getElementById('roleOther').checked = true;
            } else {
                document.getElementById('roleCustomer').checked = true;
            }
            // Show modal
            new bootstrap.Modal(document.getElementById('roleUpdateModal')).show();
        }

        function editUser(id) {
            // Fetch user data and populate form
            fetch('UserController?action=get&id=' + id)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('userAction').value = 'update';
                    document.getElementById('userId').value = data.userId;
                    document.getElementById('userFullName').value = data.fullName;
                    document.getElementById('userUsername').value = data.username;
                    document.getElementById('userEmail').value = data.email;
                    document.getElementById('userPassword').value = data.password; // Note: In real app, password shouldn't be shown
                    document.getElementById('userFormTitle').innerHTML = '<i class="fas fa-edit me-2"></i>Edit User';
                    document.getElementById('userSubmitBtn').textContent = 'Update User';
                    // Show the form
                    const form = document.getElementById('userForm');
                    if (!form.classList.contains('show')) {
                        new bootstrap.Collapse(form).show();
                    }
                })
                .catch(error => {
                    alert('Error loading user data: ' + error);
                });
        }

        function resetUserForm() {
            document.getElementById('userAction').value = 'create';
            document.getElementById('userId').value = '';
            document.getElementById('userFullName').value = '';
            document.getElementById('userUsername').value = '';
            document.getElementById('userEmail').value = '';
            document.getElementById('userPassword').value = '';
            document.getElementById('userFormTitle').innerHTML = '<i class="fas fa-plus me-2"></i>Add New User';
            document.getElementById('userSubmitBtn').textContent = 'Create User';
        }

        function deleteUser(id) {
            if (confirm('Delete user ' + id + '?')) {
                const form = document.createElement('form');
                form.method = 'post';
                form.action = 'UserController';
                form.style.display = 'none';

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';

                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'userId';
                idInput.value = id;

                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function discardChanges() {
            // Redirect to discard
            window.location.href = 'UserManagementServlet?action=discardChanges';
        }

        function editPromotion(id) {
            // Fetch promotion data and populate form
            fetch('PromotionController?action=get&id=' + id)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('promoAction').value = 'update';
                    document.getElementById('promoId').value = data.id;
                    document.getElementById('promoTitle').value = data.title;
                    document.getElementById('promoDescription').value = data.description;
                    document.getElementById('promoBadge').value = data.badge;
                    document.getElementById('promoValidTill').value = data.validTill;
                    document.getElementById('promoFormTitle').innerHTML = '<i class="fas fa-edit me-2"></i>Edit Promotion';
                    document.getElementById('promoSubmitBtn').textContent = 'Update Promotion';
                    // Show the form
                    const form = document.getElementById('promoForm');
                    if (!form.classList.contains('show')) {
                        new bootstrap.Collapse(form).show();
                    }
                })
                .catch(error => {
                    alert('Error loading promotion data: ' + error);
                });
        }

        function resetPromoForm() {
            document.getElementById('promoAction').value = 'add';
            document.getElementById('promoId').value = '';
            document.getElementById('promoTitle').value = '';
            document.getElementById('promoDescription').value = '';
            document.getElementById('promoBadge').value = '';
            document.getElementById('promoValidTill').value = '';
            document.getElementById('promoFormTitle').innerHTML = '<i class="fas fa-plus me-2"></i>Add New Promotion';
            document.getElementById('promoSubmitBtn').textContent = 'Create Promotion';
        }

        function togglePromotion(id) {
            if (confirm('Toggle active status of promotion ' + id + '?')) {
                // This would need a separate endpoint, for now just alert
                alert('Toggle functionality not implemented yet');
            }
        }

        function deletePromotion(id) {
            if (confirm('Delete promotion ' + id + '?')) {
                const form = document.createElement('form');
                form.method = 'post';
                form.action = 'PromotionController';
                form.style.display = 'none';

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';

                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = id;

                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function editCampaign(id) {
            // Fetch campaign data and populate form
            fetch('CampaignController?action=get&id=' + id)
                .then(response => response.json())
                .then(data => {
                    document.getElementById('campaignAction').value = 'update';
                    document.getElementById('campaignId').value = data.campaignId;
                    document.getElementById('campaignSubject').value = data.subject;
                    document.getElementById('campaignSegment').value = data.segment;
                    document.getElementById('campaignBody').value = data.body;
                    document.getElementById('campaignOffer').value = data.offer || '';
                    document.getElementById('campaignFormTitle').innerHTML = '<i class="fas fa-edit me-2"></i>Edit Campaign';
                    document.getElementById('campaignSubmitBtn').textContent = 'Update Campaign';
                    // Show the form
                    const form = document.getElementById('campaignForm');
                    if (!form.classList.contains('show')) {
                        new bootstrap.Collapse(form).show();
                    }
                })
                .catch(error => {
                    alert('Error loading campaign data: ' + error);
                });
        }

        function resetCampaignForm() {
            document.getElementById('campaignAction').value = 'create';
            document.getElementById('campaignId').value = '';
            document.getElementById('campaignSubject').value = '';
            document.getElementById('campaignSegment').value = '';
            document.getElementById('campaignBody').value = '';
            document.getElementById('campaignOffer').value = '';
            document.getElementById('campaignFormTitle').innerHTML = '<i class="fas fa-plus me-2"></i>Add New Campaign';
            document.getElementById('campaignSubmitBtn').textContent = 'Create Campaign';
        }

        function sendCampaign(id) {
            if (confirm('Send campaign ' + id + ' to all recipients? This will send emails to all customers in the selected segment.')) {
                // Show loading message
                const button = event.target.closest('button');
                const originalText = button.innerHTML;
                button.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Sending...';
                button.disabled = true;

                // Create a form to send the campaign
                const form = document.createElement('form');
                form.method = 'post';
                form.action = 'CampaignController';
                form.style.display = 'none';

                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'send';

                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'campaignId';
                idInput.value = id;

                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
        function deleteCampaign(id) {
            if (confirm('Delete campaign ' + id + '? This action cannot be undone.')) {
                document.getElementById('deleteCampaignId').value = id;
                document.getElementById('deleteCampaignForm').submit();
            }
        }

        // Auto-activate campaigns tab if there are campaign-related messages
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const success = urlParams.get('success');
            const error = urlParams.get('error');

            if ((success && (success.includes('Campaign') || success.includes('campaign'))) ||
                (error && (error.includes('Campaign') || error.includes('campaign')))) {
                const campaignsTab = document.getElementById('campaigns-tab');
                if (campaignsTab) {
                    campaignsTab.click();
                }
            }
        });
    </script>
</body>
</html>