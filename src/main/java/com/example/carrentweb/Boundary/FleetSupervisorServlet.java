package com.example.carrentweb.Boundary;

import com.example.carrentweb.ControlSql.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.UUID;

@WebServlet("/FleetSupervisorServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class FleetSupervisorServlet extends HttpServlet {

    private String uploadDirectory = "uploads/vehicles/";

    private String handleFileUpload(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("vehicleImage");
        String imageUrl = request.getParameter("imageUrl");

        System.out.println("FleetSupervisorServlet: handleFileUpload called");
        System.out.println("FleetSupervisorServlet: imageUrl parameter: " + imageUrl);
        System.out.println("FleetSupervisorServlet: filePart: " + (filePart != null ? filePart.getSubmittedFileName() : "null"));

        // If URL is provided, use it directly
        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
            System.out.println("FleetSupervisorServlet: Using provided URL: " + imageUrl.trim());
            return imageUrl.trim();
        }

        // If file is uploaded, save it and return the URL
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            System.out.println("FleetSupervisorServlet: File uploaded: " + fileName + ", size: " + filePart.getSize());
            if (fileName != null && !fileName.isEmpty()) {
                // Generate unique filename to avoid conflicts
                String extension = fileName.substring(fileName.lastIndexOf("."));
                String uniqueFileName = UUID.randomUUID().toString() + extension;

                // Create upload directory if it doesn't exist
                String uploadDirPath = request.getServletContext().getRealPath("/" + uploadDirectory);
                System.out.println("FleetSupervisorServlet: Upload directory path: " + uploadDirPath);
                if (uploadDirPath == null) {
                    throw new IOException("Cannot determine upload directory path");
                }
                Path uploadPath = Paths.get(uploadDirPath);
                Files.createDirectories(uploadPath);
                System.out.println("FleetSupervisorServlet: Upload directory created: " + uploadPath);

                // Save the file
                Path filePath = uploadPath.resolve(uniqueFileName);
                filePart.write(filePath.toString());
                System.out.println("FleetSupervisorServlet: File saved to: " + filePath);

                // Return the URL to access the uploaded file via ImageServlet
                String url = request.getContextPath() + "/images/" + uniqueFileName;
                System.out.println("FleetSupervisorServlet: Returning URL: " + url);
                return url;
            }
        }

        // Return default image if no image provided
        System.out.println("FleetSupervisorServlet: No image provided, using default");
        return "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400&h=300&fit=crop&crop=center";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in as Fleet Supervisor
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role")) ||
            !"Fleet Supervisor".equals(session.getAttribute("position"))) {
            response.sendRedirect(request.getContextPath() + "/cargo-landing.jsp?error=access_denied");
            return;
        }

        String action = request.getParameter("action");
        if ("viewFleet".equals(action)) {
            viewFleetStatus(request, response);
        } else if ("edit".equals(action)) {
            showEditForm(request, response);
        } else {
            showAddForm(request, response);
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/fleet-vehicle-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vehicleId = request.getParameter("vehicleId");
        if (vehicleId != null) {
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl, registrationNumber FROM Vehicles WHERE vehicleId = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(vehicleId));
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    request.setAttribute("vehicleId", rs.getInt("vehicleId"));
                    request.setAttribute("vehicleName", rs.getString("vehicleName"));
                    request.setAttribute("vehicleType", rs.getString("vehicleType"));
                    request.setAttribute("dailyPrice", rs.getDouble("dailyPrice"));
                    request.setAttribute("available", rs.getBoolean("available"));
                    request.setAttribute("imageUrl", rs.getString("imageUrl"));
                    request.setAttribute("registrationNumber", rs.getString("registrationNumber"));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("/fleet-vehicle-form.jsp").forward(request, response);
    }

    private void viewFleetStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // This will be implemented in the JSP
        request.getRequestDispatcher("/fleet-status.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in as Fleet Supervisor
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role")) ||
            !"Fleet Supervisor".equals(session.getAttribute("position"))) {
            response.sendRedirect(request.getContextPath() + "/cargo-landing.jsp?error=access_denied");
            return;
        }

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addVehicle(request, response);
        } else if ("update".equals(action)) {
            updateVehicle(request, response);
        } else if ("delete".equals(action)) {
            deleteVehicle(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void addVehicle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            // Validate input
            String vehicleIdStr = request.getParameter("vehicleId");
            String vehicleName = request.getParameter("vehicleName");
            String vehicleType = request.getParameter("vehicleType");
            String dailyPriceStr = request.getParameter("dailyPrice");
            String availableStr = request.getParameter("available");
            String registrationNumber = request.getParameter("registrationNumber");

            if (vehicleIdStr == null || vehicleIdStr.trim().isEmpty()) {
                request.setAttribute("errorMsg", "Vehicle ID is required");
                showAddForm(request, response);
                return;
            }
            if (vehicleName == null || vehicleName.trim().isEmpty()) {
                request.setAttribute("errorMsg", "Vehicle name is required");
                showAddForm(request, response);
                return;
            }
            if (vehicleType == null || vehicleType.trim().isEmpty()) {
                request.setAttribute("errorMsg", "Vehicle type is required");
                showAddForm(request, response);
                return;
            }
            if (dailyPriceStr == null || dailyPriceStr.trim().isEmpty()) {
                request.setAttribute("errorMsg", "Daily price is required");
                showAddForm(request, response);
                return;
            }

            int vehicleId = Integer.parseInt(vehicleIdStr);
            double dailyPrice = Double.parseDouble(dailyPriceStr);
            boolean available = "true".equals(availableStr);

            // Check if vehicleId already exists
            String checkSql = "SELECT COUNT(*) FROM Vehicles WHERE vehicleId = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, vehicleId);
            ResultSet rs = checkPs.executeQuery();
            rs.next();
            if (rs.getInt(1) > 0) {
                request.setAttribute("errorMsg", "Vehicle ID already exists");
                showAddForm(request, response);
                return;
            }

            String imageUrl = handleFileUpload(request);

            if (registrationNumber == null || registrationNumber.trim().isEmpty()) {
                registrationNumber = "REG-" + vehicleId;
            }

            String sql = "INSERT INTO Vehicles(vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl, registrationNumber) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, vehicleId);
            ps.setString(2, vehicleName.trim());
            ps.setString(3, vehicleType.trim());
            ps.setBigDecimal(4, new java.math.BigDecimal(dailyPrice));
            ps.setBoolean(5, available);
            ps.setString(6, imageUrl);
            ps.setString(7, registrationNumber);
            ps.executeUpdate();

            request.setAttribute("successMsg", "Vehicle added successfully");
            response.sendRedirect(request.getContextPath() + "/FleetSupervisorServlet?action=viewFleet");

        } catch (NumberFormatException e) {
            request.setAttribute("errorMsg", "Invalid number format");
            showAddForm(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            showAddForm(request, response);
        }
    }

    private void updateVehicle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            String vehicleIdStr = request.getParameter("vehicleId");
            if (vehicleIdStr == null || vehicleIdStr.trim().isEmpty()) {
                request.setAttribute("errorMsg", "Vehicle ID is required");
                showEditForm(request, response);
                return;
            }

            int vehicleId = Integer.parseInt(vehicleIdStr);

            // Validate input
            String vehicleName = request.getParameter("vehicleName");
            String vehicleType = request.getParameter("vehicleType");
            String dailyPriceStr = request.getParameter("dailyPrice");
            String availableStr = request.getParameter("available");
            String registrationNumber = request.getParameter("registrationNumber");

            if (vehicleName == null || vehicleName.trim().isEmpty()) {
                request.setAttribute("errorMsg", "Vehicle name is required");
                showEditForm(request, response);
                return;
            }
            if (vehicleType == null || vehicleType.trim().isEmpty()) {
                request.setAttribute("errorMsg", "Vehicle type is required");
                showEditForm(request, response);
                return;
            }
            if (dailyPriceStr == null || dailyPriceStr.trim().isEmpty()) {
                request.setAttribute("errorMsg", "Daily price is required");
                showEditForm(request, response);
                return;
            }

            double dailyPrice = Double.parseDouble(dailyPriceStr);
            boolean available = "true".equals(availableStr);

            // Handle image upload for updates
            String imageUrl = null;
            Part filePart = request.getPart("vehicleImage");
            String urlParam = request.getParameter("imageUrl");

            if ((filePart != null && filePart.getSize() > 0) || (urlParam != null && !urlParam.trim().isEmpty())) {
                // New image provided
                imageUrl = handleFileUpload(request);
            }

            String sql;
            PreparedStatement ps;
            if (imageUrl != null) {
                // Update with new image
                sql = "UPDATE Vehicles SET vehicleName=?, vehicleType=?, dailyPrice=?, available=?, imageUrl=?, registrationNumber=? WHERE vehicleId=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, vehicleName.trim());
                ps.setString(2, vehicleType.trim());
                ps.setBigDecimal(3, new java.math.BigDecimal(dailyPrice));
                ps.setBoolean(4, available);
                ps.setString(5, imageUrl);
                ps.setString(6, registrationNumber);
                ps.setInt(7, vehicleId);
            } else {
                // Update without changing image
                sql = "UPDATE Vehicles SET vehicleName=?, vehicleType=?, dailyPrice=?, available=?, registrationNumber=? WHERE vehicleId=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, vehicleName.trim());
                ps.setString(2, vehicleType.trim());
                ps.setBigDecimal(3, new java.math.BigDecimal(dailyPrice));
                ps.setBoolean(4, available);
                ps.setString(5, registrationNumber);
                ps.setInt(6, vehicleId);
            }
            ps.executeUpdate();

            request.setAttribute("successMsg", "Vehicle updated successfully");
            response.sendRedirect(request.getContextPath() + "/FleetSupervisorServlet?action=viewFleet");

        } catch (NumberFormatException e) {
            request.setAttribute("errorMsg", "Invalid number format");
            showEditForm(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            showEditForm(request, response);
        }
    }

    private void deleteVehicle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            String idsParam = request.getParameter("ids");
            if (idsParam != null && !idsParam.trim().isEmpty()) {
                // Bulk delete
                String[] idArray = idsParam.split(",");
                try {
                    String sql = "DELETE FROM Vehicles WHERE vehicleId=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    for (String id : idArray) {
                        ps.setInt(1, Integer.parseInt(id.trim()));
                        ps.executeUpdate();
                    }
                } catch (Exception e) {
                    String alt = "DELETE FROM Vehicles WHERE id=?";
                    PreparedStatement ps = conn.prepareStatement(alt);
                    for (String id : idArray) {
                        ps.setInt(1, Integer.parseInt(id.trim()));
                        ps.executeUpdate();
                    }
                }
            } else {
                // Single delete
                try {
                    String sql = "DELETE FROM Vehicles WHERE vehicleId=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(request.getParameter("vehicleId")));
                    ps.executeUpdate();
                } catch (Exception e) {
                    String alt = "DELETE FROM Vehicles WHERE id=?";
                    PreparedStatement ps = conn.prepareStatement(alt);
                    ps.setInt(1, Integer.parseInt(request.getParameter("vehicleId")));
                    ps.executeUpdate();
                }
            }

            request.setAttribute("successMsg", "Vehicle(s) deleted successfully");
            viewFleetStatus(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Database error: " + e.getMessage());
            viewFleetStatus(request, response);
        }
    }
}