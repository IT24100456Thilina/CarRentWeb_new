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

        /* Form Enhancements */
        .form-floating { position: relative; }
        .form-floating .form-control, .form-floating .form-select { height: calc(3.5rem + 2px); padding-top: 1.625rem; padding-bottom: 0.625rem; }
        .form-floating label { position: absolute; top: 0; left: 1rem; height: 100%; padding: 1rem 0; pointer-events: none; border: none; transform-origin: 0 0; transition: opacity 0.1s ease-in-out, transform 0.1s ease-in-out; font-weight: 500; }
        .form-floating .form-control:focus ~ label, .form-floating .form-control:not(:placeholder-shown) ~ label, .form-floating .form-select ~ label { opacity: 0.65; transform: scale(0.85) translateY(-0.5rem) translateX(0.15rem); }
        .form-section { padding: 2rem; background: rgba(59, 130, 246, 0.02); border-radius: 1rem; border: 1px solid rgba(59, 130, 246, 0.1); }
        .section-title { color: var(--text-dark); font-weight: 700; font-size: 1.25rem; margin-bottom: 1.5rem; padding-bottom: 0.5rem; border-bottom: 2px solid var(--accent-color); display: inline-block; }
        .icon-wrapper { display: inline-block; padding: 1rem; background: linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(37, 99, 235, 0.1)); border-radius: 50%; }
        .text-gradient { background: linear-gradient(135deg, var(--accent-color), var(--accent-light)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
        .btn-lg { padding: 0.875rem 2rem; font-size: 1rem; font-weight: 600; }

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
            <a class="nav-link" href="admin-crud.jsp">
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
            <span class="navbar-brand mb-0 h1">Create Campaign</span>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="section-header">
        <div class="d-flex justify-content-between align-items-center flex-wrap">
            <div>
                <h2>Create New Campaign</h2>
                <p class="text-muted mb-0">Design and launch your next email marketing campaign</p>
            </div>
            <div>
                <a href="admin-promotion-create.jsp" class="btn btn-outline-success me-2">
                    <i class="fas fa-tags me-2"></i>Create Promotion
                </a>
                <a href="CampaignController?action=list" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Campaigns
                </a>
            </div>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card">
                <div class="card-body p-5">

                    <form action="CampaignController" method="post">
                        <input type="hidden" name="action" value="create">

                        <!-- Campaign Details Section -->
                        <div class="form-section mb-5">
                            <h4 class="section-title mb-4">
                                <i class="fas fa-info-circle me-2 text-primary"></i>Campaign Details
                            </h4>
                            <div class="row g-4">
                                <div class="col-md-8">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" name="subject" id="subject" required
                                                placeholder="Enter compelling email subject">
                                        <label for="subject">
                                            <i class="fas fa-envelope me-2"></i>Email Subject *
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-floating">
                                        <select class="form-select" name="segment" id="segment" required>
                                            <option value="">Select segment</option>
                                            <option value="all">All Customers</option>
                                            <option value="active_customers">Active Customers</option>
                                            <option value="new_customers">New Customers (30 days)</option>
                                        </select>
                                        <label for="segment">
                                            <i class="fas fa-users me-2"></i>Target Segment *
                                        </label>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" name="offer" id="offer"
                                                placeholder="e.g., 20% off next booking, Free upgrade, etc.">
                                        <label for="offer">
                                            <i class="fas fa-gift me-2"></i>Special Offer (Optional)
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Email Content Section -->
                        <div class="form-section mb-5">
                            <h4 class="section-title mb-4">
                                <i class="fas fa-edit me-2 text-primary"></i>Email Content
                            </h4>
                            <div class="row g-4">
                                <div class="col-12">
                                    <div class="form-floating">
                                        <textarea class="form-control" name="body" id="body" rows="10" required
                                                  placeholder="Write your email content here. Include personalized greetings, offer details, and call-to-action."></textarea>
                                        <label for="body">
                                            <i class="fas fa-file-alt me-2"></i>Email Body *
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Tips Section -->
                        <div class="form-section mb-5">
                            <div class="alert alert-info border-0 rounded-4 p-4" style="background: linear-gradient(135deg, rgba(6, 182, 212, 0.1), rgba(3, 105, 161, 0.1));">
                                <div class="d-flex align-items-start">
                                    <i class="fas fa-lightbulb fa-2x text-info me-3 mt-1"></i>
                                    <div>
                                        <h5 class="alert-heading mb-3">Tips for Effective Campaigns</h5>
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <div class="d-flex align-items-center mb-2">
                                                    <i class="fas fa-check-circle text-success me-2"></i>
                                                    <span>Use personalized greetings like "Dear [Name]"</span>
                                                </div>
                                                <div class="d-flex align-items-center mb-2">
                                                    <i class="fas fa-check-circle text-success me-2"></i>
                                                    <span>Include clear call-to-action buttons</span>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="d-flex align-items-center mb-2">
                                                    <i class="fas fa-check-circle text-success me-2"></i>
                                                    <span>Mention any special offers or promotions</span>
                                                </div>
                                                <div class="d-flex align-items-center mb-2">
                                                    <i class="fas fa-check-circle text-success me-2"></i>
                                                    <span>Keep the message concise and engaging</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex gap-3 justify-content-center mt-5">
                            <button type="submit" class="btn btn-primary btn-lg px-5">
                                <i class="fas fa-save me-2"></i>Save Campaign
                            </button>
                            <a href="CampaignController?action=list" class="btn btn-secondary btn-lg px-5">
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