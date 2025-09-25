<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow p-4 mx-auto" style="max-width: 500px;">
        <h3 class="mb-3 text-center">Create Account</h3>
        <form action="${pageContext.request.contextPath}/AuthController" method="post">
            <input type="hidden" name="action" value="register">
            <div class="mb-3"><label class="form-label">Full Name</label><input type="text" class="form-control" name="fullName" required></div>
            <div class="mb-3"><label class="form-label">Email</label><input type="email" class="form-control" name="email" required></div>
            <div class="mb-3"><label class="form-label">Phone</label><input type="text" class="form-control" name="phone" required></div>
            <div class="mb-3"><label class="form-label">Username</label><input type="text" class="form-control" name="username" required></div>
            <div class="mb-3"><label class="form-label">Password</label><input type="password" class="form-control" name="password" required></div>
            <div class="mb-3"><label class="form-label">Role</label>
                <select class="form-select" name="role" required>
                    <option value="customer">Customer</option>
                    <option value="user">User</option>
                    <option value="admin">Admin</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary w-100">Register</button>
        </form>
        <p class="mt-3 text-center">Already have an account? <a href="login.jsp">Login</a></p>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
