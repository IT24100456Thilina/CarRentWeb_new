<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Campaign - Admin - CarRent</title>
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

        .card {
            background: var(--light-card);
            border: 1px solid var(--light-border);
            border-radius: 1rem;
            box-shadow: var(--shadow-lg);
            overflow: hidden;
        }

        [data-theme="dark"] .card {
            background: var(--dark-card);
            border-color: var(--dark-border);
        }

        .card-body {
            padding: 2rem;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--light-text);
            text-align: center;
            margin-bottom: 2rem;
        }

        [data-theme="dark"] .card-title {
            color: var(--dark-text);
        }

        .form-label {
            font-weight: 500;
            font-size: 0.875rem;
            color: var(--light-text);
            margin-bottom: 0.5rem;
        }

        [data-theme="dark"] .form-label {
            color: var(--dark-text);
        }

        .form-control, .form-select {
            font-size: 0.875rem;
            padding: 0.75rem 1rem;
            border: 1px solid var(--light-border);
            border-radius: 0.5rem;
            background: var(--light-card);
            color: var(--light-text);
            transition: all 0.3s ease;
            width: 100%;
        }

        [data-theme="dark"] .form-control, [data-theme="dark"] .form-select {
            background: var(--dark-card);
            border-color: var(--dark-border);
            color: var(--dark-text);
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            outline: none;
        }

        .form-control[rows] {
            resize: vertical;
            min-height: 120px;
        }

        .btn {
            font-size: 0.875rem;
            font-weight: 500;
            padding: 0.75rem 1.5rem;
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

        .btn-secondary {
            background: var(--secondary-color);
            color: white;
        }

        .btn-secondary:hover {
            background: #475569;
            transform: translateY(-2px);
        }

        .alert {
            border-radius: 0.5rem;
            border: none;
            font-size: 0.875rem;
            padding: 0.75rem 1rem;
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

        /* Responsive Design */
        @media (max-width: 576px) {
            body {
                padding: 0.5rem;
            }

            .card-body {
                padding: 1.5rem;
            }

            .card-title {
                font-size: 1.25rem;
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
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card">
                <div class="card-body">
                    <h3 class="card-title">
                        <i class="fas fa-plus-circle me-2"></i>Create New Campaign
                    </h3>

                    <form action="CampaignController" method="post">
                        <input type="hidden" name="action" value="create">

                        <div class="row g-3">
                            <div class="col-md-8">
                                <label class="form-label">Email Subject *</label>
                                <input type="text" class="form-control" name="subject" required
                                       placeholder="Enter compelling email subject">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Target Segment *</label>
                                <select class="form-select" name="segment" required>
                                    <option value="">Select segment</option>
                                    <option value="all">All Customers</option>
                                    <option value="active_customers">Active Customers</option>
                                    <option value="new_customers">New Customers (30 days)</option>
                                </select>
                            </div>

                            <div class="col-12">
                                <label class="form-label">Special Offer (Optional)</label>
                                <input type="text" class="form-control" name="offer"
                                       placeholder="e.g., 20% off next booking, Free upgrade, etc.">
                            </div>

                            <div class="col-12">
                                <label class="form-label">Email Body *</label>
                                <textarea class="form-control" name="body" rows="8" required
                                          placeholder="Write your email content here. Include personalized greetings, offer details, and call-to-action."></textarea>
                            </div>

                            <div class="col-12">
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle me-2"></i>
                                    <strong>Tips for effective campaigns:</strong>
                                    <ul class="mb-0 mt-2">
                                        <li>Use personalized greetings like "Dear [Name]"</li>
                                        <li>Include clear call-to-action buttons</li>
                                        <li>Mention any special offers or promotions</li>
                                        <li>Keep the message concise and engaging</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex gap-3 mt-4">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Save Campaign
                            </button>
                            <a href="CampaignController?action=list" class="btn btn-secondary">
                                <i class="fas fa-times me-2"></i>Cancel
                            </a>
                        </div>
                    </form>
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

    // Initialize theme on page load
    document.addEventListener('DOMContentLoaded', initTheme);

    // Theme toggle event listener
    document.getElementById('themeToggle').addEventListener('click', toggleTheme);
</script>
</body>
</html>