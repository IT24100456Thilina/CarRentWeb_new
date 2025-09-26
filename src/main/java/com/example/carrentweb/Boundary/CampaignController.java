package com.example.carrentweb.Boundary;

import com.example.carrentweb.Entity.Campaign;
import com.example.carrentweb.Entity.SendCampaign;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.io.InputStream;
import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/CampaignController")
public class CampaignController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Check admin access
        if (!isAdmin(request)) {
            response.sendRedirect("cargo-landing.jsp");
            return;
        }

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
                case "logs":
                    listCampaignLogs(request, response, conn);
                    break;
                case "customers":
                    listCustomerEmails(request, response, conn);
                    break;
                default:
                    listCampaigns(request, response, conn);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-campaigns.jsp?error=" + java.net.URLEncoder.encode("Database error: " + e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check admin access
        if (!isAdmin(request)) {
            response.sendRedirect("cargo-landing.jsp");
            return;
        }

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
            response.sendRedirect("admin-campaigns.jsp?error=" + java.net.URLEncoder.encode("Database error: " + e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
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
        request.getRequestDispatcher("admin-campaigns.jsp").forward(request, response);
    }

    private void listCampaignLogs(HttpServletRequest request, HttpServletResponse response, Connection conn)
            throws Exception {
        List<Map<String, Object>> campaignLogs = new ArrayList<>();
        String sql = "SELECT cl.*, c.subject as campaignSubject FROM CampaignLogs cl " +
                     "JOIN Campaigns c ON cl.campaignId = c.campaignId " +
                     "ORDER BY cl.sentDate DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> log = new HashMap<>();
            log.put("logId", rs.getInt("logId"));
            log.put("campaignId", rs.getInt("campaignId"));
            log.put("recipientEmail", rs.getString("recipientEmail"));
            log.put("status", rs.getString("status"));
            log.put("sentDate", rs.getString("sentDate"));
            log.put("errorMessage", rs.getString("errorMessage"));
            log.put("campaignSubject", rs.getString("campaignSubject"));
            campaignLogs.add(log);
        }

        request.setAttribute("campaignLogs", campaignLogs);
        request.getRequestDispatcher("admin-campaign-logs.jsp").forward(request, response);
    }

    private void listCustomerEmails(HttpServletRequest request, HttpServletResponse response, Connection conn)
            throws Exception {
        List<Map<String, Object>> customers = new ArrayList<>();

        // Get all customer emails (excluding admin users)
        String sql = "SELECT userId, fullName, email, phone, username FROM Users " +
                     "WHERE username NOT LIKE '%admin%' ORDER BY fullName";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> customer = new HashMap<>();
            customer.put("userId", rs.getInt("userId"));
            customer.put("fullName", rs.getString("fullName"));
            customer.put("email", rs.getString("email"));
            customer.put("phone", rs.getString("phone"));
            customer.put("username", rs.getString("username"));

            // Check if customer has active bookings
            String bookingSql = "SELECT COUNT(*) as bookingCount FROM Bookings WHERE userId = ? AND status IN ('Confirmed', 'Completed')";
            PreparedStatement bookingPs = conn.prepareStatement(bookingSql);
            bookingPs.setInt(1, rs.getInt("userId"));
            ResultSet bookingRs = bookingPs.executeQuery();
            if (bookingRs.next()) {
                customer.put("hasActiveBookings", bookingRs.getInt("bookingCount") > 0);
            }

            customers.add(customer);
        }

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("admin-customer-emails.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("admin-campaign-create.jsp");
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
            response.sendRedirect("admin-campaigns.jsp?error=Edit functionality not implemented in unified interface");
        } else {
            response.sendRedirect("admin-campaigns.jsp?error=Campaign not found");
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
            response.sendRedirect("admin-campaigns.jsp?success=Campaign created successfully");
        } else {
            response.sendRedirect("admin-campaigns.jsp?error=Failed to create campaign");
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
            response.sendRedirect("admin-campaigns.jsp?success=Campaign updated successfully");
        } else {
            response.sendRedirect("admin-campaigns.jsp?error=Failed to update campaign");
        }
    }

    private void deleteCampaign(HttpServletRequest request, HttpServletResponse response, Connection conn)
            throws Exception {
        int campaignId = Integer.parseInt(request.getParameter("campaignId"));

        // First delete related SendCampaign records
        String deleteSendCampaignSql = "DELETE FROM SendCampaign WHERE campaignId=?";
        PreparedStatement deleteSendPs = conn.prepareStatement(deleteSendCampaignSql);
        deleteSendPs.setInt(1, campaignId);
        deleteSendPs.executeUpdate();

        // Then delete related CampaignLogs
        String deleteLogsSql = "DELETE FROM CampaignLogs WHERE campaignId=?";
        PreparedStatement deleteLogsPs = conn.prepareStatement(deleteLogsSql);
        deleteLogsPs.setInt(1, campaignId);
        deleteLogsPs.executeUpdate();

        // Finally delete the campaign
        String sql = "DELETE FROM Campaigns WHERE campaignId=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, campaignId);

        int rows = ps.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("admin-campaigns.jsp?success=Campaign deleted successfully");
        } else {
            response.sendRedirect("admin-campaigns.jsp?error=Failed to delete campaign");
        }
    }

    private void sendEmails(HttpServletRequest request, HttpServletResponse response, Connection conn)
            throws Exception {
        int campaignId = Integer.parseInt(request.getParameter("campaignId"));
        HttpSession session = request.getSession(false);
        Integer adminId = (session != null) ? (Integer) session.getAttribute("userId") : null;

        if (adminId == null) {
            response.sendRedirect("cargo-landing.jsp");
            return;
        }

        // Get campaign details
        String campaignSql = "SELECT * FROM Campaigns WHERE campaignId = ?";
        PreparedStatement campaignPs = conn.prepareStatement(campaignSql);
        campaignPs.setInt(1, campaignId);
        ResultSet campaignRs = campaignPs.executeQuery();

        if (!campaignRs.next()) {
            response.sendRedirect("admin-campaigns.jsp?error=Campaign not found");
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
            response.sendRedirect("admin-campaigns.jsp?error=No recipients found for this segment");
            return;
        }

        // Create SendCampaign record
        SendCampaign sendCampaign = new SendCampaign(campaignId, recipients.size(), adminId);
        int sendId = createSendCampaign(sendCampaign, conn);

        // Update status to sending
        updateSendCampaignStatus(sendId, "sending", conn);

        // Try to send emails
        try {
            int sentCount = sendEmailsToRecipients(campaign, recipients, conn);

            // Update campaign status
            String updateSql = "UPDATE Campaigns SET status='sent', sentDate=GETDATE(), sentCount=? WHERE campaignId=?";
            PreparedStatement updatePs = conn.prepareStatement(updateSql);
            updatePs.setInt(1, sentCount);
            updatePs.setInt(2, campaignId);
            updatePs.executeUpdate();

            // Update SendCampaign as completed
            updateSendCampaignCompletion(sendId, sentCount, recipients.size() - sentCount, null, conn);

            response.sendRedirect("admin-campaigns.jsp?success=Campaign sent successfully to " + sentCount + " recipients");
        } catch (MessagingException e) {
            // Log error and alert admin
            logEmailServerError(campaignId, "Email server error: " + e.getMessage(), conn);

            // Update SendCampaign as failed
            updateSendCampaignCompletion(sendId, 0, recipients.size(), e.getMessage(), conn);

            response.sendRedirect("admin-campaigns.jsp?error=Email server is currently unavailable. Admin has been notified.");
        }
    }

    private List<String> getRecipientsForSegment(String segment, Connection conn) throws Exception {
        List<String> recipients = new ArrayList<>();
        String sql = "";

        // Since the database doesn't have a role column, we'll exclude admin users by username
        // Admin users typically have 'admin' in their username
        switch (segment) {
            case "all":
                sql = "SELECT email FROM Users WHERE username NOT LIKE '%admin%'";
                break;
            case "active_customers":
                sql = "SELECT DISTINCT u.email FROM Users u JOIN Bookings b ON u.userId = b.userId WHERE u.username NOT LIKE '%admin%' AND b.status IN ('Confirmed', 'Completed')";
                break;
            case "new_customers":
                sql = "SELECT email FROM Users WHERE username NOT LIKE '%admin%' AND DATEDIFF(day, createdDate, GETDATE()) <= 30";
                break;
            default:
                sql = "SELECT email FROM Users WHERE username NOT LIKE '%admin%'";
        }

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            recipients.add(rs.getString("email"));
        }

        return recipients;
    }

    private int sendEmailsToRecipients(Campaign campaign, List<String> recipients, Connection conn) throws MessagingException, Exception {
        int sentCount = 0;

        // Load email configuration from properties file
        Properties emailProps = loadEmailProperties();

        String host = emailProps.getProperty("mail.smtp.host", "smtp.gmail.com");
        String port = emailProps.getProperty("mail.smtp.port", "587");
        String username = emailProps.getProperty("mail.username", "your-email@gmail.com");
        String password = emailProps.getProperty("mail.password", "your-app-password");
        String fromName = emailProps.getProperty("mail.from.name", "CarRent Admin");
        String fromAddress = emailProps.getProperty("mail.from.address", username);

        Properties props = new Properties();
        props.put("mail.smtp.auth", emailProps.getProperty("mail.smtp.auth", "true"));
        props.put("mail.smtp.starttls.enable", emailProps.getProperty("mail.smtp.starttls.enable", "true"));
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        props.put("mail.smtp.ssl.trust", emailProps.getProperty("mail.smtp.ssl.trust", host));

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        for (String email : recipients) {
            try {
                // Create email message
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(username, "CarRent Admin"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                message.setSubject(campaign.getSubject());

                // Build email body
                String emailBody = buildEmailBody(campaign, email);
                message.setText(emailBody);

                // Send email
                Transport.send(message);

                // Log success
                logEmailResult(campaign.getCampaignId(), email, "sent", null, conn);
                sentCount++;

            } catch (MessagingException e) {
                // Log failure
                logEmailResult(campaign.getCampaignId(), email, "failed", e.getMessage(), conn);
                System.err.println("Failed to send email to " + email + ": " + e.getMessage());
            }
        }

        return sentCount;
    }

    private String buildEmailBody(Campaign campaign, String recipientEmail) {
        Properties emailProps = loadEmailProperties();
        String fromName = emailProps.getProperty("mail.from.name", "CarRent Admin");
        String footerText = emailProps.getProperty("mail.footer.text",
            "Best regards,\nCarRent Team\n\n---\nThis email was sent to: {recipient}\nIf you no longer wish to receive promotional emails, please contact us.");

        StringBuilder body = new StringBuilder();

        // Add greeting
        body.append("Dear Customer,\n\n");

        // Add campaign body
        body.append(campaign.getBody()).append("\n\n");

        // Add special offer if present
        if (campaign.getOffer() != null && !campaign.getOffer().trim().isEmpty()) {
            body.append("Special Offer: ").append(campaign.getOffer()).append("\n\n");
        }

        // Add footer
        body.append(footerText.replace("{recipient}", recipientEmail));

        return body.toString();
    }

    private void logEmailResult(int campaignId, String email, String status, String errorMessage, Connection conn) throws Exception {
        String logSql = "INSERT INTO CampaignLogs (campaignId, recipientEmail, status, errorMessage) VALUES (?, ?, ?, ?)";
        PreparedStatement logPs = conn.prepareStatement(logSql);
        logPs.setInt(1, campaignId);
        logPs.setString(2, email);
        logPs.setString(3, status);
        logPs.setString(4, errorMessage);
        logPs.executeUpdate();
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

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;

        String role = (String) session.getAttribute("role");
        return "admin".equals(role);
    }

    private boolean hasRoleColumn(Connection conn) {
        try {
            java.sql.DatabaseMetaData metaData = conn.getMetaData();
            try (java.sql.ResultSet columns = metaData.getColumns(null, null, "Users", "role")) {
                return columns.next();
            }
        } catch (Exception e) {
            return false;
        }
    }

    private Properties loadEmailProperties() {
        Properties props = new Properties();
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("email.properties")) {
            if (input != null) {
                props.load(input);
            } else {
                // Fallback to default values if properties file not found
                System.err.println("Warning: email.properties not found, using default email configuration");
                props.setProperty("mail.smtp.host", "smtp.gmail.com");
                props.setProperty("mail.smtp.port", "587");
                props.setProperty("mail.smtp.auth", "true");
                props.setProperty("mail.smtp.starttls.enable", "true");
                props.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");
                props.setProperty("mail.username", "your-email@gmail.com");
                props.setProperty("mail.password", "your-app-password");
                props.setProperty("mail.from.name", "CarRent Admin");
                props.setProperty("mail.from.address", "your-email@gmail.com");
            }
        } catch (Exception e) {
            System.err.println("Error loading email properties: " + e.getMessage());
            // Use fallback values
        }
        return props;
    }

    private int createSendCampaign(SendCampaign sendCampaign, Connection conn) throws Exception {
        String sql = "INSERT INTO SendCampaign (campaignId, status, totalRecipients, sentCount, failedCount, initiatedBy) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
        ps.setInt(1, sendCampaign.getCampaignId());
        ps.setString(2, sendCampaign.getStatus());
        ps.setInt(3, sendCampaign.getTotalRecipients());
        ps.setInt(4, sendCampaign.getSentCount());
        ps.setInt(5, sendCampaign.getFailedCount());
        ps.setInt(6, sendCampaign.getInitiatedBy());

        ps.executeUpdate();

        // Get the generated sendId
        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            return rs.getInt(1);
        }
        throw new Exception("Failed to create SendCampaign record");
    }

    private void updateSendCampaignStatus(int sendId, String status, Connection conn) throws Exception {
        String sql = "UPDATE SendCampaign SET status = ?, startedDate = GETDATE() WHERE sendId = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, sendId);
        ps.executeUpdate();
    }

    private void updateSendCampaignCompletion(int sendId, int sentCount, int failedCount, String errorMessage, Connection conn) throws Exception {
        String status = (errorMessage == null) ? "completed" : "failed";
        String sql = "UPDATE SendCampaign SET status = ?, sentCount = ?, failedCount = ?, errorMessage = ?, completedDate = GETDATE() WHERE sendId = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, sentCount);
        ps.setInt(3, failedCount);
        ps.setString(4, errorMessage);
        ps.setInt(5, sendId);
        ps.executeUpdate();
    }
}