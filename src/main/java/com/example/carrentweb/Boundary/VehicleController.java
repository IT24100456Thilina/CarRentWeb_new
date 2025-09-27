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

        // If URL is provided, use it directly
        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
            return imageUrl.trim();
        }

        // If file is uploaded, save it and return the URL
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            if (fileName != null && !fileName.isEmpty()) {
                // Generate unique filename to avoid conflicts
                String extension = fileName.substring(fileName.lastIndexOf("."));
                String uniqueFileName = UUID.randomUUID().toString() + extension;

                // Create upload directory if it doesn't exist
                Path uploadPath = Paths.get(request.getServletContext().getRealPath("/") + uploadDirectory);
                Files.createDirectories(uploadPath);

                // Save the file
                Path filePath = uploadPath.resolve(uniqueFileName);
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
                }

                // Return the relative URL to the uploaded file
                return request.getContextPath() + "/" + uploadDirectory + uniqueFileName;
            }
        }

        // Return default image if no image provided
        return "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400&h=300&fit=crop&crop=center";
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
                     break;
                 }
                case "update": {
                    // Handle image upload for updates
                    String imageUrl = handleFileUpload(request);

                    try {
                        String sql = "UPDATE Vehicles SET vehicleName=?, vehicleType=?, dailyPrice=?, available=?, imageUrl=? WHERE vehicleId=?";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setString(1, request.getParameter("vehicleName"));
                        ps.setString(2, request.getParameter("vehicleType"));
                        ps.setBigDecimal(3, new java.math.BigDecimal(request.getParameter("dailyPrice")));
                        ps.setBoolean(4, Boolean.parseBoolean(request.getParameter("available")));
                        ps.setString(5, imageUrl);
                        ps.setInt(6, Integer.parseInt(request.getParameter("vehicleId")));
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
                    break;
                }
            }
            response.sendRedirect("admin-crud.jsp?vehiclesUpdated=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }
}


