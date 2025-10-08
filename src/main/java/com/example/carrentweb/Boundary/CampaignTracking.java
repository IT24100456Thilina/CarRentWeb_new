package com.example.carrentweb.Boundary;

import com.example.carrentweb.ControlSql.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.net.URLDecoder;

@WebServlet("/CampaignTracking")
public class CampaignTracking extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String campaignIdStr = request.getParameter("cid");
        String email = request.getParameter("email");

        if (action == null || campaignIdStr == null || email == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
            return;
        }

        try {
            int campaignId = Integer.parseInt(campaignIdStr);
            String decodedEmail = URLDecoder.decode(email, "UTF-8");

            if ("open".equals(action)) {
                handleOpenTracking(request, response, campaignId, decodedEmail);
            } else if ("click".equals(action)) {
                handleClickTracking(request, response, campaignId, decodedEmail);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }

        } catch (Exception e) {
            System.err.println("Error in campaign tracking: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Tracking error");
        }
    }

    private void handleOpenTracking(HttpServletRequest request, HttpServletResponse response,
                                   int campaignId, String email) throws Exception {

        // Get client information
        String userAgent = request.getHeader("User-Agent");
        String ipAddress = getClientIpAddress(request);

        // Insert open tracking record
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO CampaignOpens (campaignId, recipientEmail, userAgent, ipAddress) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, campaignId);
            ps.setString(2, email);
            ps.setString(3, userAgent);
            ps.setString(4, ipAddress);
            ps.executeUpdate();
        }

        // Return a 1x1 transparent pixel
        response.setContentType("image/png");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Create a minimal 1x1 transparent PNG
        byte[] transparentPixel = createTransparentPixel();
        response.getOutputStream().write(transparentPixel);
    }

    private void handleClickTracking(HttpServletRequest request, HttpServletResponse response,
                                    int campaignId, String email) throws Exception {

        String encodedUrl = request.getParameter("url");
        if (encodedUrl == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing URL parameter");
            return;
        }

        String originalUrl = URLDecoder.decode(encodedUrl, "UTF-8");

        // Get client information
        String userAgent = request.getHeader("User-Agent");
        String ipAddress = getClientIpAddress(request);

        // Insert click tracking record
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO CampaignClicks (campaignId, recipientEmail, linkUrl, userAgent, ipAddress) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, campaignId);
            ps.setString(2, email);
            ps.setString(3, originalUrl);
            ps.setString(4, userAgent);
            ps.setString(5, ipAddress);
            ps.executeUpdate();
        }

        // Redirect to the original URL
        response.sendRedirect(originalUrl);
    }

    private String getClientIpAddress(HttpServletRequest request) {
        String ipAddress = request.getHeader("X-Forwarded-For");
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ipAddress == null || ipAddress.isEmpty() || "unknown".equalsIgnoreCase(ipAddress)) {
            ipAddress = request.getRemoteAddr();
        }
        return ipAddress;
    }

    private byte[] createTransparentPixel() {
        // Minimal 1x1 transparent PNG (43 bytes)
        return new byte[] {
            (byte)0x89, (byte)0x50, (byte)0x4E, (byte)0x47, (byte)0x0D, (byte)0x0A, (byte)0x1A, (byte)0x0A,
            (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x0D, (byte)0x49, (byte)0x48, (byte)0x44, (byte)0x52,
            (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x01, (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x01,
            (byte)0x08, (byte)0x06, (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x1F, (byte)0x15, (byte)0xC4,
            (byte)0x89, (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x0B, (byte)0x49, (byte)0x44, (byte)0x41,
            (byte)0x54, (byte)0x78, (byte)0x9C, (byte)0x63, (byte)0x00, (byte)0x01, (byte)0x00, (byte)0x00,
            (byte)0x05, (byte)0x00, (byte)0x01, (byte)0x0D, (byte)0x0A, (byte)0x2D, (byte)0xB4, (byte)0x00,
            (byte)0x00, (byte)0x00, (byte)0x00, (byte)0x49, (byte)0x45, (byte)0x4E, (byte)0x44, (byte)0xAE,
            (byte)0x42, (byte)0x60, (byte)0x82
        };
    }
}