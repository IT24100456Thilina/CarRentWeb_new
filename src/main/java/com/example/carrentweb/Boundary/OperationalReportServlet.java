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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/OperationalReportServlet")
public class OperationalReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get month and year parameters, default to current month
        int month = Integer.parseInt(request.getParameter("month") != null ? request.getParameter("month") : String.valueOf(LocalDate.now().getMonthValue()));
        int year = Integer.parseInt(request.getParameter("year") != null ? request.getParameter("year") : String.valueOf(LocalDate.now().getYear()));

        try (Connection conn = DBConnection.getConnection()) {
            // Vehicle Availability Report
            Map<String, Object> vehicleStats = getVehicleStats(conn);

            // Maintenance Status Report (assuming available=0 means under maintenance)
            Map<String, Object> maintenanceStats = getMaintenanceStats(conn);

            // Fleet Performance Report
            Map<String, Object> performanceStats = getPerformanceStats(conn, month, year);

            // Monthly Income Report
            Map<String, Object> incomeStats = getIncomeStats(conn, month, year);

            // Vehicle Details
            List<Map<String, Object>> vehicleDetails = getVehicleDetails(conn);

            // Recent Bookings
            List<Map<String, Object>> recentBookings = getRecentBookings(conn, month, year);

            // Set attributes for JSP
            request.setAttribute("vehicleStats", vehicleStats);
            request.setAttribute("maintenanceStats", maintenanceStats);
            request.setAttribute("performanceStats", performanceStats);
            request.setAttribute("incomeStats", incomeStats);
            request.setAttribute("vehicleDetails", vehicleDetails);
            request.setAttribute("recentBookings", recentBookings);
            request.setAttribute("reportMonth", month);
            request.setAttribute("reportYear", year);
            request.setAttribute("reportPeriod", LocalDate.of(year, month, 1).format(DateTimeFormatter.ofPattern("MMMM yyyy")));

            // Month names for dropdown
            String[] monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
            request.setAttribute("monthNames", monthNames);

            request.getRequestDispatcher("operational-report.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    private Map<String, Object> getVehicleStats(Connection conn) throws Exception {
        Map<String, Object> stats = new HashMap<>();
        String sql = "SELECT " +
            "COUNT(*) as totalVehicles, " +
            "SUM(CASE WHEN available = 1 THEN 1 ELSE 0 END) as availableVehicles, " +
            "SUM(CASE WHEN available = 0 THEN 1 ELSE 0 END) as unavailableVehicles, " +
            "SUM(dailyPrice) as totalFleetValue " +
            "FROM Vehicles";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats.put("totalVehicles", rs.getInt("totalVehicles"));
                stats.put("availableVehicles", rs.getInt("availableVehicles"));
                stats.put("unavailableVehicles", rs.getInt("unavailableVehicles"));
                stats.put("totalFleetValue", rs.getDouble("totalFleetValue"));
                stats.put("availabilityRate", rs.getInt("totalVehicles") > 0 ?
                    (double) rs.getInt("availableVehicles") / rs.getInt("totalVehicles") * 100 : 0.0);
            }
        }
        return stats;
    }

    private Map<String, Object> getMaintenanceStats(Connection conn) throws Exception {
        Map<String, Object> stats = new HashMap<>();
        // Assuming unavailable vehicles are under maintenance
        String sql = "SELECT " +
            "COUNT(*) as totalVehicles, " +
            "SUM(CASE WHEN available = 0 THEN 1 ELSE 0 END) as underMaintenance " +
            "FROM Vehicles";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats.put("totalVehicles", rs.getInt("totalVehicles"));
                stats.put("underMaintenance", rs.getInt("underMaintenance"));
                stats.put("maintenanceRate", rs.getInt("totalVehicles") > 0 ?
                    (double) rs.getInt("underMaintenance") / rs.getInt("totalVehicles") * 100 : 0.0);
            }
        }
        return stats;
    }

    private Map<String, Object> getPerformanceStats(Connection conn, int month, int year) throws Exception {
        Map<String, Object> stats = new HashMap<>();

        // Total bookings for the month
        String bookingSql = "SELECT COUNT(*) as totalBookings, " +
            "SUM(DATEDIFF(day, startDate, endDate) + 1) as totalRentalDays " +
            "FROM Bookings WHERE YEAR(startDate) = ? AND MONTH(startDate) = ?";
        try (PreparedStatement ps = conn.prepareStatement(bookingSql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("totalBookings", rs.getInt("totalBookings"));
                    stats.put("totalRentalDays", rs.getInt("totalRentalDays"));
                }
            }
        }

        // Vehicle utilization
        String utilizationSql = "SELECT COUNT(DISTINCT v.vehicleId) as activeVehicles " +
            "FROM Vehicles v " +
            "JOIN Bookings b ON v.vehicleId = b.vehicleId " +
            "WHERE YEAR(b.startDate) = ? AND MONTH(b.startDate) = ?";
        try (PreparedStatement ps = conn.prepareStatement(utilizationSql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("activeVehicles", rs.getInt("activeVehicles"));
                }
            }
        }

        // Calculate utilization rate
        int totalVehicles = (Integer) getVehicleStats(conn).get("totalVehicles");
        int activeVehicles = (Integer) stats.getOrDefault("activeVehicles", 0);
        stats.put("utilizationRate", totalVehicles > 0 ? (double) activeVehicles / totalVehicles * 100 : 0.0);

        return stats;
    }

    private Map<String, Object> getIncomeStats(Connection conn, int month, int year) throws Exception {
        Map<String, Object> stats = new HashMap<>();
        boolean hasPaymentDate = hasColumn(conn, "Payments", "paymentDate");

        String sql;
        PreparedStatement ps;

        if (hasPaymentDate) {
            sql = "SELECT SUM(p.amount) as totalIncome, COUNT(p.paymentId) as transactionCount " +
                  "FROM Payments p " +
                  "JOIN Bookings b ON p.bookingId = b.bookingId " +
                  "WHERE YEAR(p.paymentDate) = ? AND MONTH(p.paymentDate) = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, year);
            ps.setInt(2, month);
        } else {
            // Fallback: sum all payments (can't filter by date)
            sql = "SELECT SUM(amount) as totalIncome, COUNT(*) as transactionCount FROM Payments";
            ps = conn.prepareStatement(sql);
        }

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats.put("totalIncome", rs.getDouble("totalIncome"));
                stats.put("transactionCount", rs.getInt("transactionCount"));
            }
        }
        return stats;
    }

    private List<Map<String, Object>> getVehicleDetails(Connection conn) throws Exception {
        List<Map<String, Object>> vehicles = new ArrayList<>();
        String sql = "SELECT vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl " +
                     "FROM Vehicles ORDER BY vehicleType, vehicleName";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> vehicle = new HashMap<>();
                vehicle.put("vehicleId", rs.getInt("vehicleId"));
                vehicle.put("vehicleName", rs.getString("vehicleName"));
                vehicle.put("vehicleType", rs.getString("vehicleType"));
                vehicle.put("dailyPrice", rs.getDouble("dailyPrice"));
                vehicle.put("available", rs.getBoolean("available"));
                vehicle.put("imageUrl", rs.getString("imageUrl"));
                vehicle.put("status", rs.getBoolean("available") ? "Available" : "Unavailable");
                vehicles.add(vehicle);
            }
        }
        return vehicles;
    }

    private List<Map<String, Object>> getRecentBookings(Connection conn, int month, int year) throws Exception {
        List<Map<String, Object>> bookings = new ArrayList<>();
        String sql = "SELECT TOP 10 b.bookingId, b.startDate, b.endDate, b.status, " +
                     "u.fullName as customerName, v.vehicleName, v.vehicleType " +
                     "FROM Bookings b " +
                     "JOIN Users u ON b.userId = u.userId " +
                     "JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                     "WHERE YEAR(b.startDate) = ? AND MONTH(b.startDate) = ? " +
                     "ORDER BY b.startDate DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> booking = new HashMap<>();
                    booking.put("bookingId", rs.getInt("bookingId"));
                    booking.put("startDate", rs.getDate("startDate"));
                    booking.put("endDate", rs.getDate("endDate"));
                    booking.put("status", rs.getString("status"));
                    booking.put("customerName", rs.getString("customerName"));
                    booking.put("vehicleName", rs.getString("vehicleName"));
                    booking.put("vehicleType", rs.getString("vehicleType"));
                    bookings.add(booking);
                }
            }
        }
        return bookings;
    }

    private boolean hasColumn(Connection connection, String tableName, String columnName) {
        try {
            java.sql.DatabaseMetaData metaData = connection.getMetaData();
            try (java.sql.ResultSet columns = metaData.getColumns(null, "dbo", tableName, columnName)) {
                return columns.next();
            }
        } catch (Exception e) {
            return false;
        }
    }
}