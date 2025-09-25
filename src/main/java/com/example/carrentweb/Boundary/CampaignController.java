package com.example.carrentweb.Boundary;

import com.example.carrentweb.Entity.Campaign;
import com.example.carrentweb.ControlSql.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/CampaignController")
public class CampaignController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try (Connection conn = DBConnection.getConnection()) {
            switch (action) {
                case "list":
                    listCampaigns(request, response, conn);
                    break;
                case "create":
                    showCreateForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response, conn);
                    break;
                default:
                    listCampaigns(request, response, conn);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode("Database error: " + e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "create";

        try (Connection conn = DBConnection.getConnection()) {
            switch (action) {
                case "create":
                    createCampaign(request, response, conn);
                    break;
                case "update":
                    updateCampaign(request, response, conn);
                    break;
                case "delete":
                    deleteCampaign(request, response, conn);
                    break;
                case "send":
                    sendEmails(request, response, conn);
                    break;
                default:
                    response.sendRedirect("CampaignController?action=list");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode("Database error: " + e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    private void listCampaigns(HttpServletRequest request, HttpServletResponse response, Connection conn)
            throws Exception {
        List<Campaign> campaigns = new ArrayList<>();
        String sql = "SELECT * FROM Campaigns ORDER BY createdDate DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Campaign campaign = new Campaign();
            campaign.setCampaignId(rs.getInt("campaignId"));
            campaign.setSubject(rs.getString("subject"));
            campaign.setBody(rs.getString("body"));
            campaign.setOffer(rs.getString("offer"));
            campaign.setSegment(rs.getString("segment"));
            campaign.setStatus(rs.getString("status"));
            campaign.setCreatedDate(rs.getString("createdDate"));
            campaign.setSentDate(rs.getString("sentDate"));
            campaign.setSentCount(rs.getInt("sentCount"));
            campaign.setAdminId(rs.getInt("adminId"));
            campaigns.add(campaign);
        }

        request.setAttribute("campaigns", campaigns);
        request.getRequestDispatcher("admin-crud.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("admin-crud.jsp");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, Connection conn)
            throws Exception {
        int campaignId = Integer.parseInt(request.getParameter("id"));
        String sql = "SELECT * FROM Campaigns WHERE campaignId = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, campaignId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Campaign campaign = new Campaign();
            campaign.setCampaignId(rs.getInt("campaignId"));
            campaign.setSubject(rs.getString("subject"));
            campaign.setBody(rs.getString("body"));
            campaign.setOffer(rs.getString("offer"));
            campaign.setSegment(rs.getString("segment"));
            campaign.setStatus(rs.getString("status"));
            campaign.setCreatedDate(rs.getString("createdDate"));
            campaign.setSentDate(rs.getString("sentDate"));
            campaign.setSentCount(rs.getInt("sentCount"));
            campaign.setAdminId(rs.getInt("adminId"));

            request.setAttribute("campaign", campaign);
            response.sendRedirect("admin-crud.jsp?error=Edit functionality not implemented in unified interface");
        } else {
            response.sendRedirect("admin-crud.jsp?error=Campaign not found");
        }
    }

    private void createCampaign(HttpServletRequest request, HttpServletResponse response, Connection conn)
            throws Exception {
        HttpSession session = request.getSession(false);
        Integer adminId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (adminId == null) {
            response.sendRedirect("cargo-landing.jsp");
            return;
        }

        String subject = request.getParameter("subject");
        String body = request.getParameter("body");
        String offer = request.getParameter("offer");
        String segment = request.getParameter("segment");

        Campaign campaign = new Campaign(subject, body, offer, segment, adminId);

        String sql = "INSERT INTO Campaigns (subject, body, offer, segment, adminId) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, campaign.getSubject());
        ps.setString(2, campaign.getBody());
        ps.setString(3, campaign.getOffer());
        ps.setString(4, campaign.getSegment());
        ps.setInt(5, campaign.getAdminId());

        int rows = ps.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("admin-crud.jsp?success=Campaign created successfully");
        } else {
            response.sendRedirect("admin-crud.jsp?error=Failed to create campaign");
        }
    }

    private void updateCampaign(HttpServletRequest request, HttpServletResponse response, Connection conn)
            throws Exception {
        int campaignId = Integer.parseInt(request.getParameter("campaignId"));
        String subject = request.getParameter("subject");
        String body = request.getParameter("body");
        String offer = request.getParameter("offer");
        String segment = request.getParameter("segment");

        String sql = "UPDATE Campaigns SET subject=?, body=?, offer=?, segment=? WHERE campaignId=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, subject);
        ps.setString(2, body);
        ps.setString(3, offer);
        ps.setString(4, segment);
        ps.setInt(5, campaignId);

        int rows = ps.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("admin-crud.jsp?success=Campaign updated successfully");
        } else {
            response.sendRedirect("admin-crud.jsp?error=Failed to update campaign");
        }
    }

    private void deleteCampaign(HttpServletRequest request, HttpServletResponse response, Connection conn)
            throws Exception {
        int campaignId = Integer.parseInt(request.getParameter("campaignId"));

        String sql = "DELETE FROM Campaigns WHERE campaignId=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, campaignId);

        int rows = ps.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("admin-crud.jsp?success=Campaign deleted successfully");
        } else {
            response.sendRedirect("admin-crud.jsp?error=Failed to delete campaign");
        }
    }

    private void sendEmails(HttpServletRequest request, HttpServletResponse response, Connection conn)
            throws Exception {
        int campaignId = Integer.parseInt(request.getParameter("campaignId"));

        // Get campaign details
        String campaignSql = "SELECT * FROM Campaigns WHERE campaignId = ?";
        PreparedStatement campaignPs = conn.prepareStatement(campaignSql);
        campaignPs.setInt(1, campaignId);
        ResultSet campaignRs = campaignPs.executeQuery();

        if (!campaignRs.next()) {
            response.sendRedirect("admin-crud.jsp?error=Campaign not found");
            return;
        }

        Campaign campaign = new Campaign();
        campaign.setCampaignId(campaignRs.getInt("campaignId"));
        campaign.setSubject(campaignRs.getString("subject"));
        campaign.setBody(campaignRs.getString("body"));
        campaign.setOffer(campaignRs.getString("offer"));
        campaign.setSegment(campaignRs.getString("segment"));

        // Get recipient emails based on segment
        List<String> recipients = getRecipientsForSegment(campaign.getSegment(), conn);

        if (recipients.isEmpty()) {
            response.sendRedirect("admin-crud.jsp?error=No recipients found for this segment");
            return;
        }

        // Try to send emails (simulated for now)
        boolean emailServerRunning = simulateEmailServerCheck();
        int sentCount = 0;

        if (emailServerRunning) {
            // Simulate sending emails
            sentCount = sendEmailsToRecipients(campaign, recipients, conn);

            // Update campaign status
            String updateSql = "UPDATE Campaigns SET status='sent', sentDate=GETDATE(), sentCount=? WHERE campaignId=?";
            PreparedStatement updatePs = conn.prepareStatement(updateSql);
            updatePs.setInt(1, sentCount);
            updatePs.setInt(2, campaignId);
            updatePs.executeUpdate();

            response.sendRedirect("admin-crud.jsp?success=Campaign sent successfully to " + sentCount + " recipients");
        } else {
            // Log error and alert admin
            logEmailServerError(campaignId, "Email server is down", conn);
            response.sendRedirect("admin-crud.jsp?error=Email server is currently unavailable. Admin has been notified.");
        }
    }

    private List<String> getRecipientsForSegment(String segment, Connection conn) throws Exception {
        List<String> recipients = new ArrayList<>();
        String sql = "";

        switch (segment) {
            case "all":
                sql = "SELECT email FROM Users WHERE role = 'customer'";
                break;
            case "active_customers":
                sql = "SELECT DISTINCT u.email FROM Users u JOIN Bookings b ON u.userId = b.userId WHERE u.role = 'customer' AND b.status IN ('Confirmed', 'Completed')";
                break;
            case "new_customers":
                sql = "SELECT email FROM Users WHERE role = 'customer' AND DATEDIFF(day, (SELECT MIN(createdDate) FROM Users WHERE userId = Users.userId), GETDATE()) <= 30";
                break;
            default:
                sql = "SELECT email FROM Users WHERE role = 'customer'";
        }

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            recipients.add(rs.getString("email"));
        }

        return recipients;
    }

