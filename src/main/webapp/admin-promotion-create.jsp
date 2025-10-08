<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Promotion - Admin - CarRent</title>
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
            <a class="nav-link" href="CampaignController">
                <i class="fas fa-envelope"></i> Campaigns
            </a>
            <a class="nav-link active" href="AdminServlet?section=promotions">
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
            <span class="navbar-brand mb-0 h1">Create Promotion</span>
        </div>
    </nav>

    <!-- Page Header -->
    <div class="section-header">
        <div class="d-flex justify-content-between align-items-center flex-wrap">
            <div>
                <h2>Create New Promotion</h2>
                <p class="text-muted mb-0">Design and launch your next promotional offer</p>
            </div>
            <div>
                <a href="AdminServlet?section=promotions" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Promotions
                </a>
            </div>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card">
                <div class="card-body p-5">

                    <form action="PromotionController" method="post">
                        <input type="hidden" name="action" value="add">

                        <!-- Promotion Details Section -->
                        <div class="form-section mb-5">
                            <h4 class="section-title mb-4">
                                <i class="fas fa-info-circle me-2 text-primary"></i>Promotion Details
                            </h4>
                            <div class="row g-4">
                                <div class="col-md-8">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" name="title" id="title" required
                                               placeholder="Enter promotion title">
                                        <label for="title">
                                            <i class="fas fa-tag me-2"></i>Promotion Title *
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" name="badge" id="badge"
                                               placeholder="e.g., HOT, NEW, SALE">
                                        <label for="badge">
                                            <i class="fas fa-certificate me-2"></i>Badge (Optional)
                                        </label>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form-floating">
                                        <textarea class="form-control" name="description" id="description" rows="4" required
                                                  placeholder="Describe the promotion details, terms, and conditions."></textarea>
                                        <label for="description">
                                            <i class="fas fa-file-alt me-2"></i>Description *
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Discount Settings Section -->
                        <div class="form-section mb-5">
                            <h4 class="section-title mb-4">
                                <i class="fas fa-percent me-2 text-primary"></i>Discount Settings
                            </h4>
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" name="discountCode" id="discountCode"
                                               placeholder="e.g., SAVE20, WELCOME10">
                                        <label for="discountCode">
                                            <i class="fas fa-key me-2"></i>Discount Code (Optional)
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-floating">
                                        <select class="form-select" name="discountType" id="discountType" required>
                                            <option value="percentage">Percentage</option>
                                            <option value="fixed">Fixed Amount</option>
                                        </select>
                                        <label for="discountType">
                                            <i class="fas fa-calculator me-2"></i>Discount Type *
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-floating">
                                        <input type="number" class="form-control" name="discountValue" id="discountValue"
                                               step="0.01" min="0" placeholder="e.g., 20.00">
                                        <label for="discountValue">
                                            <i class="fas fa-dollar-sign me-2"></i>Value *
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Validity & Type Section -->
                        <div class="form-section mb-5">
                            <h4 class="section-title mb-4">
                                <i class="fas fa-calendar me-2 text-primary"></i>Validity & Type
                            </h4>
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <input type="date" class="form-control" name="validTill" id="validTill">
                                        <label for="validTill">
                                            <i class="fas fa-calendar-times me-2"></i>Valid Until (Optional)
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <select class="form-select" name="type" id="type" required>
                                            <option value="general">General</option>
                                            <option value="seasonal">Seasonal</option>
                                            <option value="loyalty">Loyalty</option>
                                            <option value="first_time">First Time</option>
                                        </select>
                                        <label for="type">
                                            <i class="fas fa-layer-group me-2"></i>Promotion Type *
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
                                        <h5 class="alert-heading mb-3">Tips for Effective Promotions</h5>
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <div class="d-flex align-items-center mb-2">
                                                    <i class="fas fa-check-circle text-success me-2"></i>
                                                    <span>Use clear, compelling titles</span>
                                                </div>
                                                <div class="d-flex align-items-center mb-2">
                                                    <i class="fas fa-check-circle text-success me-2"></i>
                                                    <span>Set reasonable discount values</span>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="d-flex align-items-center mb-2">
                                                    <i class="fas fa-check-circle text-success me-2"></i>
                                                    <span>Specify clear validity periods</span>
                                                </div>
                                                <div class="d-flex align-items-center mb-2">
                                                    <i class="fas fa-check-circle text-success me-2"></i>
                                                    <span>Choose appropriate promotion types</span>
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
                                <i class="fas fa-save me-2"></i>Create Promotion
                            </button>
                            <a href="AdminServlet?section=promotions" class="btn btn-secondary btn-lg px-5">
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