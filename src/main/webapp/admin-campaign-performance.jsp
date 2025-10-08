<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Campaign Performance - Admin - CarRent</title>
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

        .performance-metric { text-align: center; padding: 1rem; }
        .metric-value { font-size: 2rem; font-weight: 700; color: var(--accent-color); }
        .metric-label { font-size: 0.9rem; color: var(--text-light); text-transform: uppercase; letter-spacing: 0.5px; }

        .rate-indicator {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        .rate-high { background: rgba(34, 197, 94, 0.1); color: #16a34a; }
        .rate-medium { background: rgba(251, 191, 36, 0.1); color: #d97706; }
        .rate-low { background: rgba(239, 68, 68, 0.1); color: #dc2626; }

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
            <span class="navbar-brand mb-0 h1">Campaign Performance</span>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="section-header">
        <div class="d-flex justify-content-between align-items-center flex-wrap">
            <div>
                <h2>Campaign Performance Analytics</h2>
                <p class="text-muted mb-0">Track email open rates, click-through rates, and campaign effectiveness</p>
            </div>
            <div class="d-flex gap-3">
                <a href="CampaignController" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Campaigns
                </a>
            </div>
        </div>
    </div>

    <!-- Overall Stats -->
    <div class="row mb-4">
        <div class="col-md-3 mb-3">
            <div class="stat-card p-4">
                <div class="performance-metric">
                    <div class="stat-icon mx-auto">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="metric-value">
                        <c:set var="totalSent" value="0"/>
                        <c:forEach var="campaign" items="${performanceSummary}">
                            <c:set var="totalSent" value="${totalSent + campaign.sentCount}"/>
                        </c:forEach>
                        ${totalSent}
                    </div>
                    <div class="metric-label">Total Emails Sent</div>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card p-4">
                <div class="performance-metric">
                    <div class="stat-icon mx-auto">
                        <i class="fas fa-eye"></i>
                    </div>
                    <div class="metric-value">
                        <c:set var="totalOpens" value="0"/>
                        <c:forEach var="campaign" items="${performanceSummary}">
                            <c:set var="totalOpens" value="${totalOpens + campaign.uniqueOpens}"/>
                        </c:forEach>
                        ${totalOpens}
                    </div>
                    <div class="metric-label">Total Opens</div>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card p-4">
                <div class="performance-metric">
                    <div class="stat-icon mx-auto">
                        <i class="fas fa-mouse-pointer"></i>
                    </div>
                    <div class="metric-value">
                        <c:set var="totalClicks" value="0"/>
                        <c:forEach var="campaign" items="${performanceSummary}">
                            <c:set var="totalClicks" value="${totalClicks + campaign.uniqueClicks}"/>
                        </c:forEach>
                        ${totalClicks}
                    </div>
                    <div class="metric-label">Total Clicks</div>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="stat-card p-4">
                <div class="performance-metric">
                    <div class="stat-icon mx-auto">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="metric-value">
                        <c:set var="avgOpenRate" value="0"/>
                        <c:set var="campaignCount" value="0"/>
                        <c:forEach var="campaign" items="${performanceSummary}">
                            <c:set var="avgOpenRate" value="${avgOpenRate + campaign.openRate}"/>
                            <c:set var="campaignCount" value="${campaignCount + 1}"/>
                        </c:forEach>
                        <fmt:formatNumber value="${campaignCount > 0 ? avgOpenRate / campaignCount : 0}" pattern="0.0"/>%
                    </div>
                    <div class="metric-label">Avg Open Rate</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Performance Table -->
    <div class="card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th style="width: 5%;">ID</th>
                            <th style="width: 30%;">Campaign</th>
                            <th style="width: 10%;">Sent</th>
                            <th style="width: 10%;">Opens</th>
                            <th style="width: 10%;">Clicks</th>
                            <th style="width: 10%;">Open Rate</th>
                            <th style="width: 10%;">Click Rate</th>
                            <th style="width: 15%;">Sent Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="campaign" items="${performanceSummary}">
                            <tr>
                                <td>
                                    <span class="fw-bold text-primary">#${campaign.campaignId}</span>
                                </td>
                                <td>
                                    <div class="fw-bold">${campaign.subject}</div>
                                </td>
                                <td>
                                    <span class="badge bg-primary">${campaign.sentCount}</span>
                                </td>
                                <td>
                                    <span class="badge bg-info">${campaign.uniqueOpens}</span>
                                </td>
                                <td>
                                    <span class="badge bg-success">${campaign.uniqueClicks}</span>
                                </td>
                                <td>
                                    <c:set var="rateClass" value="${campaign.openRate >= 30 ? 'rate-high' : campaign.openRate >= 15 ? 'rate-medium' : 'rate-low'}"/>
                                    <span class="rate-indicator ${rateClass}">${campaign.openRate}%</span>
                                </td>
                                <td>
                                    <c:set var="clickRateClass" value="${campaign.clickRate >= 5 ? 'rate-high' : campaign.clickRate >= 2 ? 'rate-medium' : 'rate-low'}"/>
                                    <span class="rate-indicator ${clickRateClass}">${campaign.clickRate}%</span>
                                </td>
                                <td>
                                    <div>${campaign.sentDate}</div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty performanceSummary}">
                            <tr>
                                <td colspan="8" class="p-0">
                                    <div class="empty-state">
                                        <i class="fas fa-chart-bar"></i>
                                        <h5>No performance data available</h5>
                                        <p>Send some campaigns first to see performance analytics.</p>
                                        <a href="CampaignController?action=create" class="btn btn-primary">
                                            <i class="fas fa-plus me-2"></i>Create Campaign
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

    // Initialize theme on page load
    document.addEventListener('DOMContentLoaded', initTheme);
</script>
</body>
</html>