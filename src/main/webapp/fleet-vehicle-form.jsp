<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.action == 'edit' ? 'Edit' : 'Add'} Vehicle - Fleet Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title mb-0">
                            <i class="fas fa-car me-2"></i>
                            ${param.action == 'edit' ? 'Edit Vehicle Details' : 'Add New Vehicle'}
                        </h3>
                    </div>
                    <div class="card-body">
                        <% if (request.getAttribute("errorMsg") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <%= request.getAttribute("errorMsg") %>
                            </div>
                        <% } %>

                        <% if (request.getAttribute("successMsg") != null) { %>
                            <div class="alert alert-success" role="alert">
                                <i class="fas fa-check-circle me-2"></i>
                                <%= request.getAttribute("successMsg") %>
                            </div>
                        <% } %>

                        <form action="FleetSupervisorServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="${param.action == 'edit' ? 'update' : 'add'}">

                            <% if (request.getAttribute("vehicleId") != null) { %>
                                <input type="hidden" name="vehicleId" value="<%= request.getAttribute("vehicleId") %>">
                            <% } %>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="vehicleId" class="form-label">ID *</label>
                                    <input type="number" class="form-control" id="vehicleId" name="vehicleId" min="1"
                                           value="<%= request.getAttribute("vehicleId") != null ? request.getAttribute("vehicleId") : "" %>"
                                           ${param.action == 'edit' ? 'readonly' : 'required'}>
                                </div>
                                <div class="col-md-6">
                                    <label for="vehicleName" class="form-label">Model/Name *</label>
                                    <input type="text" class="form-control" id="vehicleName" name="vehicleName"
                                           value="<%= request.getAttribute("vehicleName") != null ? request.getAttribute("vehicleName") : "" %>"
                                           required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="registrationNumber" class="form-label">Registration Number *</label>
                                <input type="text" class="form-control" id="registrationNumber" name="registrationNumber"
                                       value="<%= request.getAttribute("registrationNumber") != null ? request.getAttribute("registrationNumber") : "" %>"
                                       required>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="vehicleType" class="form-label">Type *</label>
                                    <select class="form-select" id="vehicleType" name="vehicleType" required>
                                        <option value="">Select Type</option>
                                        <option value="Sedan" ${request.getAttribute("vehicleType") == "Sedan" ? "selected" : ""}>Sedan</option>
                                        <option value="SUV" ${request.getAttribute("vehicleType") == "SUV" ? "selected" : ""}>SUV</option>
                                        <option value="Luxury SUV" ${request.getAttribute("vehicleType") == "Luxury SUV" ? "selected" : ""}>Luxury SUV</option>
                                        <option value="Van" ${request.getAttribute("vehicleType") == "Van" ? "selected" : ""}>Van</option>
                                        <option value="Truck" ${request.getAttribute("vehicleType") == "Truck" ? "selected" : ""}>Truck</option>
                                        <option value="Hatchback" ${request.getAttribute("vehicleType") == "Hatchback" ? "selected" : ""}>Hatchback</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="dailyPrice" class="form-label">Price/Day ($) *</label>
                                    <input type="number" class="form-control" id="dailyPrice" name="dailyPrice" step="0.01" min="0"
                                           value="<%= request.getAttribute("dailyPrice") != null ? request.getAttribute("dailyPrice") : "" %>"
                                           required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Availability Status *</label>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="available" name="available" value="true"
                                           ${request.getAttribute("available") != null && request.getAttribute("available") ? "checked" : (param.action != 'edit' ? "checked" : "")}>
                                    <label class="form-check-label" for="available">
                                        Available
                                    </label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="unavailable" name="available" value="false"
                                           ${request.getAttribute("available") != null && !request.getAttribute("available") ? "checked" : ""}>
                                    <label class="form-check-label" for="unavailable">
                                        Unavailable
                                    </label>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Choose file or enter image URL</label>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="imageUrl" class="form-label">Image URL</label>
                                        <input type="url" class="form-control" id="imageUrl" name="imageUrl"
                                               value="<%= request.getAttribute("imageUrl") != null ? request.getAttribute("imageUrl") : "" %>"
                                               placeholder="https://example.com/image.jpg">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="vehicleImage" class="form-label">Choose file</label>
                                        <input type="file" class="form-control" id="vehicleImage" name="vehicleImage" accept="image/*">
                                    </div>
                                </div>
                                <% if (request.getAttribute("imageUrl") != null) { %>
                                    <div class="mt-2">
                                        <img src="<%= request.getAttribute("imageUrl") %>" alt="Current vehicle image" class="img-thumbnail" style="max-width: 200px;">
                                    </div>
                                <% } %>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="AdminServlet" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-tachometer-alt me-2"></i>Admin Dashboard
                                </a>
                                <a href="AuthController?action=logout" class="btn btn-outline-danger me-md-2">
                                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                                </a>
                                <a href="FleetSupervisorServlet?action=viewFleet" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Fleet Status
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>
                                    ${param.action == 'edit' ? 'Update Vehicle' : 'Add Vehicle'}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>