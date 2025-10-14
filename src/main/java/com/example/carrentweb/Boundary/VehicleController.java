package com.example.carrentweb.Boundary;

import com.example.carrentweb.ControlSql.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/VehicleController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class VehicleController extends HttpServlet {

    private String uploadDirectory = "uploads/vehicles/";

    private String handleFileUpload(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("vehicleImage");
        String imageUrl = request.getParameter("imageUrl");

        System.out.println("VehicleController: handleFileUpload called");
        System.out.println("VehicleController: imageUrl parameter: " + imageUrl);
        System.out.println("VehicleController: filePart: " + (filePart != null ? filePart.getSubmittedFileName() : "null"));

        // If URL is provided, use it directly
        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
            System.out.println("VehicleController: Using provided URL: " + imageUrl.trim());
            return imageUrl.trim();
        }

        // If file is uploaded, save it and return the URL
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            System.out.println("VehicleController: File uploaded: " + fileName + ", size: " + filePart.getSize());
            if (fileName != null && !fileName.isEmpty()) {
                // Generate unique filename to avoid conflicts
                String extension = fileName.substring(fileName.lastIndexOf("."));
                String uniqueFileName = UUID.randomUUID().toString() + extension;

                // Create upload directory if it doesn't exist
                String uploadDirPath = request.getServletContext().getRealPath("/" + uploadDirectory);
                System.out.println("VehicleController: Upload directory path: " + uploadDirPath);
                if (uploadDirPath == null) {
                    throw new IOException("Cannot determine upload directory path");
                }
                Path uploadPath = Paths.get(uploadDirPath);
                Files.createDirectories(uploadPath);
                System.out.println("VehicleController: Upload directory created: " + uploadPath);

                // Save the file
                Path filePath = uploadPath.resolve(uniqueFileName);
                filePart.write(filePath.toString());
                System.out.println("VehicleController: File saved to: " + filePath);

                // Return the URL to access the uploaded file via ImageServlet
                String url = request.getContextPath() + "/images/" + uniqueFileName;
                System.out.println("VehicleController: Returning URL: " + url);
                return url;
            }
        }

        // Return default image if no image provided
        System.out.println("VehicleController: No image provided, using default");
        return "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400&h=300&fit=crop&crop=center";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("get".equals(action)) {
            getVehicle(request, response);
        } else if ("search".equals(action)) {
            searchVehicles(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void getVehicle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl FROM Vehicles WHERE vehicleId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(request.getParameter("id")));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String json = String.format(
                    "{\"vehicleId\":%d,\"vehicleName\":\"%s\",\"vehicleType\":\"%s\",\"dailyPrice\":%.2f,\"available\":%b,\"imageUrl\":\"%s\"}",
                    rs.getInt("vehicleId"),
                    rs.getString("vehicleName").replace("\"", "\\\""),
                    rs.getString("vehicleType").replace("\"", "\\\""),
                    rs.getDouble("dailyPrice"),
                    rs.getBoolean("available"),
                    rs.getString("imageUrl") != null ? rs.getString("imageUrl").replace("\"", "\\\"") : ""
                );
                response.getWriter().write(json);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Vehicle not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private void searchVehicles(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        try (Connection conn = DBConnection.getConnection()) {
            String pickupDate = request.getParameter("pickupDate");
            String returnDate = request.getParameter("returnDate");
            String vehicleType = request.getParameter("vehicleType");

            StringBuilder sql = new StringBuilder(
                "SELECT vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl FROM Vehicles v WHERE v.available = 1"
            );

            List<Object> params = new ArrayList<>();

            if (pickupDate != null && !pickupDate.trim().isEmpty() && returnDate != null && !returnDate.trim().isEmpty()) {
                sql.append(" AND NOT EXISTS (SELECT 1 FROM Bookings b WHERE b.vehicleId = v.vehicleId AND b.status != 'Cancelled' AND b.startDate <= ? AND b.endDate >= ?)");
                params.add(java.sql.Date.valueOf(returnDate));
                params.add(java.sql.Date.valueOf(pickupDate));
            }

            if (vehicleType != null && !vehicleType.trim().isEmpty()) {
                sql.append(" AND v.vehicleType = ?");
                params.add(vehicleType);
            }

            PreparedStatement ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            StringBuilder json = new StringBuilder("[");
            boolean first = true;
            while (rs.next()) {
                if (!first) json.append(",");
                json.append(String.format(
                    "{\"vehicleId\":%d,\"vehicleName\":\"%s\",\"vehicleType\":\"%s\",\"dailyPrice\":%.2f,\"available\":%b,\"imageUrl\":\"%s\"}",
                    rs.getInt("vehicleId"),
                    rs.getString("vehicleName").replace("\"", "\\\""),
                    rs.getString("vehicleType").replace("\"", "\\\""),
                    rs.getDouble("dailyPrice"),
                    rs.getBoolean("available"),
                    rs.getString("imageUrl") != null ? rs.getString("imageUrl").replace("\"", "\\\"") : ""
                ));
                first = false;
            }
            json.append("]");
            response.getWriter().write(json.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "add";
        try (Connection conn = DBConnection.getConnection()) {
            switch (action) {
                case "add": {
                     // Check if vehicleId already exists
                     int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                     String checkSql = "SELECT COUNT(*) FROM Vehicles WHERE vehicleId = ?";
                     PreparedStatement checkPs = conn.prepareStatement(checkSql);
                     checkPs.setInt(1, vehicleId);
                     ResultSet rs = checkPs.executeQuery();
                     rs.next();
                     if (rs.getInt(1) > 0) {
                         response.sendRedirect("admin-crud.jsp?errorMsg=Vehicle ID already exists");
                         return;
                     }

                     // Handle image upload
                     String imageUrl = handleFileUpload(request);

                     String sql = "INSERT INTO Vehicles(vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl) VALUES (?, ?, ?, ?, ?, ?)";
                     PreparedStatement ps = conn.prepareStatement(sql);
                     ps.setInt(1, vehicleId);
                     ps.setString(2, request.getParameter("vehicleName"));
                     ps.setString(3, request.getParameter("vehicleType"));
                     ps.setBigDecimal(4, new java.math.BigDecimal(request.getParameter("dailyPrice")));
                     ps.setBoolean(5, Boolean.parseBoolean(request.getParameter("available")));
                     ps.setString(6, imageUrl);
                     ps.executeUpdate();

                     response.sendRedirect("admin-crud.jsp?vehicleAdded=1");
                     break;
                 }
                case "update": {
                    // Handle image upload for updates - only update if a new image is provided
                    String imageUrl = null;
                    Part filePart = request.getPart("vehicleImage");
                    String urlParam = request.getParameter("imageUrl");

                    if ((filePart != null && filePart.getSize() > 0) || (urlParam != null && !urlParam.trim().isEmpty())) {
                        // New image provided
                        imageUrl = handleFileUpload(request);
                    }
                    // If no new image, keep existing imageUrl

                    try {
                        String sql;
                        PreparedStatement ps;
                        if (imageUrl != null) {
                            // Update with new image
                            sql = "UPDATE Vehicles SET vehicleName=?, vehicleType=?, dailyPrice=?, available=?, imageUrl=? WHERE vehicleId=?";
                            ps = conn.prepareStatement(sql);
                            ps.setString(1, request.getParameter("vehicleName"));
                            ps.setString(2, request.getParameter("vehicleType"));
                            ps.setBigDecimal(3, new java.math.BigDecimal(request.getParameter("dailyPrice")));
                            ps.setBoolean(4, Boolean.parseBoolean(request.getParameter("available")));
                            ps.setString(5, imageUrl);
                            ps.setInt(6, Integer.parseInt(request.getParameter("vehicleId")));
                        } else {
                            // Update without changing image
                            sql = "UPDATE Vehicles SET vehicleName=?, vehicleType=?, dailyPrice=?, available=? WHERE vehicleId=?";
                            ps = conn.prepareStatement(sql);
                            ps.setString(1, request.getParameter("vehicleName"));
                            ps.setString(2, request.getParameter("vehicleType"));
                            ps.setBigDecimal(3, new java.math.BigDecimal(request.getParameter("dailyPrice")));
                            ps.setBoolean(4, Boolean.parseBoolean(request.getParameter("available")));
                            ps.setInt(5, Integer.parseInt(request.getParameter("vehicleId")));
                        }
                        ps.executeUpdate();
                    } catch (Exception e) {
                        String alt = "UPDATE Vehicles SET model=?, type=?, pricePerDay=?, status=? WHERE id=?";
                        PreparedStatement ps = conn.prepareStatement(alt);
                        ps.setString(1, request.getParameter("vehicleName"));
                        ps.setString(2, request.getParameter("vehicleType"));
                        ps.setBigDecimal(3, new java.math.BigDecimal(request.getParameter("dailyPrice")));
                        ps.setString(4, request.getParameter("available"));
                        ps.setInt(5, Integer.parseInt(request.getParameter("vehicleId")));
                        ps.executeUpdate();
                    }

                    response.sendRedirect("admin-crud.jsp?vehicleUpdated=1");
                    break;
                }
                case "delete": {
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

                    response.sendRedirect("admin-crud.jsp?vehicleDeleted=1");
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }
}


