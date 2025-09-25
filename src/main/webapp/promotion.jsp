<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Promotions - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%); min-height: 100vh; }
        .card { border-radius: 1rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: none; transition: transform 0.3s ease, box-shadow 0.3s ease; }
        .card:hover { transform: translateY(-5px); box-shadow: 0 15px 35px rgba(0,0,0,0.1); }
        .badge { background: linear-gradient(135deg, #667eea, #764ba2); }
        h2 { color: #2d3748; font-weight: 700; }
        .alert { border-radius: 1rem; }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2>Current Promotions</h2>
    <c:if test="${empty promotions}">
        <div class="alert alert-info">No promotions available now.</div>
    </c:if>
    <div class="row g-4">
        <c:forEach var="p" items="${promotions}">
            <div class="col-md-4">
                <div class="card h-100 shadow">
                    <div class="card-body">
                        <h5 class="card-title">${p.title}</h5>
                        <p class="card-text">${p.description}</p>
                        <c:if test="${not empty p.badge}"><span class="badge bg-primary">${p.badge}</span></c:if>
                        <c:if test="${not empty p.validTill}"><div class="text-muted mt-2">Valid till: ${p.validTill}</div></c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


