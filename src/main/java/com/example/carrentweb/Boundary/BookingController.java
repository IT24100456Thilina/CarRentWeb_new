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
                    response.sendRedirect("home.jsp?errorMsg=" + java.net.URLEncoder.encode("Start date must be before end date", java.nio.charset.StandardCharsets.UTF_8));
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
                    response.sendRedirect("home.jsp?booked=1");
                } else {
                    response.sendRedirect("home.jsp?errorMsg=" + java.net.URLEncoder.encode("Booking failed", java.nio.charset.StandardCharsets.UTF_8));
                }
            } else if ("updateStatus".equalsIgnoreCase(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                String status = request.getParameter("status");
                String sql = "UPDATE Bookings SET status=? WHERE bookingId=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, status);
                ps.setInt(2, bookingId);
                ps.executeUpdate();
                response.sendRedirect("admin.jsp?updated=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home.jsp?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }
}
