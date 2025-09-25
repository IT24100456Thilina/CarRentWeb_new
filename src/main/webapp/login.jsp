<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow p-4 mx-auto" style="max-width: 400px;">
        <h3 class="mb-3 text-center">Login</h3>
        <c:if test="${param.registered == '1'}">
            <div class="alert alert-success py-2">Registration successful. Please log in.</div>
        </c:if>
        <c:if test="${param.logout == '1'}">
            <div class="alert alert-info py-2">You have been logged out.</div>
        </c:if>
        <c:if test="${param.error == '1'}">
            <div class="alert alert-danger py-2">Invalid username or password.</div>
        </c:if>
        <c:if test="${not empty param.errorMsg}">
            <div class="alert alert-danger py-2">${param.errorMsg}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/AuthController" method="post">
            <input type="hidden" name="action" value="login">
            <div class="mb-3"><label class="form-label">Role</label>
                <select class="form-select" name="role" required>
                    <option value="customer">Customer</option>
                    <option value="user">User</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            <div class="mb-3"><label class="form-label">Username</label><input type="text" class="form-control" name="username" required></div>
            <div class="mb-3"><label class="form-label">Password</label><input type="password" class="form-control" name="password" required></div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <p class="mt-3 text-center">Don't have an account? <a href="register.jsp">Register</a></p>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
