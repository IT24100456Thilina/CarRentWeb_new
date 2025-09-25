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
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DBConnection.getConnection()) {
            // Vehicles (support both schemas)
            List<Map<String, Object>> cars = new ArrayList<>();
            try (PreparedStatement ps = conn.prepareStatement("SELECT vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl FROM Vehicles")) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> c = new HashMap<>();
                    c.put("vehicleId", rs.getInt("vehicleId"));
                    c.put("vehicleName", rs.getString("vehicleName"));
                    c.put("vehicleType", rs.getString("vehicleType"));
                    c.put("dailyPrice", rs.getDouble("dailyPrice"));
                    c.put("available", rs.getObject("available"));
                    c.put("imageUrl", rs.getString("imageUrl"));
                    cars.add(c);
                }
            } catch (Exception ignore) {
                try (PreparedStatement ps = conn.prepareStatement("SELECT id, model, type, pricePerDay, status FROM Vehicles")) {
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        Map<String, Object> c = new HashMap<>();
                        c.put("vehicleId", rs.getInt("id"));
                        c.put("vehicleName", rs.getString("model"));
                        c.put("vehicleType", rs.getString("type"));
                        c.put("dailyPrice", rs.getDouble("pricePerDay"));
                        c.put("available", rs.getObject("status"));
                        c.put("imageUrl", null);
                        cars.add(c);
                    }
                } catch (Exception ignore2) { }
            }
            request.setAttribute("carList", cars);

            // Bookings (schema does not include Vehicles table; use vehicleId directly)
            List<Map<String, Object>> bookings = new ArrayList<>();
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT b.bookingId, u.fullName AS customerName, b.vehicleId, b.startDate, b.endDate, b.status " +
                    "FROM Bookings b JOIN Users u ON b.userId = u.userId ORDER BY b.bookingId DESC")) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> b = new HashMap<>();
                    b.put("bookingId", rs.getInt("bookingId"));
                    b.put("customerName", rs.getString("customerName"));
                    int vehicleId = rs.getInt("vehicleId");
                    b.put("vehicleName", "Vehicle #" + vehicleId);
                    b.put("pickupDate", rs.getDate("startDate"));
                    b.put("returnDate", rs.getDate("endDate"));
                    b.put("status", rs.getString("status"));
                    bookings.add(b);
                }
            } catch (Exception ignore) { }
            request.setAttribute("bookingList", bookings);

            // Users
            List<Map<String, Object>> users = new ArrayList<>();
            try (PreparedStatement ps = conn.prepareStatement("SELECT userId, fullName, username, email FROM Users")) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> u = new HashMap<>();
                    u.put("userId", rs.getInt("userId"));
                    u.put("fullName", rs.getString("fullName"));
                    u.put("username", rs.getString("username"));
                    u.put("email", rs.getString("email"));
                    try { u.put("role", rs.getString("role")); } catch (Exception e) { u.put("role", ""); }
                    users.add(u);
                }
            } catch (Exception ignore) { }
            request.setAttribute("userList", users);

            // Promotions
            List<Map<String, Object>> promotions = new ArrayList<>();
            try (PreparedStatement ps = conn.prepareStatement("SELECT id, title, description, badge, validTill, active FROM Promotions ORDER BY id DESC")) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> p = new HashMap<>();
                    p.put("id", rs.getInt("id"));
                    p.put("title", rs.getString("title"));
                    p.put("description", rs.getString("description"));
                    p.put("badge", rs.getString("badge"));
                    p.put("validTill", rs.getString("validTill"));
                    p.put("active", rs.getBoolean("active"));
                    promotions.add(p);
                }
            } catch (Exception ignore) { }
            request.setAttribute("promotions", promotions);

            // Payments
            List<Map<String, Object>> payments = new ArrayList<>();
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT p.paymentId, p.bookingId, p.amount, p.paymentMethod, u.fullName AS customerName " +
                    "FROM Payments p JOIN Bookings b ON p.bookingId = b.bookingId " +
                    "JOIN Users u ON b.userId = u.userId ORDER BY p.paymentId DESC")) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> pay = new HashMap<>();
                    pay.put("paymentId", rs.getInt("paymentId"));
                    pay.put("bookingId", rs.getInt("bookingId"));
                    pay.put("amount", rs.getDouble("amount"));
                    pay.put("paymentMethod", rs.getString("paymentMethod"));
                    pay.put("customerName", rs.getString("customerName"));
                    payments.add(pay);
                }
            } catch (Exception ignore) { }
            request.setAttribute("paymentList", payments);

            // Feedbacks
            List<Map<String, Object>> feedbacks = new ArrayList<>();
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT f.feedbackId, f.bookingId, f.comments, f.rating, u.fullName AS customerName " +
                    "FROM Feedbacks f LEFT JOIN Bookings b ON f.bookingId = b.bookingId " +
                    "LEFT JOIN Users u ON b.userId = u.userId ORDER BY f.feedbackId DESC")) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> fb = new HashMap<>();
                    fb.put("feedbackId", rs.getInt("feedbackId"));
                    fb.put("bookingId", rs.getObject("bookingId"));
                    fb.put("comments", rs.getString("comments"));
                    fb.put("rating", rs.getInt("rating"));
                    fb.put("customerName", rs.getString("customerName"));
                    feedbacks.add(fb);
                }
            } catch (Exception ignore) { }
            request.setAttribute("feedbackList", feedbacks);

            // KPIs
            int totalBookings = 0; double revenue = 0; int utilization = 0;
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM Bookings")) {
                ResultSet rs = ps.executeQuery(); if (rs.next()) totalBookings = rs.getInt(1);
            } catch (Exception ignore) { }
            try (PreparedStatement ps = conn.prepareStatement("SELECT COALESCE(SUM(amount),0) FROM Payments")) {
                ResultSet rs = ps.executeQuery(); if (rs.next()) revenue = rs.getDouble(1);
            } catch (Exception ignore) { }
            // Dummy utilization: percent of available vehicles booked now
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM Vehicles");
                 PreparedStatement ps2 = conn.prepareStatement("SELECT COUNT(*) FROM Vehicles WHERE available = 0")) {
                ResultSet rs1 = ps.executeQuery(); int total = rs1.next()? rs1.getInt(1):0;
                ResultSet rs2 = ps2.executeQuery(); int unavailable = rs2.next()? rs2.getInt(1):0;
                if (total > 0) utilization = (int)Math.round((unavailable * 100.0) / total);
            } catch (Exception ignore) { }

            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("revenue", revenue);
            request.setAttribute("utilization", utilization);

            request.getRequestDispatcher("admin.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cargo-landing.jsp?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }
}


