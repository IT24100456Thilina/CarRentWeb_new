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
        :root {
            --primary-color: #2563eb;
            --primary-dark: #1d4ed8;
            --secondary-color: #64748b;
            --accent-color: #f59e0b;
            --success-color: #10b981;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
            --info-color: #06b6d4;
            --light-bg: #f8fafc;
            --dark-bg: #0f172a;
            --light-card: #ffffff;
            --dark-card: #1e293b;
            --light-text: #1e293b;
            --dark-text: #f1f5f9;
            --light-border: #e2e8f0;
            --dark-border: #334155;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        [data-theme="dark"] {
            --light-bg: #0f172a;
            --dark-bg: #f8fafc;
            --light-card: #1e293b;
            --dark-card: #ffffff;
            --light-text: #f1f5f9;
            --dark-text: #1e293b;
            --light-border: #334155;
            --dark-border: #e2e8f0;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            font-size: 14px;
            line-height: 1.5;
            color: var(--light-text);
            background-color: var(--light-bg);
            margin: 0;
            padding: 0;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        [data-theme="dark"] body {
            color: var(--dark-text);
            background-color: var(--dark-bg);
        }

        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-dark) 100%);
            box-shadow: var(--shadow);
            padding: 0.75rem 0;
            transition: all 0.3s ease;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.25rem;
            color: white !important;
        }

        .nav-link {
            font-weight: 500;
            font-size: 0.875rem;
            color: rgba(255, 255, 255, 0.9) !important;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: white !important;
        }

        .card, .table {
            background: var(--light-card);
            border: 1px solid var(--light-border);
            border-radius: 0.75rem;
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        [data-theme="dark"] .card, [data-theme="dark"] .table {
            background: var(--dark-card);
            border-color: var(--dark-border);
        }

        .card-body {
            padding: 1.25rem;
        }

        .card-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--light-text);
            margin-bottom: 0.5rem;
        }

        [data-theme="dark"] .card-title {
            color: var(--dark-text);
        }

        .btn {
            font-size: 0.875rem;
            font-weight: 500;
            padding: 0.625rem 1.25rem;
            border-radius: 0.5rem;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.4);
        }

        .badge {
            font-size: 0.75rem;
            font-weight: 600;
            padding: 0.25rem 0.625rem;
            border-radius: 0.375rem;
        }

        .badge-active { background: linear-gradient(135deg, var(--success-color), #059669); color: white; }
        .badge-inactive { background: linear-gradient(135deg, var(--secondary-color), #475569); color: white; }

        .table {
            margin-bottom: 0;
        }

        .table th {
            background: var(--light-bg);
            border-bottom: 2px solid var(--light-border);
            font-weight: 600;
            color: var(--light-text);
            padding: 1rem 0.75rem;
        }

        [data-theme="dark"] .table th {
            background: var(--dark-bg);
            border-bottom-color: var(--dark-border);
            color: var(--dark-text);
        }

        .table td {
            padding: 1rem 0.75rem;
            border-bottom: 1px solid var(--light-border);
            vertical-align: middle;
        }

        [data-theme="dark"] .table td {
            border-bottom-color: var(--dark-border);
        }

        .alert {
            border-radius: 0.5rem;
            border: none;
            font-size: 0.875rem;
            padding: 0.75rem 1rem;
        }

        .alert-success {
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(5, 150, 105, 0.1));
            color: var(--success-color);
            border-left: 4px solid var(--success-color);
        }

        .alert-info {
            background: linear-gradient(135deg, rgba(6, 182, 212, 0.1), rgba(3, 105, 161, 0.1));
            color: var(--info-color);
            border-left: 4px solid var(--info-color);
        }

        /* Theme Toggle */
        .theme-toggle {
            background: none;
            border: none;
            color: white;
            font-size: 1.25rem;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 0.375rem;
            transition: background-color 0.3s ease;
        }

        .theme-toggle:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        /* Search and Filter */
        .search-container {
            background: var(--light-card);
            border: 1px solid var(--light-border);
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        [data-theme="dark"] .search-container {
            background: var(--dark-card);
            border-color: var(--dark-border);
        }

        .form-control {
            border-radius: 0.375rem;
            border: 1px solid var(--light-border);
            background: var(--light-card);
            color: var(--light-text);
        }

        [data-theme="dark"] .form-control {
            background: var(--dark-card);
            border-color: var(--dark-border);
            color: var(--dark-text);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .table-responsive {
                font-size: 12px;
            }

            .btn {
                padding: 0.5rem 1rem;
                font-size: 0.8125rem;
            }
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="AdminServlet">CarRent Admin</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="AdminServlet">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="AdminServlet?section=users">Users</a></li>
                <li class="nav-item"><a class="nav-link" href="AdminServlet?section=vehicles">Vehicles</a></li>
                <li class="nav-item"><a class="nav-link" href="AdminServlet?section=bookings">Bookings</a></li>
                <li class="nav-item"><a class="nav-link active" href="CampaignController">Campaigns</a></li>
                <li class="nav-item"><a class="nav-link" href="AdminServlet?section=promotions">Promotions</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <button class="theme-toggle me-2" id="themeToggle" title="Toggle theme">
                        <i class="fas fa-moon" id="themeIcon"></i>
                    </button>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="HomeServlet">View Site</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="AuthController?action=logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1 class="h3 mb-0">Customer Email Directory</h1>
            <p class="text-muted">View and manage customer email addresses for campaigns</p>
        </div>
        <div>
            <a href="CampaignController?action=list" class="btn btn-primary">
                <i class="fas fa-arrow-left me-2"></i>Back to Campaigns
            </a>
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
                                            <span class="badge badge-active">Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-inactive">Inactive</span>
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