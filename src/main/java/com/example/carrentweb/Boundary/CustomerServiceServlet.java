package com.example.carrentweb.Boundary;

import com.example.carrentweb.ControlSql.DBConnection;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.*;

@WebServlet("/CustomerServiceServlet")
public class CustomerServiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Basic session check - allow access even without login for now
        // Customer Service Executives will be redirected here after login

        try (Connection conn = DBConnection.getConnection()) {
            // Get pending and active bookings with customer, vehicle, and payment info
            List<Map<String, Object>> bookings = new ArrayList<>();
            String sql = "SELECT b.bookingId, b.startDate, b.endDate, b.status, " +
                        "u.fullName as customerName, u.email as customerEmail, u.phone as customerPhone, " +
                        "v.vehicleName, v.vehicleType, v.dailyPrice, v.available as vehicleAvailable, " +
                        "p.amount as paymentAmount, p.paymentMethod, p.paymentDate " +
                        "FROM Bookings b " +
                        "JOIN Users u ON b.userId = u.userId " +
                        "JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                        "LEFT JOIN Payments p ON b.bookingId = p.bookingId " +
                        "WHERE b.status IN ('Pending', 'Confirmed') " +
                        "ORDER BY b.bookingId DESC";

            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> booking = new HashMap<>();
                    booking.put("bookingId", rs.getInt("bookingId"));
                    booking.put("startDate", rs.getDate("startDate"));
                    booking.put("endDate", rs.getDate("endDate"));
                    booking.put("status", rs.getString("status"));
                    booking.put("customerName", rs.getString("customerName"));
                    booking.put("customerEmail", rs.getString("customerEmail"));
                    booking.put("customerPhone", rs.getString("customerPhone"));
                    booking.put("vehicleName", rs.getString("vehicleName"));
                    booking.put("vehicleType", rs.getString("vehicleType"));
                    booking.put("dailyPrice", rs.getDouble("dailyPrice"));
                    booking.put("vehicleAvailable", rs.getBoolean("vehicleAvailable"));
                    booking.put("paymentAmount", rs.getObject("paymentAmount"));
                    booking.put("paymentMethod", rs.getString("paymentMethod"));
                    booking.put("paymentDate", rs.getDate("paymentDate"));
                    bookings.add(booking);
                }
            }

            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("customer-service-dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cargo-landing.jsp?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Basic session check - allow access even without login for now
        // Customer Service Executives will be redirected here after login

        String action = request.getParameter("action");
        if ("approve".equals(action) || "cancel".equals(action)) {
            handleBookingAction(request, response, action);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void handleBookingAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String newStatus = "approve".equals(action) ? "Confirmed" : "Cancelled";

        try (Connection conn = DBConnection.getConnection()) {
            // First, get the current status before updating
            String previousStatus = null;
            String selectSql = "SELECT status FROM Bookings WHERE bookingId = ?";
            try (PreparedStatement ps = conn.prepareStatement(selectSql)) {
                ps.setInt(1, bookingId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        previousStatus = rs.getString("status");
                    } else {
                        response.sendRedirect("CustomerServiceServlet?error=booking_not_found");
                        return;
                    }
                }
            }

            // Update booking status
            String updateSql = "UPDATE Bookings SET status = ? WHERE bookingId = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                ps.setString(1, newStatus);
                ps.setInt(2, bookingId);
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    // Log the action to BookingActionLogs
                    logBookingAction(conn, bookingId, action, previousStatus, newStatus);

                    // Send notification (we'll implement this)
                    sendNotification(conn, bookingId, newStatus);

                    // If cancelling, we might want to make the vehicle available again
                    if ("Cancelled".equals(newStatus)) {
                        // Update vehicle availability if needed
                        // This logic depends on business rules
                    }

                    response.sendRedirect("CustomerServiceServlet?success=" +
                        ("Confirmed".equals(newStatus) ? "approved" : "cancelled"));
                } else {
                    response.sendRedirect("CustomerServiceServlet?error=booking_not_found");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CustomerServiceServlet?error=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    private void sendNotification(Connection conn, int bookingId, String status) {
        try {
            // Get booking and customer details
            String sql = "SELECT u.email, u.fullName, b.startDate, b.endDate, v.vehicleName " +
                        "FROM Bookings b " +
                        "JOIN Users u ON b.userId = u.userId " +
                        "JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                        "WHERE b.bookingId = ?";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, bookingId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String customerEmail = rs.getString("email");
                        String customerName = rs.getString("fullName");
                        String vehicleName = rs.getString("vehicleName");
                        String startDate = rs.getString("startDate");
                        String endDate = rs.getString("endDate");

                        // Send actual email notification
                        sendBookingNotificationEmail(customerEmail, customerName, bookingId,
                                                   vehicleName, startDate, endDate, status);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Log the error but don't fail the booking update
            System.err.println("Failed to send notification for booking " + bookingId + ": " + e.getMessage());
        }
    }

    private void sendBookingNotificationEmail(String customerEmail, String customerName, int bookingId,
                                            String vehicleName, String startDate, String endDate, String status)
            throws MessagingException, Exception {
        try {
            // Load email configuration
            Properties emailProps = loadEmailProperties();

            String host = emailProps.getProperty("mail.smtp.host", "smtp.gmail.com");
            String port = emailProps.getProperty("mail.smtp.port", "587");
            String username = emailProps.getProperty("mail.username", "your-email@gmail.com");
            String password = emailProps.getProperty("mail.password", "your-app-password");
            String fromName = emailProps.getProperty("mail.from.name", "CarRent Customer Service");
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

            // Create email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromAddress, fromName));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(customerEmail));

            String subject = "CarRent Booking " + status + " - Booking #" + bookingId;
            message.setSubject(subject);

            String emailBody = buildBookingNotificationBody(customerName, bookingId, vehicleName,
                                                          startDate, endDate, status);
            message.setText(emailBody);

            // Send email
            Transport.send(message);

            System.out.println("NOTIFICATION EMAIL SENT: Booking " + bookingId + " " + status.toLowerCase() +
                             " notification sent to " + customerEmail);

        } catch (MessagingException e) {
            System.err.println("Failed to send booking notification email to " + customerEmail +
                             " for booking " + bookingId + ": " + e.getMessage());
            throw e; // Re-throw to be caught by caller
        } catch (Exception e) {
            System.err.println("Error sending booking notification email: " + e.getMessage());
            throw e;
        }
    }

    private String buildBookingNotificationBody(String customerName, int bookingId, String vehicleName,
                                              String startDate, String endDate, String status) {
        StringBuilder body = new StringBuilder();

        body.append("Dear ").append(customerName).append(",\n\n");

        if ("Confirmed".equals(status)) {
            body.append("Great news! Your booking has been approved and confirmed.\n\n");
            body.append("Booking Details:\n");
            body.append("- Booking ID: ").append(bookingId).append("\n");
            body.append("- Vehicle: ").append(vehicleName).append("\n");
            body.append("- Pickup Date: ").append(startDate).append("\n");
            body.append("- Return Date: ").append(endDate).append("\n\n");
            body.append("Your vehicle will be ready for pickup at the scheduled date and time. ");
            body.append("Please bring a valid ID and your booking confirmation when you arrive.\n\n");
            body.append("If you have any questions, please contact our customer service team.\n\n");
        } else if ("Cancelled".equals(status)) {
            body.append("We regret to inform you that your booking has been cancelled.\n\n");
            body.append("Booking Details:\n");
            body.append("- Booking ID: ").append(bookingId).append("\n");
            body.append("- Vehicle: ").append(vehicleName).append("\n");
            body.append("- Requested Dates: ").append(startDate).append(" to ").append(endDate).append("\n\n");
            body.append("If you have any questions about this cancellation or would like to make a new booking, ");
            body.append("please contact our customer service team.\n\n");
        }

        body.append("Thank you for choosing CarRent!\n\n");
        body.append("Best regards,\n");
        body.append("CarRent Customer Service Team\n\n");
        body.append("---\n");
        body.append("This is an automated notification for booking #").append(bookingId).append("\n");
        body.append("Please do not reply to this email.");

        return body.toString();
    }

    private void logBookingAction(Connection conn, int bookingId, String action, String previousStatus, String newStatus) {
        String insertSql = "INSERT INTO BookingActionLogs (bookingId, action, previousStatus, newStatus, actionBy, actionDate, notes) " +
                          "VALUES (?, ?, ?, ?, ?, GETDATE(), ?)";

        try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
            ps.setInt(1, bookingId);
            ps.setString(2, action);
            ps.setString(3, previousStatus);
            ps.setString(4, newStatus);
            ps.setNull(5, java.sql.Types.INTEGER); // actionBy can be NULL for now
            ps.setString(6, "Booking " + action + " action performed");

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Booking action logged: Booking " + bookingId + " " + action + " from " + previousStatus + " to " + newStatus);
            } else {
                System.err.println("Failed to log booking action for booking " + bookingId);
            }
        } catch (Exception e) {
            System.err.println("Error logging booking action: " + e.getMessage());
            e.printStackTrace();
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
                props.setProperty("mail.from.name", "CarRent Customer Service");
                props.setProperty("mail.from.address", "your-email@gmail.com");
            }
        } catch (Exception e) {
            System.err.println("Error loading email properties: " + e.getMessage());
        }
        return props;
    }
}