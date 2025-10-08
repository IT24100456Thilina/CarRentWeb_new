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

        [data-theme="dark"] body {
            color: var(--dark-text);
            background-color: var(--dark-bg);
        }

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

        [data-theme="dark"] .card, [data-theme="dark"] .table {
            background: var(--dark-card);
            border-color: var(--dark-border);
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
            <a class="nav-link" href="AdminServlet?section=users">
                <i class="fas fa-users"></i> Users
            </a>
            <a class="nav-link" href="AdminServlet?section=vehicles">
                <i class="fas fa-car"></i> Vehicles
            </a>
            <a class="nav-link" href="AdminServlet?section=bookings">
                <i class="fas fa-calendar-check"></i> Bookings
            </a>
            <a class="nav-link active" href="CampaignController">
                <i class="fas fa-envelope"></i> Campaigns
            </a>
            <a class="nav-link" href="AdminServlet?section=promotions">
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
            <span class="navbar-brand mb-0 h1">Email Campaigns</span>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="section-header">
        <div class="d-flex justify-content-between align-items-center flex-wrap">
            <div>
                <h2>Email Campaigns</h2>
                <p class="text-muted mb-0">Manage and send email campaigns to customers</p>
            </div>
            <div class="d-flex gap-3">
                <a href="CampaignController?action=customers" class="btn btn-outline-primary">
                    <i class="fas fa-users me-2"></i>View Customers
                </a>
                <a href="CampaignController?action=performance" class="btn btn-outline-success">
                    <i class="fas fa-chart-bar me-2"></i>Performance
                </a>
                <a href="CampaignController?action=create" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Create Campaign
                </a>
            </div>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="row mb-4">
        <div class="col-md-4 mb-3">
            <div class="stat-card p-4">
                <div class="d-flex align-items-center">
                    <div class="stat-icon me-3">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div>
                        <h4 class="mb-1">${campaigns.size()}</h4>
                        <p class="text-muted mb-0">Total Campaigns</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="stat-card p-4">
                <div class="d-flex align-items-center">
                    <div class="stat-icon me-3">
                        <i class="fas fa-paper-plane"></i>
                    </div>
                    <div>
                        <h4 class="mb-1">
                            <c:set var="sentCount" value="0"/>
                            <c:forEach var="campaign" items="${campaigns}">
                                <c:if test="${campaign.status == 'sent'}">
                                    <c:set var="sentCount" value="${sentCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${sentCount}
                        </h4>
                        <p class="text-muted mb-0">Sent Campaigns</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="stat-card p-4">
                <div class="d-flex align-items-center">
                    <div class="stat-icon me-3">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div>
                        <h4 class="mb-1">
                            <c:set var="draftCount" value="0"/>
                            <c:forEach var="campaign" items="${campaigns}">
                                <c:if test="${campaign.status == 'draft'}">
                                    <c:set var="draftCount" value="${draftCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${draftCount}
                        </h4>
                        <p class="text-muted mb-0">Draft Campaigns</p>
                    </div>
                </div>
            </div>
        </div>
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
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th style="width: 5%;">ID</th>
                            <th style="width: 20%;">Campaign Details</th>
                            <th style="width: 8%;">Segment</th>
                            <th style="width: 8%;">Status</th>
                            <th style="width: 12%;">Sent Info</th>
                            <th style="width: 10%;">Performance</th>
                            <th style="width: 12%;">Created</th>
                            <th style="width: 25%;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="campaign" items="${campaigns}">
                            <tr>
                                <td>
                                    <span class="fw-bold text-primary">#${campaign.campaignId}</span>
                                </td>
                                <td>
                                    <div class="campaign-subject">${campaign.subject}</div>
                                    <c:if test="${not empty campaign.offer}">
                                        <div class="campaign-offer">${campaign.offer}</div>
                                    </c:if>
                                </td>
                                <td>
                                    <span class="badge bg-primary">
                                        <c:choose>
                                            <c:when test="${campaign.segment == 'all'}">All</c:when>
                                            <c:when test="${campaign.segment == 'active_customers'}">Active</c:when>
                                            <c:when test="${campaign.segment == 'new_customers'}">New</c:when>
                                            <c:otherwise>${campaign.segment}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${campaign.status == 'draft'}">
                                            <span class="badge bg-warning text-dark">Draft</span>
                                        </c:when>
                                        <c:when test="${campaign.status == 'sent'}">
                                            <span class="badge bg-success">Sent</span>
                                        </c:when>
                                        <c:when test="${campaign.status == 'failed'}">
                                            <span class="badge bg-danger">Failed</span>
                                        </c:when>
                                        <c:when test="${campaign.status == 'scheduled'}">
                                            <span class="badge bg-info">Scheduled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${campaign.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="fw-bold">${campaign.sentCount} emails</div>
                                    <c:if test="${not empty campaign.sentDate}">
                                        <small class="text-muted">${campaign.sentDate}</small>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${campaign.status == 'sent'}">
                                        <div class="text-center">
                                            <div class="small text-muted">Open: <strong>${campaign.openRate}%</strong></div>
                                            <div class="small text-muted">Click: <strong>${campaign.clickRate}%</strong></div>
                                        </div>
                                    </c:if>
                                    <c:if test="${campaign.status != 'sent'}">
                                        <span class="text-muted small">-</span>
                                    </c:if>
                                </td>
                                <td>
                                    <div>${campaign.createdDate}</div>
                                </td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <c:if test="${campaign.status == 'draft'}">
                                            <form action="CampaignController" method="post" class="d-inline">
                                                <input type="hidden" name="action" value="send">
                                                <input type="hidden" name="campaignId" value="${campaign.campaignId}">
                                                <button type="submit" class="btn btn-success btn-sm"
                                                        onclick="return confirm('Are you sure you want to send this campaign?')">
                                                    <i class="fas fa-paper-plane"></i>
                                                </button>
                                            </form>
                                            <a href="CampaignController?action=edit&id=${campaign.campaignId}"
                                               class="btn btn-warning btn-sm">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                        </c:if>
                                        <a href="CampaignController?action=logs" class="btn btn-info btn-sm">
                                            <i class="fas fa-list"></i>
                                        </a>
                                        <button type="button" class="btn btn-danger btn-sm"
                                                onclick="deleteCampaign('${campaign.campaignId}')">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty campaigns}">
                            <tr>
                                <td colspan="8" class="p-0">
                                    <div class="empty-state">
                                        <i class="fas fa-envelope"></i>
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