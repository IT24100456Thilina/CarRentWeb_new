package com.example.carrentweb.Boundary;

import com.example.carrentweb.ControlSql.DBConnection;
import com.example.carrentweb.Strategy.PaymentContext;
import com.example.carrentweb.Strategy.PaymentStrategy;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/PaymentController")
public class PaymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("get".equals(action)) {
            getPayment(request, response);
        } else {
            doPost(request, response);
        }
    }

    private void getPayment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT paymentId, bookingId, amount, paymentMethod FROM Payments WHERE paymentId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(request.getParameter("id")));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String json = String.format(
                    "{\"paymentId\":%d,\"bookingId\":%d,\"amount\":%.2f,\"paymentMethod\":\"%s\"}",
                    rs.getInt("paymentId"),
                    rs.getInt("bookingId"),
                    rs.getDouble("amount"),
                    rs.getString("paymentMethod")
                );
                response.getWriter().write(json);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Payment not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "create";

        try (Connection conn = DBConnection.getConnection()) {
            switch (action) {
                case "create": {
                    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                    double originalAmount = Double.parseDouble(request.getParameter("amount"));
                    String paymentMethod = request.getParameter("paymentMethod");
                    String discountCode = request.getParameter("discountCode");

                    double finalAmount = originalAmount;

                    // Handle discount code if provided
                    if (discountCode != null && !discountCode.trim().isEmpty()) {
                        double discountAmount = validateAndCalculateDiscount(conn, discountCode, originalAmount);
                        if (discountAmount > 0) {
                            finalAmount = originalAmount - discountAmount;
                            // Ensure final amount is not negative
                            finalAmount = Math.max(finalAmount, 0.0);
                        } else {
                            // Invalid discount code - redirect with error
                            response.sendRedirect("HomeServlet?page=customer-payment&bookingId=" + bookingId + "&errorMsg=" + java.net.URLEncoder.encode("Invalid or expired discount code", java.nio.charset.StandardCharsets.UTF_8));
                            return;
                        }
                    }

                    // Use Strategy Pattern for payment processing
                    PaymentStrategy strategy = PaymentContext.createStrategy(paymentMethod);
                    if (strategy == null) {
                        response.sendRedirect("HomeServlet?page=customer-payment&bookingId=" + bookingId + "&errorMsg=" + java.net.URLEncoder.encode("Unsupported payment method", java.nio.charset.StandardCharsets.UTF_8));
                        return;
                    }

                    PaymentContext paymentContext = new PaymentContext(strategy);
                    boolean paymentSuccess = paymentContext.executePayment(finalAmount);

                    if (!paymentSuccess) {
                        response.sendRedirect("HomeServlet?page=customer-payment&bookingId=" + bookingId + "&errorMsg=" + java.net.URLEncoder.encode("Payment processing failed", java.nio.charset.StandardCharsets.UTF_8));
                        return;
                    }

                    String sql = "INSERT INTO Payments(bookingId, amount, paymentMethod, paymentDate, status, discountCode, originalAmount) VALUES (?, ?, ?, GETDATE(), 'Paid', ?, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
                    ps.setInt(1, bookingId);
                    ps.setDouble(2, finalAmount);
                    ps.setString(3, paymentMethod);
                    ps.setString(4, (discountCode != null && !discountCode.trim().isEmpty()) ? discountCode : null);
                    ps.setDouble(5, originalAmount);
                    ps.executeUpdate();

                    // Get the generated paymentId
                    int paymentId = 0;
                    ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) {
                        paymentId = rs.getInt(1);
                    }

                    // Update booking status to Confirmed
                    String updateSql = "UPDATE Bookings SET status = 'Confirmed' WHERE bookingId = ?";
                    PreparedStatement updatePs = conn.prepareStatement(updateSql);
                    updatePs.setInt(1, bookingId);
                    updatePs.executeUpdate();

                    response.sendRedirect("HomeServlet?page=customer-bill&bookingId=" + bookingId + "&success=1");
                    break;
                }
                case "update": {
                    int paymentId = Integer.parseInt(request.getParameter("paymentId"));
                    int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                    double amount = Double.parseDouble(request.getParameter("amount"));
                    String paymentMethod = request.getParameter("paymentMethod");

                    String sql = "UPDATE Payments SET bookingId=?, amount=?, paymentMethod=? WHERE paymentId=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, bookingId);
                    ps.setDouble(2, amount);
                    ps.setString(3, paymentMethod);
                    ps.setInt(4, paymentId);
                    ps.executeUpdate();

                    response.sendRedirect("admin-crud.jsp?paymentUpdated=1");
                    break;
                }
                case "cancel": {
                    // Customer cancel payment (only if booking is pending)
                    HttpSession session = request.getSession(false);
                    if (session == null || session.getAttribute("userId") == null) {
                        response.sendRedirect("HomeServlet?page=login&errorMsg=" + java.net.URLEncoder.encode("Please login to cancel payment", java.nio.charset.StandardCharsets.UTF_8));
                        return;
                    }
                    int sessionUserId = (Integer) session.getAttribute("userId");
                    int paymentId = Integer.parseInt(request.getParameter("paymentId"));

                    // Check ownership via booking
                    String checkSql = "SELECT p.status as paymentStatus, b.status as bookingStatus, b.userId FROM Payments p JOIN Bookings b ON p.bookingId = b.bookingId WHERE p.paymentId = ?";
                    PreparedStatement checkPs = conn.prepareStatement(checkSql);
                    checkPs.setInt(1, paymentId);
                    ResultSet checkRs = checkPs.executeQuery();
                    if (checkRs.next()) {
                        int bookingUserId = checkRs.getInt("userId");
                        String paymentStatus = checkRs.getString("paymentStatus");
                        String bookingStatus = checkRs.getString("bookingStatus");
                        if (bookingUserId != sessionUserId) {
                            response.sendRedirect("HomeServlet?page=customer-dashboard&errorMsg=" + java.net.URLEncoder.encode("You can only cancel your own payments", java.nio.charset.StandardCharsets.UTF_8));
                            return;
                        }
                        if (!"Pending".equals(bookingStatus)) {
                            response.sendRedirect("HomeServlet?page=customer-dashboard&errorMsg=" + java.net.URLEncoder.encode("Can only cancel payments for pending bookings", java.nio.charset.StandardCharsets.UTF_8));
                            return;
                        }

                        // Delete payment
                        String deleteSql = "DELETE FROM Payments WHERE paymentId = ?";
                        PreparedStatement deletePs = conn.prepareStatement(deleteSql);
                        deletePs.setInt(1, paymentId);
                        deletePs.executeUpdate();

                        response.sendRedirect("HomeServlet?page=customer-dashboard&successMsg=" + java.net.URLEncoder.encode("Payment cancelled successfully", java.nio.charset.StandardCharsets.UTF_8));
                    } else {
                        response.sendRedirect("HomeServlet?page=customer-dashboard&errorMsg=" + java.net.URLEncoder.encode("Payment not found", java.nio.charset.StandardCharsets.UTF_8));
                    }
                    break;
                }
                case "refund": {
                    // Customer request refund
                    HttpSession session = request.getSession(false);
                    if (session == null || session.getAttribute("userId") == null) {
                        response.sendRedirect("HomeServlet?page=login&errorMsg=" + java.net.URLEncoder.encode("Please login to request refund", java.nio.charset.StandardCharsets.UTF_8));
                        return;
                    }
                    int sessionUserId = (Integer) session.getAttribute("userId");
                    int paymentId = Integer.parseInt(request.getParameter("paymentId"));

                    // Check ownership via booking
                    String checkSql = "SELECT p.status as paymentStatus, b.status as bookingStatus, b.userId FROM Payments p JOIN Bookings b ON p.bookingId = b.bookingId WHERE p.paymentId = ?";
                    PreparedStatement checkPs = conn.prepareStatement(checkSql);
                    checkPs.setInt(1, paymentId);
                    ResultSet checkRs = checkPs.executeQuery();
                    if (checkRs.next()) {
                        int bookingUserId = checkRs.getInt("userId");
                        String paymentStatus = checkRs.getString("paymentStatus");
                        String bookingStatus = checkRs.getString("bookingStatus");
                        if (bookingUserId != sessionUserId) {
                            response.sendRedirect("HomeServlet?page=customer-dashboard&errorMsg=" + java.net.URLEncoder.encode("You can only refund your own payments", java.nio.charset.StandardCharsets.UTF_8));
                            return;
                        }
                        if (!"Paid".equals(paymentStatus)) {
                            response.sendRedirect("HomeServlet?page=customer-dashboard&errorMsg=" + java.net.URLEncoder.encode("Payment status must be Paid to refund", java.nio.charset.StandardCharsets.UTF_8));
                            return;
                        }

                        // Set payment status to Refunded
                        String refundSql = "UPDATE Payments SET status = 'Refunded' WHERE paymentId = ?";
                        PreparedStatement refundPs = conn.prepareStatement(refundSql);
                        refundPs.setInt(1, paymentId);
                        int rowsAffected = refundPs.executeUpdate();

                        if (rowsAffected > 0) {
                            // Send notification to Accountant and Customer Service Executive
                            sendRefundNotification(conn, paymentId);

                            response.sendRedirect("HomeServlet?page=customer-dashboard&successMsg=" + java.net.URLEncoder.encode("Refund requested successfully", java.nio.charset.StandardCharsets.UTF_8));
                        } else {
                            response.sendRedirect("HomeServlet?page=customer-dashboard&errorMsg=" + java.net.URLEncoder.encode("Failed to process refund", java.nio.charset.StandardCharsets.UTF_8));
                        }
                    } else {
                        response.sendRedirect("HomeServlet?page=customer-dashboard&errorMsg=" + java.net.URLEncoder.encode("Payment not found", java.nio.charset.StandardCharsets.UTF_8));
                    }
                    break;
                }
                case "delete": {
                    String idsParam = request.getParameter("ids");
                    if (idsParam != null && !idsParam.trim().isEmpty()) {
                        // Bulk delete
                        String[] idArray = idsParam.split(",");
                        String sql = "DELETE FROM Payments WHERE paymentId=?";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        for (String id : idArray) {
                            ps.setInt(1, Integer.parseInt(id.trim()));
                            ps.executeUpdate();
                        }
                    } else {
                        // Single delete
                        int paymentId = Integer.parseInt(request.getParameter("paymentId"));
                        String sql = "DELETE FROM Payments WHERE paymentId=?";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setInt(1, paymentId);
                        ps.executeUpdate();
                    }

                    response.sendRedirect("admin-crud.jsp?paymentDeleted=1");
                    break;
                }
                default:
                    response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode("Invalid action", java.nio.charset.StandardCharsets.UTF_8));
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    private void sendRefundNotification(Connection conn, int paymentId) {
        try {
            // Get refund details
            String sql = "SELECT p.amount, p.paymentMethod, b.bookingId, u.fullName as customerName, u.email as customerEmail " +
                         "FROM Payments p " +
                         "JOIN Bookings b ON p.bookingId = b.bookingId " +
                         "JOIN Users u ON b.userId = u.userId " +
                         "WHERE p.paymentId = ?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, paymentId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        double amount = rs.getDouble("amount");
                        String paymentMethod = rs.getString("paymentMethod");
                        int bookingId = rs.getInt("bookingId");
                        String customerName = rs.getString("customerName");
                        String customerEmail = rs.getString("customerEmail");

                        // Send notification to Accountant and Customer Service Executive
                        sendRefundNotificationEmail(paymentId, bookingId, amount, paymentMethod, customerName, customerEmail);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Failed to send refund notification for payment " + paymentId + ": " + e.getMessage());
        }
    }

    private void sendRefundNotificationEmail(int paymentId, int bookingId, double amount, String paymentMethod,
                                           String customerName, String customerEmail) throws MessagingException, Exception {
        try {
            // Load email configuration
            Properties emailProps = loadEmailProperties();

            String host = emailProps.getProperty("mail.smtp.host", "smtp.gmail.com");
            String port = emailProps.getProperty("mail.smtp.port", "587");
            String username = emailProps.getProperty("mail.username", "your-email@gmail.com");
            String password = emailProps.getProperty("mail.password", "your-app-password");
            String fromName = emailProps.getProperty("mail.from.name", "CarRent System");
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

            // Get list of staff emails for Accountant and Customer Service Executive
            try (Connection conn = DBConnection.getConnection()) {
                String staffSql = "SELECT email, fullName, position FROM Staff WHERE isActive = 1 AND position IN ('Accountant', 'Customer Service Executive')";
                try (PreparedStatement staffPs = conn.prepareStatement(staffSql);
                     ResultSet staffRs = staffPs.executeQuery()) {

                    while (staffRs.next()) {
                        String staffEmail = staffRs.getString("email");
                        String staffName = staffRs.getString("fullName");
                        String position = staffRs.getString("position");

                        // Create email message
                        Message message = new MimeMessage(session);
                        message.setFrom(new InternetAddress(fromAddress, fromName));
                        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(staffEmail));

                        String subject = "CarRent Refund Alert - Payment #" + paymentId;
                        message.setSubject(subject);

                        String emailBody = buildRefundNotificationBody(staffName, position, paymentId, bookingId,
                                                                     amount, paymentMethod, customerName, customerEmail);
                        message.setText(emailBody);

                        // Send email
                        Transport.send(message);

                        System.out.println("REFUND NOTIFICATION EMAIL SENT: " + position + " " + staffName +
                                         " notified about refund for payment " + paymentId);
                    }
                }
            }

        } catch (MessagingException e) {
            System.err.println("Failed to send refund notification email for payment " + paymentId +
                             " to staff: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            System.err.println("Error sending refund notification email: " + e.getMessage());
            throw e;
        }
    }

    private String buildRefundNotificationBody(String staffName, String position, int paymentId, int bookingId,
                                             double amount, String paymentMethod, String customerName, String customerEmail) {
        StringBuilder body = new StringBuilder();

        body.append("Dear ").append(staffName).append(",\n\n");

        body.append("A refund has been processed in the CarRent system.\n\n");
        body.append("Refund Details:\n");
        body.append("- Payment ID: ").append(paymentId).append("\n");
        body.append("- Booking ID: ").append(bookingId).append("\n");
        body.append("- Refund Amount: Rs").append(String.format("%.2f", amount)).append("\n");
        body.append("- Payment Method: ").append(paymentMethod).append("\n");
        body.append("- Customer Name: ").append(customerName).append("\n");
        body.append("- Customer Email: ").append(customerEmail).append("\n\n");

        if ("Accountant".equals(position)) {
            body.append("As the Accountant, please ensure the refund is properly recorded in the financial records ");
            body.append("and that the customer's account is credited accordingly.\n\n");
        } else if ("Customer Service Executive".equals(position)) {
            body.append("As the Customer Service Executive, please follow up with the customer to ensure ");
            body.append("they received the refund and address any concerns they may have.\n\n");
        }

        body.append("Thank you for your attention to this matter.\n\n");
        body.append("Best regards,\n");
        body.append("CarRent System\n\n");
        body.append("---\n");
        body.append("This is an automated notification for refund processing.\n");
        body.append("Please do not reply to this email.");

        return body.toString();
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
                props.setProperty("mail.from.name", "CarRent System");
                props.setProperty("mail.from.address", "your-email@gmail.com");
            }
        } catch (Exception e) {
            System.err.println("Error loading email properties: " + e.getMessage());
        }
        return props;
    }

    private double validateAndCalculateDiscount(Connection conn, String discountCode, double originalAmount) {
        try {
            String sql = "SELECT discountType, discountValue FROM Promotions WHERE discountCode = ? AND active = 1 AND (validTill IS NULL OR validTill >= GETDATE())";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, discountCode);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String discountType = rs.getString("discountType");
                double discountValue = rs.getDouble("discountValue");

                if ("percentage".equals(discountType)) {
                    return originalAmount * (discountValue / 100.0);
                } else if ("fixed".equals(discountType)) {
                    return Math.min(discountValue, originalAmount); // Don't exceed original amount
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0; // Invalid or no discount
    }
}
