package com.example.carrentweb.Boundary;

import com.example.carrentweb.Entity.Booking;
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
import java.sql.Date;

@WebServlet("/BookingController")
public class BookingController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "create";

        try (Connection conn = DBConnection.getConnection()) {
            if ("create".equalsIgnoreCase(action)) {
                HttpSession session = request.getSession(false);
                Integer sessionUserId = (session != null) ? (Integer) session.getAttribute("userId") : null;
                int userId = sessionUserId != null ? sessionUserId : Integer.parseInt(request.getParameter("userId"));
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                String pickup = request.getParameter("pickupDate") != null ? request.getParameter("pickupDate") : request.getParameter("startDate");
                String drop = request.getParameter("returnDate") != null ? request.getParameter("returnDate") : request.getParameter("endDate");
                Date startDate = Date.valueOf(pickup);
                Date endDate = Date.valueOf(drop);

                if (!startDate.before(endDate)) {
                    response.sendRedirect("cargo-landing.jsp?errorMsg=" + java.net.URLEncoder.encode("Start date must be before end date", java.nio.charset.StandardCharsets.UTF_8));
                    return;
                }

                Booking booking = new Booking(userId, vehicleId, startDate.toString(), endDate.toString(), "Pending");
                String sql = "INSERT INTO Bookings(userId, vehicleId, startDate, endDate, status) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
                ps.setInt(1, booking.getUserId());
                ps.setInt(2, booking.getVehicleId());
                ps.setDate(3, startDate);
                ps.setDate(4, endDate);
                ps.setString(5, booking.getStatus());
                int rows = ps.executeUpdate();
                if (rows > 0) {
                    ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) booking.setBookingId(rs.getInt(1));

                    // Calculate total cost
                    String priceSql = "SELECT dailyPrice FROM Vehicles WHERE vehicleId = ?";
                    PreparedStatement pricePs = conn.prepareStatement(priceSql);
                    pricePs.setInt(1, vehicleId);
                    ResultSet priceRs = pricePs.executeQuery();
                    double dailyPrice = 0;
                    if (priceRs.next()) {
                        dailyPrice = priceRs.getDouble("dailyPrice");
                    }

                    // Calculate number of days
                    long diffInMillies = Math.abs(endDate.getTime() - startDate.getTime());
                    long diff = java.util.concurrent.TimeUnit.DAYS.convert(diffInMillies, java.util.concurrent.TimeUnit.MILLISECONDS) + 1; // +1 to include both start and end dates
                    double totalCost = diff * dailyPrice;

                    // Redirect to payment page
                    response.sendRedirect("customer-payment.jsp?bookingId=" + booking.getBookingId() + "&amount=" + String.format("%.2f", totalCost));
                } else {
                    response.sendRedirect("cargo-landing.jsp?errorMsg=" + java.net.URLEncoder.encode("Booking failed", java.nio.charset.StandardCharsets.UTF_8));
                }
            } else if ("updateStatus".equalsIgnoreCase(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                String status = request.getParameter("status");
                String sql = "UPDATE Bookings SET status=? WHERE bookingId=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, status);
                ps.setInt(2, bookingId);
                ps.executeUpdate();
                response.sendRedirect("admin-crud.jsp?bookingUpdated=1");
            } else if ("update".equalsIgnoreCase(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                int userId = Integer.parseInt(request.getParameter("userId"));
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                String pickup = request.getParameter("pickupDate") != null ? request.getParameter("pickupDate") : request.getParameter("startDate");
                String drop = request.getParameter("returnDate") != null ? request.getParameter("returnDate") : request.getParameter("endDate");
                Date startDate = Date.valueOf(pickup);
                Date endDate = Date.valueOf(drop);
                String status = request.getParameter("status");

                if (!startDate.before(endDate)) {
                    response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode("Start date must be before end date", java.nio.charset.StandardCharsets.UTF_8));
                    return;
                }

                String sql = "UPDATE Bookings SET userId=?, vehicleId=?, startDate=?, endDate=?, status=? WHERE bookingId=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                ps.setInt(2, vehicleId);
                ps.setDate(3, startDate);
                ps.setDate(4, endDate);
                ps.setString(5, status);
                ps.setInt(6, bookingId);
                ps.executeUpdate();
                response.sendRedirect("AdminServlet?bookingUpdated=1");
            } else if ("delete".equalsIgnoreCase(action)) {
                String idsParam = request.getParameter("ids");
                String[] idArray;
                if (idsParam != null && !idsParam.trim().isEmpty()) {
                    // Bulk delete
                    idArray = idsParam.split(",");
                } else {
                    // Single delete
                    idArray = new String[]{request.getParameter("bookingId")};
                }

                // For each booking, delete related payments and feedbacks first
                for (String idStr : idArray) {
                    int bookingId = Integer.parseInt(idStr.trim());

                    // Delete related payments
                    try (PreparedStatement ps = conn.prepareStatement("DELETE FROM Payments WHERE bookingId=?")) {
                        ps.setInt(1, bookingId);
                        ps.executeUpdate();
                    } catch (Exception ignore) {}

                    // Delete related feedbacks
                    try (PreparedStatement ps = conn.prepareStatement("DELETE FROM Feedbacks WHERE bookingId=?")) {
                        ps.setInt(1, bookingId);
                        ps.executeUpdate();
                    } catch (Exception ignore) {}

                    // Delete booking
                    try (PreparedStatement ps = conn.prepareStatement("DELETE FROM Bookings WHERE bookingId=?")) {
                        ps.setInt(1, bookingId);
                        ps.executeUpdate();
                    } catch (Exception ignore) {}
                }

                response.sendRedirect("admin-crud.jsp?bookingDeleted=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cargo-landing.jsp?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }
}
