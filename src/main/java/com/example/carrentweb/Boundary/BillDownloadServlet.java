package com.example.carrentweb.Boundary;

import com.example.carrentweb.ControlSql.DBConnection;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/BillDownloadServlet")
public class BillDownloadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingIdParam = request.getParameter("bookingId");
        if (bookingIdParam == null || bookingIdParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Booking ID is required");
            return;
        }

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userRole = (String) session.getAttribute("role");

        // For testing purposes, allow access if no user is logged in (temporarily)
        if (userId == null) {
            // Allow access for testing - find the booking owner
            try (Connection conn = DBConnection.getConnection()) {
                PreparedStatement ps = conn.prepareStatement("SELECT userId FROM Bookings WHERE bookingId = ?");
                ps.setInt(1, Integer.parseInt(bookingIdParam));
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    userId = rs.getInt("userId");
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bill not found");
                    return;
                }
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
                return;
            }
        } else if (!"customer".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized access");
            return;
        }

        try {
            int bookingId = Integer.parseInt(bookingIdParam);

            // Load bill data
            java.util.Map<String, Object> billData = loadBillData(userId, bookingId);
            if (billData == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Bill not found");
                return;
            }

            // Load user data
            java.util.Map<String, String> userData = loadUserData(userId);
            if (userData == null) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "User data not found");
                return;
            }

            // Set response headers for PDF download
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"bill_" + bookingId + ".pdf\"");

            // Generate PDF
            generateBillPDF(response, billData, userData);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid booking ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating bill");
        }
    }

    private java.util.Map<String, Object> loadBillData(int userId, int bookingId) {
        try (Connection conn = DBConnection.getConnection()) {
            // First try to load complete bill details (with payment)
            PreparedStatement ps = conn.prepareStatement(
                "SELECT b.bookingId, b.startDate, b.endDate, b.status as bookingStatus, " +
                "p.paymentId, p.amount, p.paymentMethod, p.status as paymentStatus, " +
                "v.vehicleName, v.dailyPrice, v.description as vehicleDescription, " +
                "DATEDIFF(day, b.startDate, b.endDate) + 1 as duration, " +
                "b.startDate as bookingDate, p.paymentDate as paymentDate " +
                "FROM Bookings b " +
                "JOIN Payments p ON b.bookingId = p.bookingId " +
                "JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                "WHERE b.bookingId = ? AND b.userId = ?"
            );
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                java.util.Map<String, Object> billData = new java.util.HashMap<>();
                billData.put("bookingId", rs.getInt("bookingId"));
                billData.put("paymentId", rs.getInt("paymentId"));
                billData.put("startDate", rs.getString("startDate"));
                billData.put("endDate", rs.getString("endDate"));
                billData.put("bookingStatus", rs.getString("bookingStatus"));
                billData.put("paymentStatus", rs.getString("paymentStatus"));
                billData.put("vehicleName", rs.getString("vehicleName"));
                billData.put("vehicleDescription", rs.getString("vehicleDescription"));
                billData.put("dailyRate", rs.getDouble("dailyPrice"));
                billData.put("duration", rs.getInt("duration"));
                billData.put("totalAmount", rs.getDouble("amount"));
                billData.put("paymentMethod", rs.getString("paymentMethod"));
                billData.put("bookingDate", rs.getString("bookingDate"));
                billData.put("paymentDate", rs.getString("paymentDate"));
                billData.put("isPreview", false);
                return billData;
            } else {
                // Payment doesn't exist - show booking preview
                PreparedStatement bookingPs = conn.prepareStatement(
                    "SELECT b.bookingId, b.startDate, b.endDate, b.status as bookingStatus, " +
                    "v.vehicleName, v.dailyPrice, v.description as vehicleDescription, " +
                    "DATEDIFF(day, b.startDate, b.endDate) + 1 as duration, " +
                    "b.startDate as bookingDate " +
                    "FROM Bookings b " +
                    "JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                    "WHERE b.bookingId = ? AND b.userId = ?"
                );
                bookingPs.setInt(1, bookingId);
                bookingPs.setInt(2, userId);
                ResultSet bookingRs = bookingPs.executeQuery();

                if (bookingRs.next()) {
                    java.util.Map<String, Object> billData = new java.util.HashMap<>();
                    billData.put("bookingId", bookingRs.getInt("bookingId"));
                    billData.put("startDate", bookingRs.getString("startDate"));
                    billData.put("endDate", bookingRs.getString("endDate"));
                    billData.put("bookingStatus", bookingRs.getString("bookingStatus"));
                    billData.put("vehicleName", bookingRs.getString("vehicleName"));
                    billData.put("vehicleDescription", bookingRs.getString("vehicleDescription"));
                    billData.put("dailyRate", bookingRs.getDouble("dailyPrice"));
                    billData.put("duration", bookingRs.getInt("duration"));
                    double totalAmount = bookingRs.getDouble("dailyPrice") * bookingRs.getInt("duration");
                    billData.put("totalAmount", totalAmount);
                    billData.put("bookingDate", bookingRs.getString("bookingDate"));
                    billData.put("isPreview", true);
                    return billData;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private java.util.Map<String, String> loadUserData(int userId) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT fullName, email, phone FROM Users WHERE userId = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                java.util.Map<String, String> userData = new java.util.HashMap<>();
                userData.put("fullName", rs.getString("fullName"));
                userData.put("email", rs.getString("email"));
                userData.put("phone", rs.getString("phone"));
                return userData;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private void generateBillPDF(HttpServletResponse response, java.util.Map<String, Object> billData,
                                java.util.Map<String, String> userData) throws IOException {

        // Create PDF writer
        PdfWriter writer = new PdfWriter(response.getOutputStream());
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf);

        // Add title
        Paragraph title = new Paragraph("CAR RENT BILL")
            .setFontSize(20)
            .setTextAlignment(TextAlignment.CENTER)
            .setMarginBottom(20);
        document.add(title);

        // Add company info
        Paragraph companyInfo = new Paragraph("CarRent - Your Trusted Car Rental Service")
            .setTextAlignment(TextAlignment.CENTER)
            .setMarginBottom(30);
        document.add(companyInfo);

        // Customer Information
        document.add(new Paragraph("CUSTOMER INFORMATION").setFontSize(14).setMarginBottom(10));
        Table customerTable = new Table(UnitValue.createPercentArray(new float[]{1, 2}));
        customerTable.setWidth(UnitValue.createPercentValue(100));

        customerTable.addCell(new Cell().add(new Paragraph("Name:")));
        customerTable.addCell(new Cell().add(new Paragraph(userData.get("fullName"))));

        customerTable.addCell(new Cell().add(new Paragraph("Email:")));
        customerTable.addCell(new Cell().add(new Paragraph(userData.get("email"))));

        customerTable.addCell(new Cell().add(new Paragraph("Phone:")));
        customerTable.addCell(new Cell().add(new Paragraph(userData.get("phone"))));

        document.add(customerTable);
        document.add(new Paragraph("\n"));

        // Booking Information
        document.add(new Paragraph("BOOKING INFORMATION").setFontSize(14).setMarginBottom(10));
        Table bookingTable = new Table(UnitValue.createPercentArray(new float[]{1, 2}));
        bookingTable.setWidth(UnitValue.createPercentValue(100));

        bookingTable.addCell(new Cell().add(new Paragraph("Booking ID:")));
        bookingTable.addCell(new Cell().add(new Paragraph("#" + billData.get("bookingId"))));

        if (!((Boolean) billData.get("isPreview"))) {
            bookingTable.addCell(new Cell().add(new Paragraph("Payment ID:")));
            bookingTable.addCell(new Cell().add(new Paragraph("#" + billData.get("paymentId"))));
        }

        bookingTable.addCell(new Cell().add(new Paragraph("Booking Date:")));
        bookingTable.addCell(new Cell().add(new Paragraph(billData.get("bookingDate").toString())));

        if (!((Boolean) billData.get("isPreview"))) {
            bookingTable.addCell(new Cell().add(new Paragraph("Payment Date:")));
            bookingTable.addCell(new Cell().add(new Paragraph(billData.get("paymentDate").toString())));
        }

        document.add(bookingTable);
        document.add(new Paragraph("\n"));

        // Vehicle Information
        document.add(new Paragraph("VEHICLE INFORMATION").setFontSize(14).setMarginBottom(10));
        Table vehicleTable = new Table(UnitValue.createPercentArray(new float[]{1, 2}));
        vehicleTable.setWidth(UnitValue.createPercentValue(100));

        vehicleTable.addCell(new Cell().add(new Paragraph("Vehicle:")));
        vehicleTable.addCell(new Cell().add(new Paragraph(billData.get("vehicleName").toString())));

        vehicleTable.addCell(new Cell().add(new Paragraph("Description:")));
        vehicleTable.addCell(new Cell().add(new Paragraph(billData.get("vehicleDescription").toString())));

        vehicleTable.addCell(new Cell().add(new Paragraph("Pickup Date:")));
        vehicleTable.addCell(new Cell().add(new Paragraph(billData.get("startDate").toString())));

        vehicleTable.addCell(new Cell().add(new Paragraph("Return Date:")));
        vehicleTable.addCell(new Cell().add(new Paragraph(billData.get("endDate").toString())));

        vehicleTable.addCell(new Cell().add(new Paragraph("Duration:")));
        vehicleTable.addCell(new Cell().add(new Paragraph(billData.get("duration") + " days")));

        document.add(vehicleTable);
        document.add(new Paragraph("\n"));

        // Payment Details
        document.add(new Paragraph("PAYMENT DETAILS").setFontSize(14).setMarginBottom(10));
        Table paymentTable = new Table(UnitValue.createPercentArray(new float[]{2, 1}));
        paymentTable.setWidth(UnitValue.createPercentValue(100));

        paymentTable.addCell(new Cell().add(new Paragraph("Daily Rate:")));
        paymentTable.addCell(new Cell().add(new Paragraph("Rs" + billData.get("dailyRate"))));

        paymentTable.addCell(new Cell().add(new Paragraph("Duration:")));
        paymentTable.addCell(new Cell().add(new Paragraph(billData.get("duration") + " days")));

        if (!((Boolean) billData.get("isPreview"))) {
            paymentTable.addCell(new Cell().add(new Paragraph("Payment Method:")));
            paymentTable.addCell(new Cell().add(new Paragraph(billData.get("paymentMethod").toString())));
        }

        paymentTable.addCell(new Cell().add(new Paragraph("Total Amount:").setFontSize(12)));
        paymentTable.addCell(new Cell().add(new Paragraph("Rs" + billData.get("totalAmount")).setFontSize(12)));

        document.add(paymentTable);
        document.add(new Paragraph("\n"));

        // Status
        if ((Boolean) billData.get("isPreview")) {
            document.add(new Paragraph("STATUS: PAYMENT PENDING")
                .setTextAlignment(TextAlignment.CENTER)
                .setFontSize(14));
        } else {
            document.add(new Paragraph("STATUS: PAYMENT COMPLETED")
                .setTextAlignment(TextAlignment.CENTER)
                .setFontSize(14));
        }

        // Footer
        document.add(new Paragraph("\n\nThank you for choosing CarRent!")
            .setTextAlignment(TextAlignment.CENTER));

        String currentDateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        document.add(new Paragraph("Generated on: " + currentDateTime)
            .setTextAlignment(TextAlignment.CENTER)
            .setFontSize(8));

        document.close();
    }
}