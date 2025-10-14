<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Staff - Car Rental System</title>
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

        .alert {
            border-radius: 12px;
            border: none;
        }
    </style>
</head>
<body>
    <!-- Top Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <div class="d-flex align-items-center">
                <a href="admin-crud.jsp" class="btn btn-outline-secondary me-3">
                    <i class="fas fa-arrow-left me-1"></i>Back to CRUD
                </a>
                <h4 class="mb-0">Add New Staff Member</h4>
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
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- Success/Error Messages -->
                <c:if test="${not empty param.successMsg}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${param.successMsg}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty param.errorMsg}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${param.errorMsg}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-user-plus me-2"></i>Staff Information</h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="AddStaffServlet" class="row g-3">
                            <input type="hidden" name="action" value="add">

                            <div class="col-md-6">
                                <label for="fullName" class="form-label">Full Name *</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" required>
                            </div>

                            <div class="col-md-6">
                                <label for="email" class="form-label">Email Address *</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>

                            <div class="col-md-6">
                                <label for="phone" class="form-label">Phone Number *</label>
                                <input type="tel" class="form-control" id="phone" name="phone" required>
                            </div>

                            <div class="col-md-6">
                                <label for="username" class="form-label">Username *</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>

                            <div class="col-md-6">
                                <label for="password" class="form-label">Password *</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>

                            <div class="col-md-6">
                                <label for="position" class="form-label">Position *</label>
                                <select class="form-select" id="position" name="position" required>
                                    <option value="">Select Position</option>
                                    <option value="Fleet Supervisor">Fleet Supervisor</option>
                                    <option value="Customer Service Executive">Customer Service Executive</option>
                                    <option value="System Administrator">System Administrator</option>
                                    <option value="Marketing Executive">Marketing Executive</option>
                                    <option value="Accountant">Accountant</option>
                                    <option value="Operations Manager">Operations Manager</option>
                                    <option value="Manager">Manager</option>
                                    <option value="Supervisor">Supervisor</option>
                                    <option value="Staff">Staff</option>
                                    <option value="Driver">Driver</option>
                                    <option value="Mechanic">Mechanic</option>
                                    <option value="Cleaner">Cleaner</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label for="department" class="form-label">Department *</label>
                                <select class="form-select" id="department" name="department" required>
                                    <option value="">Select Department</option>
                                    <option value="Management">Management</option>
                                    <option value="Operations">Operations</option>
                                    <option value="Maintenance">Maintenance</option>
                                    <option value="Customer Service">Customer Service</option>
                                    <option value="Sales">Sales</option>
                                    <option value="HR">HR</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>

                            <div class="col-12">
                                <hr>
                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Add Staff Member
                                    </button>
                                    <a href="admin-crud.jsp" class="btn btn-secondary">
                                        <i class="fas fa-times me-2"></i>Cancel
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Email Domain Validation
        function validateEmailDomain(email) {
            if (!email) return false;
            const allowedDomains = ['@gmail.com', '@my.sliit.lk'];
            return allowedDomains.some(domain => email.toLowerCase().endsWith(domain));
        }

        function showEmailValidation(emailInput, isValid) {
            // Remove existing validation message
            const existingMsg = emailInput.parentNode.querySelector('.email-validation-msg');
            if (existingMsg) {
                existingMsg.remove();
            }

            // Add validation message
            const msg = document.createElement('div');
            msg.className = 'email-validation-msg mt-1';
            msg.style.fontSize = '0.875rem';

            if (!emailInput.value.trim()) {
                msg.innerHTML = '<span style="color: #6c757d;">Please enter an email address</span>';
            } else if (!isValid) {
                msg.innerHTML = '<span style="color: #dc3545;">Email must end with @gmail.com or @my.sliit.lk</span>';
                emailInput.style.borderColor = '#dc3545';
            } else {
                msg.innerHTML = '<span style="color: #198754;">✓ Valid email domain</span>';
                emailInput.style.borderColor = '#198754';
            }

            emailInput.parentNode.appendChild(msg);
        }

        function validateStaffForm(form) {
            const emailInput = form.querySelector('input[name="email"]');
            if (emailInput) {
                const isValid = validateEmailDomain(emailInput.value);
                if (!isValid) {
                    showEmailValidation(emailInput, false);
                    emailInput.focus();
                    return false;
                }
            }
            return true;
        }

        // Initialize email validation when page loads
        document.addEventListener('DOMContentLoaded', function() {
            const emailInput = document.getElementById('email');
            if (emailInput) {
                emailInput.addEventListener('input', function() {
                    const isValid = validateEmailDomain(this.value);
                    showEmailValidation(this, isValid);
                });
                emailInput.addEventListener('blur', function() {
                    const isValid = validateEmailDomain(this.value);
                    showEmailValidation(this, isValid);
                });
            }

            // Add form validation
            const staffForm = document.querySelector('form[action="AddStaffServlet"]');
            if (staffForm) {
                staffForm.addEventListener('submit', function(e) {
                    if (!validateStaffForm(this)) {
                        e.preventDefault();
                        return false;
                    }
                });
            }
        });
    </script>
</body>
</html>