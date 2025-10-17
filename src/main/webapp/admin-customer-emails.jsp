<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Emails - Admin - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
        .btn-primary { background: linear-gradient(135deg, var(--accent-color), var(--accent-light)); border: none; transition: all 0.3s ease; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3); }
        .table { border-radius: 12px; overflow: hidden; }
        .form-control, .form-select { border-radius: 8px; border: 2px solid var(--border-color); transition: border-color 0.3s ease; }
        .form-control:focus, .form-select:focus { border-color: var(--accent-color); box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25); }
        h2 { color: var(--text-dark); font-weight: 700; }
        .badge { border-radius: 20px; }
        .section-header { background: var(--bg-white); padding: 1.5rem; border-radius: 12px; margin-bottom: 1.5rem; box-shadow: var(--shadow); }
        .section-header h3 { color: var(--text-dark); font-weight: 600; margin: 0; }
        .stat-icon { width: 60px; height: 60px; background: linear-gradient(135deg, var(--accent-color), var(--accent-light)); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.5rem; margin-bottom: 1rem; }

        /* Search and Filter */
        .search-container { background: var(--bg-white); border: 2px solid var(--border-color); border-radius: 1rem; padding: 1.5rem; margin-bottom: 2rem; box-shadow: var(--shadow); transition: all 0.3s ease; }
        .search-container:hover { border-color: var(--accent-color); box-shadow: 0 8px 25px rgba(59, 130, 246, 0.1); }

        /* Header Enhancements */
        .text-gradient { background: linear-gradient(135deg, var(--accent-color), var(--accent-light)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
        .header-content { flex: 1; min-width: 300px; }
        .stats-bar { opacity: 0.8; }
        .stat-item { display: flex; align-items: center; font-size: 0.9rem; }
        .stat-number { font-size: 1.5rem; }
        .stat-label { font-size: 0.85rem; }
        .btn-lg { padding: 0.75rem 1.5rem; font-size: 1rem; font-weight: 600; }

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
        <h5 class="text-dark fw-bold mb-4">CarRent Admin</h5>
        <nav class="nav flex-column">
            <a class="nav-link" href="AdminServlet">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a class="nav-link active" href="CampaignController">
                <i class="fas fa-envelope"></i> Campaigns
            </a>
            <a class="nav-link" href="admin-promotion-create.jsp">
                <i class="fas fa-tags"></i> Promotions
            </a>
            <hr class="my-3">
            <a class="nav-link" href="HomeServlet">
                <i class="fas fa-external-link-alt"></i> View Site
            </a>
            <a class="nav-link" href="AuthController?action=logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </nav>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Top Navbar -->
    <nav class="navbar">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1">Customer Emails</span>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="section-header">
        <div class="d-flex justify-content-between align-items-center flex-wrap">
            <div>
                <h2>Customer Email Directory</h2>
                <p class="text-muted mb-0">View and manage customer email addresses for campaigns</p>
            </div>
            <div>
                <a href="CampaignController?action=list" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Campaigns
                </a>
            </div>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="row mb-4">
        <div class="col-md-6 mb-3">
            <div class="stat-card p-4">
                <div class="d-flex align-items-center">
                    <div class="stat-icon me-3">
                        <i class="fas fa-users"></i>
                    </div>
                    <div>
                        <h4 class="mb-1">${customers.size()}</h4>
                        <p class="text-muted mb-0">Total Customers</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <div class="stat-card p-4">
                <div class="d-flex align-items-center">
                    <div class="stat-icon me-3">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div>
                        <h4 class="mb-1">
                            <c:set var="activeCount" value="0"/>
                            <c:forEach var="customer" items="${customers}">
                                <c:if test="${customer.hasActiveBookings}">
                                    <c:set var="activeCount" value="${activeCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${activeCount}
                        </h4>
                        <p class="text-muted mb-0">Active Customers</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Search and Filter -->
    <div class="search-container">
        <div class="row g-3">
            <div class="col-md-4">
                <input type="text" class="form-control" id="searchInput" placeholder="Search by name, email, or username...">
            </div>
            <div class="col-md-3">
                <select class="form-control" id="statusFilter">
                    <option value="">All Customers</option>
                    <option value="active">Active Customers (Have Bookings)</option>
                    <option value="inactive">Inactive Customers</option>
                </select>
            </div>
            <div class="col-md-2">
                <button class="btn btn-primary w-100" onclick="exportEmails()">
                    <i class="fas fa-download me-1"></i>Export
                </button>
            </div>
            <div class="col-md-3">
                <div class="alert alert-info mb-0 py-2">
                    <small><i class="fas fa-info-circle me-1"></i>Total: <span id="totalCount">${customers.size()}</span> customers</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Customer Emails Table -->
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover" id="customersTable">
                    <thead>
                        <tr>
                            <th><i class="fas fa-user me-1"></i>Name</th>
                            <th><i class="fas fa-envelope me-1"></i>Email</th>
                            <th><i class="fas fa-phone me-1"></i>Phone</th>
                            <th><i class="fas fa-at me-1"></i>Username</th>
                            <th><i class="fas fa-chart-line me-1"></i>Status</th>
                            <th><i class="fas fa-cogs me-1"></i>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="customer" items="${customers}">
                            <tr class="customer-row" data-name="${customer.fullName}" data-email="${customer.email}" data-username="${customer.username}" data-active="${customer.hasActiveBookings}">
                                <td>
                                    <strong>${customer.fullName}</strong>
                                </td>
                                <td>
                                    <span class="email-text">${customer.email}</span>
                                    <button class="btn btn-sm btn-outline-secondary ms-2" onclick="copyToClipboard('${customer.email}')" title="Copy email">
                                        <i class="fas fa-copy"></i>
                                    </button>
                                </td>
                                <td>${customer.phone}</td>
                                <td>${customer.username}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${customer.hasActiveBookings}">
                                            <span class="badge bg-success">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" onclick="sendTestEmail('${customer.email}')" title="Send test email">
                                        <i class="fas fa-paper-plane"></i> Test
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty customers}">
                            <tr>
                                <td colspan="6" class="text-center py-4">
                                    <div class="text-muted">
                                        <i class="fas fa-users fa-3x mb-3"></i>
                                        <h5>No customers found</h5>
                                        <p>Customer data will appear here once users register.</p>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Theme Management
    function initTheme() {
        const savedTheme = localStorage.getItem('theme') || 'light';
        const html = document.documentElement;
        const themeIcon = document.getElementById('themeIcon');

        if (savedTheme === 'dark') {
            html.setAttribute('data-theme', 'dark');
            themeIcon.className = 'fas fa-sun';
        } else {
            html.removeAttribute('data-theme');
            themeIcon.className = 'fas fa-moon';
        }
    }

    function toggleTheme() {
        const html = document.documentElement;
        const themeIcon = document.getElementById('themeIcon');
        const currentTheme = html.getAttribute('data-theme');

        if (currentTheme === 'dark') {
            html.removeAttribute('data-theme');
            localStorage.setItem('theme', 'light');
            themeIcon.className = 'fas fa-moon';
        } else {
            html.setAttribute('data-theme', 'dark');
            localStorage.setItem('theme', 'dark');
            themeIcon.className = 'fas fa-sun';
        }
    }

    // Search and Filter Functionality
    function filterCustomers() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const statusFilter = document.getElementById('statusFilter').value;
        const rows = document.querySelectorAll('.customer-row');
        let visibleCount = 0;

        rows.forEach(row => {
            const name = row.dataset.name.toLowerCase();
            const email = row.dataset.email.toLowerCase();
            const username = row.dataset.username.toLowerCase();
            const isActive = row.dataset.active === 'true';

            let showRow = true;

            // Search filter
            if (searchTerm) {
                showRow = showRow && (name.includes(searchTerm) || email.includes(searchTerm) || username.includes(searchTerm));
            }

            // Status filter
            if (statusFilter === 'active') {
                showRow = showRow && isActive;
            } else if (statusFilter === 'inactive') {
                showRow = showRow && !isActive;
            }

            row.style.display = showRow ? '' : 'none';
            if (showRow) visibleCount++;
        });

        document.getElementById('totalCount').textContent = visibleCount;
    }

    // Copy email to clipboard
    function copyToClipboard(email) {
        navigator.clipboard.writeText(email).then(() => {
            // Simple feedback
            const btn = event.target.closest('button');
            const originalIcon = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-check"></i>';
            btn.classList.remove('btn-outline-secondary');
            btn.classList.add('btn-success');

            setTimeout(() => {
                btn.innerHTML = originalIcon;
                btn.classList.remove('btn-success');
                btn.classList.add('btn-outline-secondary');
            }, 1000);
        });
    }

    // Send test email (placeholder)
    function sendTestEmail(email) {
        alert('Test email functionality would send a test message to: ' + email);
        // In a real implementation, this would make an AJAX call to send a test email
    }

    // Export emails
    function exportEmails() {
        const visibleRows = document.querySelectorAll('.customer-row[style=""], .customer-row:not([style*="none"])');
        let csvContent = 'Name,Email,Phone,Username,Status\n';

        visibleRows.forEach(row => {
            const cells = row.querySelectorAll('td');
            const name = cells[0].textContent.trim();
            const email = cells[1].querySelector('.email-text').textContent.trim();
            const phone = cells[2].textContent.trim();
            const username = cells[3].textContent.trim();
            const status = cells[4].textContent.trim();

            csvContent += `"${name}","${email}","${phone}","${username}","${status}"\n`;
        });

        const blob = new Blob([csvContent], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'customer-emails.csv';
        a.click();
        window.URL.revokeObjectURL(url);
    }

    // Initialize theme on page load
    document.addEventListener('DOMContentLoaded', function() {
        initTheme();

        // Add search and filter listeners
        document.getElementById('searchInput').addEventListener('input', filterCustomers);
        document.getElementById('statusFilter').addEventListener('change', filterCustomers);
    });

    // Theme toggle event listener
    document.getElementById('themeToggle').addEventListener('click', toggleTheme);
</script>
</body>
</html>