<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback - CarRent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; padding-top: 70px; background-color: #f8fafc; }
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .brand-primary { color: #667eea; }
        .feedback-card { transition: transform 0.3s ease, box-shadow 0.3s ease; border: none; border-radius: 1rem; overflow: hidden; }
        .feedback-card:hover { transform: translateY(-5px); box-shadow: 0 15px 35px rgba(0,0,0,0.1); }
        .rating-stars { color: #fbbf24; font-size: 1.2rem; }
        .btn-primary { background: linear-gradient(135deg, #667eea, #764ba2); border: none; transition: all 0.3s ease; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
        .card { border-radius: 1rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: none; }
        .form-control, .form-select { border-radius: 0.5rem; border: 2px solid #e2e8f0; transition: border-color 0.3s ease; }
        .form-control:focus, .form-select:focus { border-color: #667eea; box-shadow: 0 0 0 0.2rem rgba(102,126,234,0.25); }
        .rating-stars-input .stars { font-size: 1.5rem; color: #fbbf24; cursor: pointer; }
        .rating-stars-input .stars i { margin-right: 0.25rem; transition: color 0.3s ease; }
        .rating-stars-input .stars i:hover, .rating-stars-input .stars i.active { color: #fbbf24; }
        .rating-stars-input .stars i.far { color: #e2e8f0; }
        .rating-text { font-size: 0.875rem; color: #6b7280; font-weight: 500; }
    </style>
</head>
<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="HomeServlet">CarRent</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="HomeServlet">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="<c:choose><c:when test="${sessionScope.role == 'admin'}">AdminServlet</c:when><c:otherwise>HomeServlet?page=customer-dashboard</c:otherwise></c:choose>"><c:choose><c:when test="${sessionScope.role == 'admin'}">Admin Panel</c:when><c:otherwise>Dashboard</c:otherwise></c:choose></a></li>
                <li class="nav-item"><a class="nav-link" href="HomeServlet?page=customer-vehicles">Vehicles</a></li>
                <li class="nav-item"><a class="nav-link" href="HomeServlet?page=customer-booking">My Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="HomeServlet?page=customer-promotions">Promotions</a></li>
                <li class="nav-item"><a class="nav-link active" href="HomeServlet?page=customer-feedback">Feedback</a></li>
                <c:if test="${not empty sessionScope.username}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Welcome, ${sessionScope.userFullName}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><span class="dropdown-item-text text-muted">Role: ${sessionScope.role}</span></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="AuthController?action=logout">Logout</a></li>
                        </ul>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<!-- Header -->
<div class="container mt-4">
    <div class="row align-items-center mb-4">
        <div class="col">
            <h1 class="display-6 mb-0">Share Your Feedback</h1>
            <p class="text-muted">Help us improve by sharing your experience with our services</p>
        </div>
    </div>
</div>

<!-- Check if user is logged in -->
<c:choose>
    <c:when test="${empty sessionScope.username}">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body text-center">
                            <h5 class="card-title">Login Required</h5>
                            <p class="card-text">You need to be logged in to submit feedback.</p>
                            <a href="cargo-landing.jsp" class="btn btn-primary">Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </body>
        </html>
    </c:when>
    <c:otherwise>

<div class="container">
    <div class="row g-4">
        <!-- Submit Feedback -->
        <div class="col-lg-8">
            <div class="card">
                <div class="card-header">
                    <h5 class="mb-0"><i class="fas fa-comment-dots me-2"></i>Submit New Feedback</h5>
                </div>
                <div class="card-body">
                    <form action="FeedbackController" method="post">
                        <div class="mb-3">
                            <label class="form-label">Related Booking (Optional)</label>
                            <select class="form-select" name="bookingId">
                                <option value="">Select a booking...</option>
                                <c:forEach var="booking" items="${customerBookings}">
                                    <option value="${booking.bookingId}" ${param.bookingId == booking.bookingId ? 'selected' : ''}>Booking #${booking.bookingId} - ${booking.vehicleName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Your Rating</label>
                            <div class="rating-stars-input mb-2">
                                <input type="hidden" name="rating" id="ratingValue" required>
                                <div class="stars">
                                    <i class="far fa-star" data-rating="1"></i>
                                    <i class="far fa-star" data-rating="2"></i>
                                    <i class="far fa-star" data-rating="3"></i>
                                    <i class="far fa-star" data-rating="4"></i>
                                    <i class="far fa-star" data-rating="5"></i>
                                </div>
                                <div class="rating-text mt-2" id="ratingText">Click to rate</div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Your Feedback</label>
                            <textarea class="form-control" name="comments" rows="5" placeholder="Please share your experience, suggestions, or any issues you encountered..." required></textarea>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Submit Feedback</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Feedback Stats -->
        <div class="col-lg-4">
            <div class="card mb-4">
                <div class="card-header">
                    <h6 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Your Feedback Summary</h6>
                </div>
                <div class="card-body text-center">
                    <div class="display-4 text-primary mb-2">${customerFeedbackCount != null ? customerFeedbackCount : 0}</div>
                    <p class="text-muted mb-0">Total Feedback Submitted</p>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h6 class="mb-0"><i class="fas fa-star-half-alt me-2"></i>Average Rating</h6>
                </div>
                <div class="card-body text-center">
                    <div class="rating-stars mb-2">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= (customerAvgRating != null ? customerAvgRating : 0)}">
                                    ⭐
                                </c:when>
                                <c:otherwise>
                                    ☆
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <p class="text-muted mb-0">${customerAvgRating != null ? String.format("%.1f", customerAvgRating) : "0.0"} / 5.0</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Previous Feedback -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="fas fa-history me-2"></i>Your Previous Feedback</h5>
                    <span class="badge bg-primary">${customerFeedbackCount != null ? customerFeedbackCount : 0} Feedback</span>
                </div>
                <div class="card-body">
                    <c:if test="${empty customerFeedbackList}">
                        <div class="text-center py-5">
                            <h6 class="text-muted mb-3">No Feedback Submitted Yet</h6>
                            <p class="text-muted">Your feedback history will appear here once you submit your first review.</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty customerFeedbackList}">
                        <div class="row g-3">
                            <c:forEach var="feedback" items="${customerFeedbackList}">
                                <div class="col-md-6">
                                    <div class="card feedback-card h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-start mb-2">
                                                <div class="rating-stars">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <c:choose>
                                                            <c:when test="${i <= feedback.rating}">
                                                                ⭐
                                                            </c:when>
                                                            <c:otherwise>
                                                                ☆
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </div>
                                                <small class="text-muted">${feedback.dateSubmitted}</small>
                                            </div>
                                            <c:if test="${not empty feedback.bookingId}">
                                                <p class="text-muted small mb-2">Booking #${feedback.bookingId}</p>
                                            </c:if>
                                            <p class="card-text">${feedback.comments}</p>
                                            <c:if test="${not empty feedback.adminResponse}">
                                                <div class="mt-3 p-3 bg-light rounded">
                                                    <small class="text-muted fw-semibold">Admin Response:</small>
                                                    <p class="mb-0 mt-1">${feedback.adminResponse}</p>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Success/Error Messages -->
<c:if test="${param.feedback == '1'}">
    <div class="position-fixed top-0 end-0 p-3" style="z-index: 1100">
        <div class="toast show" role="alert">
            <div class="toast-header">
                <strong class="me-auto text-success">Success!</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body">
                Thank you for your feedback! We appreciate your input.
            </div>
        </div>
    </div>
</c:if>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Interactive star rating
            document.addEventListener('DOMContentLoaded', function() {
                const stars = document.querySelectorAll('.rating-stars-input .stars i');
                const ratingInput = document.getElementById('ratingValue');
                const ratingText = document.getElementById('ratingText');
                const ratingTexts = ['', 'Poor', 'Fair', 'Good', 'Very Good', 'Excellent'];
    
                stars.forEach(star => {
                    star.addEventListener('click', function() {
                        const rating = parseInt(this.getAttribute('data-rating'));
                        ratingInput.value = rating;
                        ratingText.textContent = ratingTexts[rating];
    
                        // Update star display
                        stars.forEach((s, index) => {
                            if (index < rating) {
                                s.classList.remove('far');
                                s.classList.add('fas');
                            } else {
                                s.classList.remove('fas');
                                s.classList.add('far');
                            }
                        });
                    });
    
                    star.addEventListener('mouseover', function() {
                        const rating = parseInt(this.getAttribute('data-rating'));
                        stars.forEach((s, index) => {
                            if (index < rating) {
                                s.classList.remove('far');
                                s.classList.add('fas');
                            } else {
                                s.classList.remove('fas');
                                s.classList.add('far');
                            }
                        });
                    });
                });
    
                // Reset on mouse leave if no rating selected
                document.querySelector('.rating-stars-input .stars').addEventListener('mouseleave', function() {
                    const currentRating = parseInt(ratingInput.value) || 0;
                    stars.forEach((s, index) => {
                        if (index < currentRating) {
                            s.classList.remove('far');
                            s.classList.add('fas');
                        } else {
                            s.classList.remove('fas');
                            s.classList.add('far');
                        }
                    });
                });
            });
    
            // Show payment success alert when redirected from payment
            document.addEventListener('DOMContentLoaded', function() {
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('bookingId')) {
                    showAlert('Payment completed successfully! Please share your feedback below.', 'success');
                }
            });

            function showAlert(message, type) {
                const alertDiv = document.createElement('div');
                alertDiv.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
                alertDiv.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                alertDiv.innerHTML = `
                    <i class="fas fa-${type == 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                `;
                document.body.appendChild(alertDiv);

                // Auto remove after 5 seconds
                setTimeout(() => {
                    if (alertDiv.parentNode) {
                        alertDiv.remove();
                    }
                }, 5000);
            }

            // Auto-hide success message after 5 seconds
            setTimeout(function() {
                const toast = document.querySelector('.toast');
                if (toast) {
                    toast.classList.remove('show');
                }
            }, 5000);
        </script>
    </c:otherwise>
</c:choose>
</body>
</html>