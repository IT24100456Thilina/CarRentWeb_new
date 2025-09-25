<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow p-4 mx-auto" style="max-width: 600px;">
        <h3 class="mb-3 text-center">Submit Feedback</h3>
        <c:if test="${param.success == '1'}">
            <div class="alert alert-success">Thank you! Your feedback was submitted.</div>
        </c:if>
        <c:if test="${not empty param.errorMsg}">
            <div class="alert alert-danger">${param.errorMsg}</div>
        </c:if>
        <form action="FeedbackController" method="post">
            <div class="mb-3"><label class="form-label">Booking ID (optional)</label><input type="number" class="form-control" name="bookingId"></div>
            <div class="mb-3"><label class="form-label">Comments</label><textarea class="form-control" name="comments" rows="4" required></textarea></div>
            <div class="mb-3"><label class="form-label">Rating</label>
                <select class="form-select" name="rating" required>
                    <option value="">Select Rating</option>
                    <option value="1">1 - Poor</option>
                    <option value="2">2 - Fair</option>
                    <option value="3">3 - Good</option>
                    <option value="4">4 - Very Good</option>
                    <option value="5">5 - Excellent</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary w-100">Submit Feedback</button>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
