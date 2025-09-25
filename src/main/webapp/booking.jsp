<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Car Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow p-4">
        <h3 class="mb-3">Book a Car</h3>
        <c:if test="${param.booked == '1'}">
            <div class="alert alert-success">Your booking has been submitted.</div>
        </c:if>
        <c:if test="${not empty param.errorMsg}">
            <div class="alert alert-danger">${param.errorMsg}</div>
        </c:if>
        <form action="BookingController" method="post">
            <input type="hidden" name="action" value="create">
            <div class="mb-3">
                <label class="form-label">User ID</label>
                <input type="number" class="form-control" name="userId" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Vehicle ID</label>
                <input type="number" class="form-control" name="vehicleId" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Pick-up Date</label>
                <input type="date" class="form-control" name="pickupDate" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Return Date</label>
                <input type="date" class="form-control" name="returnDate" required>
            </div>
            <button type="submit" class="btn btn-primary">Confirm Booking</button>
        </form>
    </div>
</div>
<c:choose>
    <c:when test="${not empty sessionScope.currentUser}">
        Welcome, ${sessionScope.currentUser}!
    </c:when>
    <c:otherwise>
        <a href="login.jsp">Login first</a>
    </c:otherwise>
</c:choose>

</body>
</html>
