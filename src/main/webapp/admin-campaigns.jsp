<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Email Campaigns - Admin - CarRent</title>
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

        .btn-warning {
            background: linear-gradient(135deg, var(--warning-color), #d97706);
            color: white;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger-color), #dc2626);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.4);
        }

        .badge {
            font-size: 0.75rem;
            font-weight: 600;
            padding: 0.25rem 0.625rem;
            border-radius: 0.375rem;
        }

        .badge-draft { background: linear-gradient(135deg, var(--secondary-color), #475569); color: white; }
        .badge-sent { background: linear-gradient(135deg, var(--success-color), #059669); color: white; }
        .badge-failed { background: linear-gradient(135deg, var(--danger-color), #dc2626); color: white; }
        .badge-scheduled { background: linear-gradient(135deg, var(--warning-color), #d97706); color: white; }

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

        .alert-danger {
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(220, 38, 38, 0.1));
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
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
            <h1 class="h3 mb-0">Email Campaigns</h1>
            <p class="text-muted">Manage and send email campaigns to customers</p>
        </div>
        <a href="CampaignController?action=create" class="btn btn-primary">
            <i class="fas fa-plus me-2"></i>Create Campaign
        </a>
    </div>

    <!-- Success/Error Messages -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${param.success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Campaigns Table -->
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Subject</th>
                            <th>Segment</th>
                            <th>Status</th>
                            <th>Sent</th>
                            <th>Created</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="campaign" items="${campaigns}">
                            <tr>
                                <td>${campaign.campaignId}</td>
                                <td>
                                    <strong>${campaign.subject}</strong>
                                    <c:if test="${not empty campaign.offer}">
                                        <br><small class="text-muted">Offer: ${campaign.offer}</small>
                                    </c:if>
                                </td>
                                <td>
                                    <span class="badge bg-secondary">${campaign.segment}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${campaign.status == 'draft'}">
                                            <span class="badge badge-draft">Draft</span>
                                        </c:when>
                                        <c:when test="${campaign.status == 'sent'}">
                                            <span class="badge badge-sent">Sent</span>
                                        </c:when>
                                        <c:when test="${campaign.status == 'failed'}">
                                            <span class="badge badge-failed">Failed</span>
                                        </c:when>
                                        <c:when test="${campaign.status == 'scheduled'}">
                                            <span class="badge badge-scheduled">Scheduled</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    ${campaign.sentCount}
                                    <c:if test="${not empty campaign.sentDate}">
                                        <br><small class="text-muted">${campaign.sentDate}</small>
                                    </c:if>
                                </td>
                                <td>${campaign.createdDate}</td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <c:if test="${campaign.status == 'draft'}">
                                            <form action="CampaignController" method="post" class="d-inline">
                                                <input type="hidden" name="action" value="send">
                                                <input type="hidden" name="campaignId" value="${campaign.campaignId}">
                                                <button type="submit" class="btn btn-success btn-sm"
                                                        onclick="return confirm('Are you sure you want to send this campaign?')">
                                                    <i class="fas fa-paper-plane"></i> Send
                                                </button>
                                            </form>
                                            <a href="CampaignController?action=edit&id=${campaign.campaignId}"
                                               class="btn btn-warning btn-sm">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                        </c:if>
                                        <button type="button" class="btn btn-danger btn-sm"
                                                onclick="deleteCampaign('${campaign.campaignId}')">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty campaigns}">
                            <tr>
                                <td colspan="7" class="text-center py-4">
                                    <div class="text-muted">
                                        <i class="fas fa-envelope fa-3x mb-3"></i>
                                        <h5>No campaigns found</h5>
                                        <p>Create your first email campaign to start engaging with customers.</p>
                                        <a href="CampaignController?action=create" class="btn btn-primary">
                                            <i class="fas fa-plus me-2"></i>Create First Campaign
                                        </a>
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

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Delete Campaign</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this campaign? This action cannot be undone.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteForm" action="CampaignController" method="post" class="d-inline">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="campaignId" id="deleteCampaignId">
                    <button type="submit" class="btn btn-danger">Delete Campaign</button>
                </form>
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

    // Initialize theme on page load
    document.addEventListener('DOMContentLoaded', initTheme);

    // Theme toggle event listener
    document.getElementById('themeToggle').addEventListener('click', toggleTheme);

    // Delete campaign function
    function deleteCampaign(campaignId) {
        document.getElementById('deleteCampaignId').value = campaignId;
        const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
        modal.show();
    }
</script>
</body>
</html>