    private boolean simulateEmailServerCheck() {
        // Simulate email server availability (90% success rate)
        return Math.random() > 0.1;
    }

    private int sendEmailsToRecipients(Campaign campaign, List<String> recipients, Connection conn) throws Exception {
        int sentCount = 0;

        for (String email : recipients) {
            // Simulate sending email
            boolean sent = Math.random() > 0.05; // 95% success rate

            // Log the result
            String logSql = "INSERT INTO CampaignLogs (campaignId, recipientEmail, status, errorMessage) VALUES (?, ?, ?, ?)";
            PreparedStatement logPs = conn.prepareStatement(logSql);
            logPs.setInt(1, campaign.getCampaignId());
            logPs.setString(2, email);

            if (sent) {
                logPs.setString(3, "sent");
                logPs.setString(4, null);
                sentCount++;
            } else {
                logPs.setString(3, "failed");
                logPs.setString(4, "Simulated email sending failure");
            }

            logPs.executeUpdate();
        }

        return sentCount;
    }

    private void logEmailServerError(int campaignId, String errorMessage, Connection conn) throws Exception {
        // Update campaign status to failed
        String updateSql = "UPDATE Campaigns SET status='failed' WHERE campaignId=?";
        PreparedStatement updatePs = conn.prepareStatement(updateSql);
        updatePs.setInt(1, campaignId);
        updatePs.executeUpdate();

        // Log the error (could also send notification to admin)
        System.err.println("Email server error for campaign " + campaignId + ": " + errorMessage);
    }
}