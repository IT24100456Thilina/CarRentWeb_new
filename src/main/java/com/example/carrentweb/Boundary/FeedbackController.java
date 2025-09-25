package com.example.carrentweb.Boundary;

import com.example.carrentweb.ControlSql.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/FeedbackController")
public class FeedbackController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            handleDelete(request, response);
            return;
        } else if ("deleteAll".equals(action)) {
            handleDeleteAll(request, response);
            return;
        }

        // Default: submit feedback
        handleSubmit(request, response);
    }

    private void handleSubmit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Debug: Log all parameters
        System.out.println("FeedbackController: handleSubmit called");
        System.out.println("FeedbackController: All parameters:");
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            System.out.println("FeedbackController: " + paramName + " = " + request.getParameter(paramName));
        }

        String comments = request.getParameter("comments");
        String message = request.getParameter("message");
        String text = (comments != null && !comments.isEmpty()) ? comments : message;

        // Validate that feedback text is not empty
        if (text == null || text.trim().isEmpty()) {
            System.err.println("FeedbackController: Feedback text is empty");
            response.sendRedirect("HomeServlet?page=customer-feedback&errorMsg=Please provide feedback comments");
            return;
        }

        // Trim whitespace from text
        text = text.trim();

        int rating = 5;
        try {
            rating = Integer.parseInt(request.getParameter("rating"));
            // Ensure rating is within valid range
            rating = Math.max(1, Math.min(5, rating));
        } catch (Exception ignore) {}
        String bookingIdStr = request.getParameter("bookingId");
        Integer bookingId = (bookingIdStr == null || bookingIdStr.isEmpty()) ? null : Integer.parseInt(bookingIdStr);

        System.out.println("FeedbackController: Processed data:");
        System.out.println("FeedbackController: text = " + text);
        System.out.println("FeedbackController: rating = " + rating);
        System.out.println("FeedbackController: bookingId = " + bookingId);

        // Get user ID from session
        HttpSession session = request.getSession(false); // Don't create new session
        if (session == null) {
            System.err.println("FeedbackController: No session found - user not logged in");
            response.sendRedirect("cargo-landing.jsp?error=Please login to submit feedback");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");

        // Debug logging
        System.out.println("FeedbackController: Session found");
        System.out.println("FeedbackController: userId from session = " + userId);
        System.out.println("FeedbackController: username from session = " + username);
        System.out.println("FeedbackController: role from session = " + session.getAttribute("role"));

        if (userId == null) {
            System.err.println("FeedbackController: userId is null - user not properly logged in");
            response.sendRedirect("cargo-landing.jsp?error=Session expired. Please login again");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // Debug logging
            System.out.println("FeedbackController: Database connection successful");

            if (conn == null) {
                System.err.println("FeedbackController: Database connection is null!");
                response.sendRedirect("HomeServlet?page=customer-feedback&errorMsg=Database connection failed");
                return;
            }

            // Check if Feedbacks table exists
            boolean hasTable = hasTable(conn, "Feedbacks");
            if (!hasTable) {
                System.err.println("FeedbackController: Feedbacks table does not exist!");
                response.sendRedirect("HomeServlet?page=customer-feedback&errorMsg=Feedbacks table does not exist");
                return;
            }

            // Use actual table schema: feedbackId, bookingId, userId, comments, rating, dateSubmitted
            String sql = "INSERT INTO Feedbacks(bookingId, userId, comments, rating, dateSubmitted) VALUES (?, ?, ?, ?, GETDATE())";
            System.out.println("FeedbackController: Using SQL: " + sql);
            PreparedStatement ps = conn.prepareStatement(sql);
            if (bookingId != null) ps.setInt(1, bookingId); else ps.setNull(1, java.sql.Types.INTEGER);
            ps.setInt(2, userId);
            ps.setString(3, text);
            ps.setInt(4, rating);

            int rowsAffected = ps.executeUpdate();
            System.out.println("FeedbackController: Rows affected = " + rowsAffected);
            ps.close();

            if (rowsAffected > 0) {
                System.out.println("FeedbackController: Feedback saved successfully");
                response.sendRedirect("HomeServlet?page=customer-dashboard");
            } else {
                System.out.println("FeedbackController: No rows affected - feedback not saved");
                response.sendRedirect("HomeServlet?page=customer-feedback&errorMsg=No rows affected");
            }
        } catch (Exception e) {
            System.err.println("FeedbackController: Exception occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("HomeServlet?page=customer-feedback&errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("FeedbackController: handleDelete called");

        // Check admin role
        HttpSession session = request.getSession(false);
        if (session == null) {
            System.err.println("FeedbackController: No session found");
            response.sendRedirect("admin-crud.jsp?error=Session expired");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            System.err.println("FeedbackController: Access denied - not admin");
            response.sendRedirect("admin-crud.jsp?error=Access denied");
            return;
        }

        String feedbackIdsStr = request.getParameter("ids");
        String feedbackIdStr = request.getParameter("feedbackId");

        if (feedbackIdsStr != null && !feedbackIdsStr.isEmpty()) {
            // Bulk delete
            handleBulkDelete(request, response, feedbackIdsStr);
        } else if (feedbackIdStr != null && !feedbackIdStr.isEmpty()) {
            // Single delete
            handleSingleDelete(request, response, feedbackIdStr);
        } else {
            System.err.println("FeedbackController: feedbackId or ids parameter missing");
            response.sendRedirect("admin-crud.jsp?error=Invalid feedback ID");
            return;
        }
    }

    private void handleSingleDelete(HttpServletRequest request, HttpServletResponse response, String feedbackIdStr) throws ServletException, IOException {
        int feedbackId;
        try {
            feedbackId = Integer.parseInt(feedbackIdStr);
        } catch (NumberFormatException e) {
            System.err.println("FeedbackController: Invalid feedbackId format");
            response.sendRedirect("admin-crud.jsp?error=Invalid feedback ID");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.err.println("FeedbackController: Database connection is null!");
                response.sendRedirect("admin-crud.jsp?error=Database connection failed");
                return;
            }

            String sql = "DELETE FROM Feedbacks WHERE feedbackId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, feedbackId);

            int rowsAffected = ps.executeUpdate();
            ps.close();

            if (rowsAffected > 0) {
                System.out.println("FeedbackController: Feedback deleted successfully");
                response.sendRedirect("admin-crud.jsp?success=Feedback deleted");
            } else {
                System.out.println("FeedbackController: No feedback found with ID " + feedbackId);
                response.sendRedirect("admin-crud.jsp?error=Feedback not found");
            }
        } catch (Exception e) {
            System.err.println("FeedbackController: Exception occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("admin-crud.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    private void handleBulkDelete(HttpServletRequest request, HttpServletResponse response, String feedbackIdsStr) throws ServletException, IOException {
        String[] idStrings = feedbackIdsStr.split(",");
        List<Integer> feedbackIds = new ArrayList<>();

        for (String idStr : idStrings) {
            try {
                feedbackIds.add(Integer.parseInt(idStr.trim()));
            } catch (NumberFormatException e) {
                System.err.println("FeedbackController: Invalid feedbackId in bulk delete: " + idStr);
                response.sendRedirect("admin-crud.jsp?error=Invalid feedback ID in list");
                return;
            }
        }

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.err.println("FeedbackController: Database connection is null!");
                response.sendRedirect("admin-crud.jsp?error=Database connection failed");
                return;
            }

            // Build IN clause for bulk delete
            StringBuilder placeholders = new StringBuilder();
            for (int i = 0; i < feedbackIds.size(); i++) {
                if (i > 0) placeholders.append(",");
                placeholders.append("?");
            }

            String sql = "DELETE FROM Feedbacks WHERE feedbackId IN (" + placeholders.toString() + ")";
            PreparedStatement ps = conn.prepareStatement(sql);

            for (int i = 0; i < feedbackIds.size(); i++) {
                ps.setInt(i + 1, feedbackIds.get(i));
            }

            int rowsAffected = ps.executeUpdate();
            ps.close();

            System.out.println("FeedbackController: Bulk feedback delete completed, rows affected: " + rowsAffected);
            response.sendRedirect("admin-crud.jsp?success=" + rowsAffected + " feedback entries deleted");
        } catch (Exception e) {
            System.err.println("FeedbackController: Exception occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("admin-crud.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    private void handleDeleteAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("FeedbackController: handleDeleteAll called");

        // Check admin role
        HttpSession session = request.getSession(false);
        if (session == null) {
            System.err.println("FeedbackController: No session found");
            response.sendRedirect("admin-crud.jsp?error=Session expired");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"admin".equals(role)) {
            System.err.println("FeedbackController: Access denied - not admin");
            response.sendRedirect("admin-crud.jsp?error=Access denied");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            if (conn == null) {
                System.err.println("FeedbackController: Database connection is null!");
                response.sendRedirect("admin-crud.jsp?error=Database connection failed");
                return;
            }

            String sql = "DELETE FROM Feedbacks";
            PreparedStatement ps = conn.prepareStatement(sql);

            int rowsAffected = ps.executeUpdate();
            ps.close();

            System.out.println("FeedbackController: All feedback deleted successfully, rows affected: " + rowsAffected);
            response.sendRedirect("admin-crud.jsp?success=All feedback deleted (" + rowsAffected + " entries)");
        } catch (Exception e) {
            System.err.println("FeedbackController: Exception occurred: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("AdminServlet?error=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    private boolean hasColumn(Connection connection, String tableName, String columnName) {
        try {
            java.sql.DatabaseMetaData metaData = connection.getMetaData();
            try (java.sql.ResultSet columns = metaData.getColumns(null, "dbo", tableName, columnName)) {
                boolean exists = columns.next();
                System.out.println("FeedbackController: Column " + columnName + " in table " + tableName + " exists: " + exists);
                return exists;
            }
        } catch (Exception e) {
            System.err.println("FeedbackController: Error checking column existence: " + e.getMessage());
            return false;
        }
    }

    private boolean hasTable(Connection connection, String tableName) {
        try {
            java.sql.DatabaseMetaData metaData = connection.getMetaData();
            try (java.sql.ResultSet tables = metaData.getTables(null, "dbo", tableName, new String[]{"TABLE"})) {
                boolean exists = tables.next();
                System.out.println("FeedbackController: Table " + tableName + " exists: " + exists);
                return exists;
            }
        } catch (Exception e) {
            System.err.println("FeedbackController: Error checking table existence: " + e.getMessage());
            return false;
        }
    }
}

