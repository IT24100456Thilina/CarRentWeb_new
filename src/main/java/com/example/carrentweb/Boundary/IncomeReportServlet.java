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

@WebServlet("/IncomeReportServlet")
public class IncomeReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get month and year parameters, default to current month
        int month = Integer.parseInt(request.getParameter("month") != null ? request.getParameter("month") : String.valueOf(LocalDate.now().getMonthValue()));
        int year = Integer.parseInt(request.getParameter("year") != null ? request.getParameter("year") : String.valueOf(LocalDate.now().getYear()));

        try (Connection conn = DBConnection.getConnection()) {
            // Check if paymentDate column exists
            boolean hasPaymentDate = hasColumn(conn, "Payments", "paymentDate");

            String sql;
            PreparedStatement ps;

            if (hasPaymentDate) {
                // Query payments for the specified month
                sql = "SELECT p.paymentId, p.bookingId, p.amount, p.paymentMethod, p.paymentDate, " +
                      "u.fullName AS customerName, v.vehicleName " +
                      "FROM Payments p " +
                      "JOIN Bookings b ON p.bookingId = b.bookingId " +
                      "JOIN Users u ON b.userId = u.userId " +
                      "JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                      "WHERE YEAR(p.paymentDate) = ? AND MONTH(p.paymentDate) = ? " +
                      "ORDER BY p.paymentDate DESC";

                ps = conn.prepareStatement(sql);
                ps.setInt(1, year);
                ps.setInt(2, month);
            } else {
                // Fallback: get all payments (can't filter by date)
                sql = "SELECT p.paymentId, p.bookingId, p.amount, p.paymentMethod, " +
                      "u.fullName AS customerName, v.vehicleName " +
                      "FROM Payments p " +
                      "JOIN Bookings b ON p.bookingId = b.bookingId " +
                      "JOIN Users u ON b.userId = u.userId " +
                      "JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                      "ORDER BY p.paymentId DESC";

                ps = conn.prepareStatement(sql);
            }

            ResultSet rs = ps.executeQuery();

            List<Map<String, Object>> transactions = new ArrayList<>();
            double totalIncome = 0.0;

            while (rs.next()) {
                Map<String, Object> transaction = new HashMap<>();
                transaction.put("paymentId", rs.getInt("paymentId"));
                transaction.put("bookingId", rs.getInt("bookingId"));
                transaction.put("amount", rs.getDouble("amount"));
                transaction.put("paymentMethod", rs.getString("paymentMethod"));
                if (hasPaymentDate) {
                    transaction.put("paymentDate", rs.getDate("paymentDate"));
                } else {
                    transaction.put("paymentDate", null); // No date available
                }
                transaction.put("customerName", rs.getString("customerName"));
                transaction.put("vehicleName", rs.getString("vehicleName"));
                transactions.add(transaction);
                totalIncome += rs.getDouble("amount");
            }

            // For now, expenses are not tracked, so set to 0
            double totalExpenses = 0.0;
            double netProfit = totalIncome - totalExpenses;

            // Set attributes for JSP
            request.setAttribute("transactions", transactions);
            request.setAttribute("totalIncome", totalIncome);
            request.setAttribute("totalExpenses", totalExpenses);
            request.setAttribute("netProfit", netProfit);
            request.setAttribute("reportMonth", month);
            request.setAttribute("reportYear", year);
            request.setAttribute("reportPeriod", LocalDate.of(year, month, 1).format(DateTimeFormatter.ofPattern("MMMM yyyy")));
            request.setAttribute("reportMonthName", LocalDate.of(year, month, 1).format(DateTimeFormatter.ofPattern("MMMM")));

            // Month names for dropdown
            String[] monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
            request.setAttribute("monthNames", monthNames);

            request.getRequestDispatcher("accountant-income-report.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
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