<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Board - Staff Management</title>
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
        .card { border-radius: 16px; box-shadow: var(--shadow); border: none; }
        .table { border-radius: 12px; overflow: hidden; }
        .section-header { background: var(--bg-white); padding: 1.5rem; border-radius: 12px; margin-bottom: 1.5rem; box-shadow: var(--shadow); }
        .section-header h3 { color: var(--text-dark); font-weight: 600; margin: 0; }
        .badge { border-radius: 20px; }
        @media (max-width: 768px) {
            .sidebar { width: 100%; position: relative; min-height: auto; }
            .main-content { margin-left: 0; }
            .navbar { display: none; }
            .section-header { padding: 1rem; }
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
                <a class="nav-link" href="AdminServlet"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                <a class="nav-link active" href="AdminBoardController"><i class="fas fa-users"></i>Staff Board</a>
                <a class="nav-link" href="admin-crud.jsp"><i class="fas fa-database"></i>CRUD Management</a>
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
                <h4 class="mb-0">Staff Management Board</h4>
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
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body p-5">
                                <div class="text-center mb-4">
                                    <div class="stat-icon mx-auto" style="width: 60px; height: 60px; background: linear-gradient(135deg, var(--accent-color), var(--accent-light)); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.5rem; margin-bottom: 1rem;">
                                        <i class="fas fa-user-shield"></i>
                                    </div>
                                    <h3>Admin Access Required</h3>
                                    <p class="text-muted">Please login to access the staff management board.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Staff Management -->
                <div class="section-header">
                    <h3><i class="fas fa-users me-2"></i>Staff with Marketing, Executive, and Account Roles</h3>
                </div>

                <div class="card">
                    <div class="card-body">
                        <c:if test="${empty staffList}">
                            <div class="alert alert-info mb-0">
                                <i class="fas fa-info-circle me-2"></i>No staff found with the specified roles.
                            </div>
                        </c:if>
                        <c:if test="${not empty staffList}">
                            <div class="table-responsive">
                                <table class="table table-striped align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="fas fa-hashtag me-1"></i>ID</th>
                                            <th><i class="fas fa-user me-1"></i>Full Name</th>
                                            <th><i class="fas fa-envelope me-1"></i>Email</th>
                                            <th><i class="fas fa-phone me-1"></i>Phone</th>
                                            <th><i class="fas fa-at me-1"></i>Username</th>
                                            <th><i class="fas fa-briefcase me-1"></i>Position</th>
                                            <th><i class="fas fa-building me-1"></i>Department</th>
                                            <th><i class="fas fa-toggle-on me-1"></i>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="staff" items="${staffList}">
                                            <tr>
                                                <td>${staff.staffId}</td>
                                                <td>${staff.fullName}</td>
                                                <td>${staff.email}</td>
                                                <td>${staff.phone}</td>
                                                <td>${staff.username}</td>
                                                <td>${staff.position}</td>
                                                <td>${staff.department}</td>
                                                <td>
                                                    <span class="badge ${staff.active ? 'bg-success' : 'bg-secondary'}">${staff.active ? 'Active' : 'Inactive'}</span>
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
</body>
</html>