<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.example.carrentweb.ControlSql.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fleet Status - Car Rental Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/notifications.js"></script>
</head>
<body>
    <div class="container-fluid mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-car me-2"></i>Fleet Management Dashboard</h2>
            <div>
                <a href="AdminServlet" class="btn btn-secondary me-2">
                    <i class="fas fa-tachometer-alt me-2"></i>Admin Dashboard
                </a>
                <a href="AuthController?action=logout" class="btn btn-outline-danger me-2">
                    <i class="fas fa-sign-out-alt me-2"></i>Logout
                </a>
                <a href="FleetSupervisorServlet?action=add" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Add New Vehicle
                </a>
            </div>
        </div>

        <% if (request.getAttribute("successMsg") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                <%= request.getAttribute("successMsg") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            int totalVehicles = 0;
            int availableVehicles = 0;
            int rentedVehicles = 0;
            double totalValue = 0.0;

            try {
                conn = DBConnection.getConnection();

                // Get fleet statistics
                String statsSql = "SELECT " +
                    "COUNT(*) as total, " +
                    "SUM(CASE WHEN available = 1 THEN 1 ELSE 0 END) as available, " +
                    "SUM(CASE WHEN available = 0 THEN 1 ELSE 0 END) as rented, " +
                    "SUM(dailyPrice) as totalValue " +
                    "FROM Vehicles";
                ps = conn.prepareStatement(statsSql);
                rs = ps.executeQuery();
                if (rs.next()) {
                    totalVehicles = rs.getInt("total");
                    availableVehicles = rs.getInt("available");
                    rentedVehicles = rs.getInt("rented");
                    totalValue = rs.getDouble("totalValue");
                }
                rs.close();
                ps.close();
        %>

        <!-- Fleet Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-primary text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h5 class="card-title">Total Vehicles</h5>
                                <h3><%= totalVehicles %></h3>
                            </div>
                            <i class="fas fa-car fa-2x opacity-75"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-success text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h5 class="card-title">Available</h5>
                                <h3><%= availableVehicles %></h3>
                            </div>
                            <i class="fas fa-check-circle fa-2x opacity-75"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-warning text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h5 class="card-title">Rented Out</h5>
                                <h3><%= rentedVehicles %></h3>
                            </div>
                            <i class="fas fa-clock fa-2x opacity-75"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-info text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <div>
                                <h5 class="card-title">Fleet Value</h5>
                                <h3>$<%= String.format("%.0f", totalValue) %></h3>
                            </div>
                            <i class="fas fa-dollar-sign fa-2x opacity-75"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Vehicles Table -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">Vehicle Inventory</h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Image</th>
                                <th>Vehicle Details</th>
                                <th>Daily Rate</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String sql = "SELECT vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl FROM Vehicles ORDER BY vehicleId";
                                ps = conn.prepareStatement(sql);
                                rs = ps.executeQuery();

                                while (rs.next()) {
                                    int vehicleId = rs.getInt("vehicleId");
                                    String vehicleName = rs.getString("vehicleName");
                                    String vehicleType = rs.getString("vehicleType");
                                    double dailyPrice = rs.getDouble("dailyPrice");
                                    boolean available = rs.getBoolean("available");
                                    String imageUrl = rs.getString("imageUrl");
                            %>
                            <tr>
                                <td><%= vehicleId %></td>
                                <td>
                                    <% if (imageUrl != null && !imageUrl.isEmpty()) { %>
                                        <img src="<%= imageUrl %>" alt="<%= vehicleName %>" class="img-thumbnail" style="width: 60px; height: 45px; object-fit: cover;">
                                    <% } else { %>
                                        <div class="bg-light d-flex align-items-center justify-content-center" style="width: 60px; height: 45px;">
                                            <i class="fas fa-car text-muted"></i>
                                        </div>
                                    <% } %>
                                </td>
                                <td>
                                    <strong><%= vehicleName %></strong><br>
                                    <small class="text-muted"><%= vehicleType %></small>
                                </td>
                                <td>$<%= String.format("%.2f", dailyPrice) %></td>
                                <td>
                                    <% if (available) { %>
                                        <span class="badge bg-success">Available</span>
                                    <% } else { %>
                                        <span class="badge bg-danger">Rented</span>
                                    <% } %>
                                </td>
                                <td>
                                    <a href="FleetSupervisorServlet?action=edit&vehicleId=<%= vehicleId %>" class="btn btn-sm btn-outline-primary me-1">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <button class="btn btn-sm btn-outline-info me-1" onclick="viewDetails(<%= vehicleId %>)">
                                        <i class="fas fa-eye"></i> Details
                                    </button>
                                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="deleteVehicle(<%= vehicleId %>)">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <div class="alert alert-danger" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>
            Error loading fleet data: <%= e.getMessage() %>
        </div>
        <%
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { }
                if (ps != null) try { ps.close(); } catch (SQLException e) { }
                if (conn != null) try { conn.close(); } catch (SQLException e) { }
            }
        %>
    </div>

    <!-- Vehicle Details Modal -->
    <div class="modal fade" id="vehicleDetailsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Vehicle Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="vehicleDetailsContent">
                    <!-- Content will be loaded here -->
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function viewDetails(vehicleId) {
            // For now, redirect to edit page. Could be enhanced to show modal with details
            window.location.href = 'FleetSupervisorServlet?action=edit&vehicleId=' + vehicleId;
        }

        function deleteVehicle(vehicleId) {
            if (confirm('Are you sure you want to delete this vehicle? This action cannot be undone.')) {
                // Create a form and submit it
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = 'FleetSupervisorServlet';

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                form.appendChild(actionInput);

                var vehicleIdInput = document.createElement('input');
                vehicleIdInput.type = 'hidden';
                vehicleIdInput.name = 'vehicleId';
                vehicleIdInput.value = vehicleId;
                form.appendChild(vehicleIdInput);

                document.body.appendChild(form);
                form.submit();
            }
        }

        // Show success message popup if present
        <% if (request.getAttribute("successMsg") != null) { %>
            window.onload = function() {
                alert('<%= request.getAttribute("successMsg") %>');
            };
        <% } %>
    </script>
</body>
</html>