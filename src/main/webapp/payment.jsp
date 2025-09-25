<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow p-4 mx-auto" style="max-width: 500px;">
        <h3 class="mb-3 text-center">Payment</h3>
        <c:if test="${param.success == '1'}">
            <div class="alert alert-success">Payment successful for Booking ID: ${param.bookingId}</div>
        </c:if>
        <c:if test="${not empty param.errorMsg}">
            <div class="alert alert-danger">${param.errorMsg}</div>
        </c:if>
        <form action="PaymentController" method="post">
            <div class="mb-3"><label class="form-label">Booking ID</label><input type="number" class="form-control" name="bookingId" required></div>
            <div class="mb-3"><label class="form-label">Amount</label><input type="number" step="0.01" class="form-control" name="amount" required></div>
            <div class="mb-3"><label class="form-label">Payment Method</label>
                <select class="form-select" name="paymentMethod" required>
                    <option value="">Select Method</option>
                    <option value="Credit Card">Credit Card</option>
                    <option value="Debit Card">Debit Card</option>
                    <option value="Cash">Cash</option>
                    <option value="PayPal">PayPal</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success w-100">Pay Now</button>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
