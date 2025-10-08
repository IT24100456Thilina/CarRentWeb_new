<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Monthly Income Report - Car Rental System</title>
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
        .stat-card { background: var(--bg-white); border: 1px solid var(--border-color); border-radius: 16px; box-shadow: var(--shadow); transition: all 0.3s ease; }
        .stat-card:hover { transform: translateY(-5px); box-shadow: var(--shadow-lg); }
        .card { border-radius: 16px; box-shadow: var(--shadow); border: none; }
        .btn-primary { background: linear-gradient(135deg, var(--accent-color), var(--accent-dark)); border: none; transition: all 0.3s ease; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3); }
        .table { border-radius: 12px; overflow: hidden; }
        .form-control, .form-select { border-radius: 8px; border: 2px solid var(--border-color); transition: border-color 0.3s ease; }
        .form-control:focus, .form-select:focus { border-color: var(--accent-color); box-shadow: 0 0 0 0.2rem rgba(59, 130, 246, 0.25); }
        h2 { color: var(--text-dark); font-weight: 700; }
        .badge { border-radius: 20px; }
        .section-header { background: var(--bg-white); padding: 1.5rem; border-radius: 12px; margin-bottom: 1.5rem; box-shadow: var(--shadow); }
        .section-header h3 { color: var(--text-dark); font-weight: 600; margin: 0; }
        .stat-icon { width: 60px; height: 60px; background: linear-gradient(135deg, var(--accent-color), var(--accent-light)); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.5rem; margin-bottom: 1rem; }

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
            <div class="d-flex align-items-center mb-4">
                <div class="logo me-3" style="width: 40px; height: 40px; background: linear-gradient(135deg, var(--accent-color), var(--accent-light)); border-radius: 10px; display: flex; align-items: center; justify-content: center; color: white; font-weight: 700;">CG</div>
                <h5 class="mb-0">CarGO Accountant</h5>
            </div>
            <nav class="nav flex-column">
                <a class="nav-link active" href="IncomeReportServlet"><i class="fas fa-chart-line"></i>Income Report</a>
                <a class="nav-link" href="AdminServlet"><i class="fas fa-tachometer-alt"></i>Admin Dashboard</a>
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
                <h4 class="mb-0">Monthly Income Report</h4>
            </div>
            <div class="d-flex align-items-center">
                <c:if test="${not empty sessionScope.username}">
                    <span class="me-3 text-muted">
                        Welcome, ${sessionScope.userFullName}
                        <c:if test="${not empty sessionScope.position}">
                            <br><small class="text-primary">${sessionScope.position} - ${sessionScope.department}</small>
                        </c:if>
                    </span>
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
                                    <div class="stat-icon mx-auto">
                                        <i class="fas fa-user-shield"></i>
                                    </div>
                                    <h3>Access Restricted</h3>
                                    <p class="text-muted">Please login as an accountant to access the income report.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Report Header -->
                <div class="section-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3><i class="fas fa-file-invoice-dollar me-2"></i>Monthly Income Report - ${reportPeriod}</h3>
                        <div class="d-flex gap-2">
                            <button onclick="window.print()" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-print me-1"></i>Print
                            </button>
                            <button onclick="exportToExcel()" class="btn btn-outline-success btn-sm">
                                <i class="fas fa-file-excel me-1"></i>Export Excel
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Month/Year Selector -->
                <div class="card mb-4">
                    <div class="card-body">
                        <form method="get" action="IncomeReportServlet" class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Month</label>
                                <select name="month" class="form-select">
                                    <c:forEach var="i" begin="1" end="12">
                                        <option value="${i}" ${i == reportMonth ? 'selected' : ''}>
                                            ${monthNames[i-1]}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Year</label>
                                <select name="year" class="form-select">
                                    <c:forEach var="y" begin="2023" end="2026">
                                        <option value="${y}" ${y == reportYear ? 'selected' : ''}>${y}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search me-1"></i>Generate Report
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Summary Cards -->
                <div class="row g-4 mb-5">
                    <div class="col-lg-4 col-md-6">
                        <div class="card stat-card text-center p-4">
                            <div class="stat-icon mx-auto">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="display-6 fw-bold text-success">Rs${totalIncome}</div>
                            <div class="text-muted">Total Income</div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card stat-card text-center p-4">
                            <div class="stat-icon mx-auto">
                                <i class="fas fa-minus-circle"></i>
                            </div>
                            <div class="display-6 fw-bold text-danger">Rs${totalExpenses}</div>
                            <div class="text-muted">Total Expenses</div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="card stat-card text-center p-4">
                            <div class="stat-icon mx-auto">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <div class="display-6 fw-bold text-primary">Rs${netProfit}</div>
                            <div class="text-muted">Net Profit</div>
                        </div>
                    </div>
                </div>

                <!-- Transactions Table -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0"><i class="fas fa-list me-2"></i>Transaction Details</h5>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-search me-2 text-muted"></i>
                            <input type="text" id="transactionSearch" class="form-control form-control-sm" placeholder="Search transactions..." style="width: 250px;">
                        </div>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty transactions}">
                            <div class="alert alert-info mb-0">
                                <i class="fas fa-info-circle me-2"></i>No transactions found for the selected period.
                            </div>
                        </c:if>
                        <c:if test="${not empty transactions}">
                            <div class="table-responsive">
                                <table class="table table-striped align-middle" id="transactionsTable">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="fas fa-hashtag me-1"></i>Payment ID</th>
                                            <th><i class="fas fa-calendar-check me-1"></i>Booking ID</th>
                                            <th><i class="fas fa-user me-1"></i>Customer</th>
                                            <th><i class="fas fa-car me-1"></i>Vehicle</th>
                                            <th><i class="fas fa-dollar-sign me-1"></i>Amount</th>
                                            <th><i class="fas fa-credit-card me-1"></i>Payment Method</th>
                                            <th><i class="fas fa-calendar me-1"></i>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="transaction" items="${transactions}">
                                            <tr>
                                                <td>${transaction.paymentId}</td>
                                                <td>${transaction.bookingId}</td>
                                                <td>${transaction.customerName}</td>
                                                <td>${transaction.vehicleName}</td>
                                                <td>Rs${transaction.amount}</td>
                                                <td>${transaction.paymentMethod}</td>
                                                <td>${transaction.paymentDate != null ? transaction.paymentDate : 'N/A'}</td>
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
    <script>
        function exportToExcel() {
            // Simple CSV export (can be enhanced with proper Excel library)
            const table = document.getElementById('transactionsTable');
            let csv = [];
            for (let row of table.rows) {
                let rowData = [];
                for (let cell of row.cells) {
                    rowData.push('"' + cell.innerText.replace(/"/g, '""') + '"');
                }
                csv.push(rowData.join(','));
            }
            const csvContent = csv.join('\n');
            const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'income_report_${reportMonthName}_${reportYear}.csv';
            link.click();
        }

        // Search functionality for transactions table
        document.getElementById('transactionSearch').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const table = document.getElementById('transactionsTable');
            const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

            for (let i = 0; i < rows.length; i++) {
                const cells = rows[i].getElementsByTagName('td');
                let found = false;

                for (let j = 0; j < cells.length; j++) {
                    const cellText = cells[j].textContent.toLowerCase();
                    if (cellText.includes(searchTerm)) {
                        found = true;
                        break;
                    }
                }

                if (found) {
                    rows[i].style.display = '';
                } else {
                    rows[i].style.display = 'none';
                }
            }
        });
    </script>
</body>
</html>