package com.example.carrentweb.Boundary;

import com.example.carrentweb.ControlSql.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/HomeServlet", "/"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Load vehicles from DB (support both possible schemas); fallback to sample if fails/empty
        List<java.util.Map<String, Object>> cars = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            try {
                PreparedStatement ps = conn.prepareStatement("SELECT vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl FROM Vehicles");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    java.util.Map<String, Object> c = new java.util.HashMap<>();
                    c.put("vehicleId", rs.getInt("vehicleId"));
                    c.put("vehicleName", rs.getString("vehicleName"));
                    c.put("vehicleType", rs.getString("vehicleType"));
                    c.put("dailyPrice", rs.getDouble("dailyPrice"));
                    Object avail = rs.getObject("available");
                    c.put("available", avail);
                    c.put("imageUrl", rs.getString("imageUrl"));
                    cars.add(c);
                }
            } catch (Exception e1) {
                PreparedStatement ps = conn.prepareStatement("SELECT id, model, type, pricePerDay, status FROM Vehicles");
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    java.util.Map<String, Object> c = new java.util.HashMap<>();
                    c.put("vehicleId", rs.getInt("id"));
                    c.put("vehicleName", rs.getString("model"));
                    c.put("vehicleType", rs.getString("type"));
                    c.put("dailyPrice", rs.getDouble("pricePerDay"));
                    Object avail = rs.getObject("status");
                    c.put("available", avail);
                    c.put("imageUrl", null);
                    cars.add(c);
                }
            }
        } catch (Exception ignore) {}

        if (cars.isEmpty()) {
            java.util.Map<String, Object> c1 = new java.util.HashMap<>();
            c1.put("vehicleId", 1); c1.put("vehicleName", "Toyota Corolla"); c1.put("vehicleType", "Sedan"); c1.put("dailyPrice", 45); c1.put("available", true); c1.put("imageUrl", "corolla.jpg");
            java.util.Map<String, Object> c2 = new java.util.HashMap<>();
            c2.put("vehicleId", 2); c2.put("vehicleName", "Honda Civic"); c2.put("vehicleType", "Sedan"); c2.put("dailyPrice", 50); c2.put("available", true); c2.put("imageUrl", "civic.jpg");
            java.util.Map<String, Object> c3 = new java.util.HashMap<>();
            c3.put("vehicleId", 3); c3.put("vehicleName", "Jeep Wrangler"); c3.put("vehicleType", "SUV"); c3.put("dailyPrice", 80); c3.put("available", true); c3.put("imageUrl", "jeep.jpg");
            java.util.Map<String, Object> c4 = new java.util.HashMap<>();
            c4.put("vehicleId", 4); c4.put("vehicleName", "BMW X5"); c4.put("vehicleType", "Luxury SUV"); c4.put("dailyPrice", 120); c4.put("available", false); c4.put("imageUrl", "bmw.jpg");
            cars.add(c1); cars.add(c2); cars.add(c3); cars.add(c4);
        }
        request.setAttribute("carList", cars);

        // Promotions
        List<java.util.Map<String,String>> promotions = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT id, title, description, badge, validTill FROM Promotions WHERE active = 1 ORDER BY id DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                java.util.Map<String,String> p = new java.util.HashMap<>();
                p.put("title", rs.getString("title"));
                p.put("description", rs.getString("description"));
                String badge = rs.getString("badge");
                if (badge != null) p.put("badge", badge);
                String valid = rs.getString("validTill");
                if (valid != null) p.put("validTill", valid);
                promotions.add(p);
            }
        } catch (Exception ignore) {}
        if (promotions.isEmpty()) {
            // Add sample promotions if none in DB
            java.util.Map<String,String> p1 = new java.util.HashMap<>();
            p1.put("title", "Welcome Discount");
            p1.put("description", "Get 10% off on your first booking with CarGO!");
            p1.put("badge", "10% OFF");
            p1.put("validTill", "2025-12-31");
            promotions.add(p1);

            java.util.Map<String,String> p2 = new java.util.HashMap<>();
            p2.put("title", "Weekend Special");
            p2.put("description", "Book a vehicle for the weekend and save 15%!");
            p2.put("badge", "15% OFF");
            p2.put("validTill", "2025-12-31");
            promotions.add(p2);

            java.util.Map<String,String> p3 = new java.util.HashMap<>();
            p3.put("title", "Long Term Rental");
            p3.put("description", "Rent for 7 days or more and get free insurance!");
            p3.put("badge", "FREE INSURANCE");
            p3.put("validTill", "2025-12-31");
            promotions.add(p3);
        }
        request.setAttribute("promotions", promotions);
        request.setAttribute("promotionsList", promotions); // For customer-promotions.jsp
        request.setAttribute("activePromotionsCount", promotions.size());

        // Set featured promotion (first one)
        if (!promotions.isEmpty()) {
            request.setAttribute("featuredPromotion", promotions.get(0));
        }

        // Handle logout parameter
        String logout = request.getParameter("logout");
        if ("1".equals(logout)) {
            request.setAttribute("logout", "1");
        }

        // Handle admin parameter
        String admin = request.getParameter("admin");
        if ("promotions".equals(admin)) {
            request.setAttribute("showAdminPromotions", "1");
        }

        // Load recent feedback
        List<java.util.Map<String, Object>> recentFeedback = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT TOP 5 f.feedbackId, f.bookingId, f.comments, f.rating FROM Feedbacks f ORDER BY f.feedbackId DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                java.util.Map<String, Object> f = new java.util.HashMap<>();
                f.put("feedbackId", rs.getInt("feedbackId"));
                f.put("bookingId", rs.getObject("bookingId"));
                f.put("comments", rs.getString("comments"));
                f.put("rating", rs.getInt("rating"));
                f.put("dateSubmitted", "Recent"); // Since no date column exists
                f.put("fullName", "Valued Customer"); // Since no user info available
                recentFeedback.add(f);
            }
        } catch (Exception ignore) {}
        request.setAttribute("recentFeedback", recentFeedback);

        // Handle feedback parameter
        String feedback = request.getParameter("feedback");
        if ("1".equals(feedback)) {
            request.setAttribute("feedback", "1");
        }

        // Load user bookings for customers (for feedback form on homepage)
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userRole = (String) session.getAttribute("role");

        if (userId != null && "customer".equals(userRole)) {
            try (Connection conn = DBConnection.getConnection()) {
                List<java.util.Map<String, Object>> userBookings = new ArrayList<>();
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT b.bookingId, b.startDate, b.endDate, v.vehicleName " +
                    "FROM Bookings b " +
                    "JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                    "WHERE b.userId = ? " +
                    "ORDER BY b.startDate DESC"
                );
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    java.util.Map<String, Object> booking = new java.util.HashMap<>();
                    booking.put("bookingId", rs.getInt("bookingId"));
                    booking.put("pickupDate", rs.getString("startDate"));
                    booking.put("returnDate", rs.getString("endDate"));
                    booking.put("vehicleName", rs.getString("vehicleName"));
                    userBookings.add(booking);
                }
                request.setAttribute("userBookings", userBookings);
            } catch (Exception ignore) {}
        }

        // Handle different page requests
        String page = request.getParameter("page");
        String targetJsp = "cargo-landing.jsp";

        if ("customer-vehicles".equals(page)) {
            targetJsp = "customer-vehicles.jsp";
        } else if ("customer-promotions".equals(page)) {
            targetJsp = "customer-promotions.jsp";

        } else if ("customer-booking".equals(page)) {
            loadCustomerBookingsData(request, response);
            targetJsp = "customer-booking.jsp";
        } else if ("customer-feedback".equals(page)) {
            System.out.println("HomeServlet: Routing to customer-feedback page");
            loadCustomerFeedbackData(request, response);
            targetJsp = "customer-feedback.jsp";
        } else if ("customer-payment".equals(page)) {
            loadCustomerPaymentsData(request, response);
            targetJsp = "customer-payment.jsp";
        } else if ("customer-dashboard".equals(page)) {
            targetJsp = "customer-dashboard.jsp";
            loadCustomerDashboardData(request, response);
        }

        // Forward to appropriate JSP
        request.getRequestDispatcher(targetJsp).forward(request, response);
    }

    private void loadCustomerFeedbackData(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Debug logging
        System.out.println("HomeServlet: loadCustomerFeedbackData called");
        System.out.println("HomeServlet: userId from session = " + userId);
        System.out.println("HomeServlet: username from session = " + session.getAttribute("username"));

        if (userId != null) {
            try (Connection conn = DBConnection.getConnection()) {
                // Load customer bookings for feedback form
                List<java.util.Map<String, Object>> customerBookings = new ArrayList<>();
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT b.bookingId, b.startDate, b.endDate, v.vehicleName " +
                    "FROM Bookings b " +
                    "JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                    "WHERE b.userId = ? " +
                    "ORDER BY b.startDate DESC"
                );
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    java.util.Map<String, Object> booking = new java.util.HashMap<>();
                    booking.put("bookingId", rs.getInt("bookingId"));
                    booking.put("startDate", rs.getString("startDate"));
                    booking.put("endDate", rs.getString("endDate"));
                    booking.put("vehicleName", rs.getString("vehicleName"));
                    customerBookings.add(booking);
                }
                request.setAttribute("customerBookings", customerBookings);

                // Load customer feedback list
                List<java.util.Map<String, Object>> customerFeedbackList = new ArrayList<>();

                PreparedStatement psFeedback = conn.prepareStatement(
                    "SELECT f.feedbackId, f.bookingId, f.comments, f.rating, f.dateSubmitted, " +
                    "b.startDate, b.endDate, v.vehicleName " +
                    "FROM Feedbacks f " +
                    "LEFT JOIN Bookings b ON f.bookingId = b.bookingId " +
                    "LEFT JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                    "WHERE f.userId = ? " +
                    "ORDER BY f.dateSubmitted DESC"
                );
                psFeedback.setInt(1, userId);

                rs = psFeedback.executeQuery();
                while (rs.next()) {
                    java.util.Map<String, Object> feedback = new java.util.HashMap<>();
                    feedback.put("feedbackId", rs.getInt("feedbackId"));
                    feedback.put("bookingId", rs.getObject("bookingId"));
                    feedback.put("comments", rs.getString("comments"));
                    feedback.put("rating", rs.getInt("rating"));
                    feedback.put("dateSubmitted", rs.getString("dateSubmitted"));
                    customerFeedbackList.add(feedback);
                }
                psFeedback.close();
                request.setAttribute("customerFeedbackList", customerFeedbackList);
                request.setAttribute("customerFeedbackCount", customerFeedbackList.size());

                // Debug logging
                System.out.println("HomeServlet: customerFeedbackList size = " + customerFeedbackList.size());
                System.out.println("HomeServlet: customerBookings size = " + customerBookings.size());

                // Calculate average rating
                if (!customerFeedbackList.isEmpty()) {
                    double totalRating = 0;
                    for (java.util.Map<String, Object> feedback : customerFeedbackList) {
                        totalRating += (Integer) feedback.get("rating");
                    }
                    double avgRating = totalRating / customerFeedbackList.size();
                    request.setAttribute("customerAvgRating", avgRating);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void loadCustomerDashboardData(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userRole = (String) session.getAttribute("role");

        if (userId != null && "customer".equals(userRole)) {
            try (Connection conn = DBConnection.getConnection()) {
                // Total Bookings
                PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM Bookings WHERE userId = ?");
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    request.setAttribute("totalBookings", rs.getInt(1));
                }
                rs.close();
                ps.close();

                // Revenue
                ps = conn.prepareStatement("SELECT COALESCE(SUM(p.amount), 0) FROM Payments p JOIN Bookings b ON p.bookingId = b.bookingId WHERE b.userId = ?");
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    request.setAttribute("revenue", rs.getDouble(1));
                }
                rs.close();
                ps.close();

                // Active Bookings
                ps = conn.prepareStatement("SELECT COUNT(*) FROM Bookings WHERE userId = ? AND startDate <= CAST(GETDATE() AS DATE) AND endDate >= CAST(GETDATE() AS DATE)");
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    request.setAttribute("activeBookings", rs.getInt(1));
                }
                rs.close();
                ps.close();

                // Total Available Vehicles
                ps = conn.prepareStatement("SELECT COUNT(*) FROM Vehicles WHERE available = 1");
                rs = ps.executeQuery();
                if (rs.next()) {
                    request.setAttribute("totalVehicles", rs.getInt(1));
                }
                rs.close();
                ps.close();

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void loadCustomerBookingsData(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId != null) {
            try (Connection conn = DBConnection.getConnection()) {
                // Load customer bookings
                List<java.util.Map<String, Object>> customerBookings = new ArrayList<>();
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT b.bookingId, b.startDate, b.endDate, b.status, v.vehicleName, " +
                    "DATEDIFF(day, b.startDate, b.endDate) + 1 as duration, " +
                    "(DATEDIFF(day, b.startDate, b.endDate) + 1) * v.dailyPrice as totalCost " +
                    "FROM Bookings b " +
                    "JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                    "WHERE b.userId = ? " +
                    "ORDER BY b.startDate DESC"
                );
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    java.util.Map<String, Object> booking = new java.util.HashMap<>();
                    booking.put("bookingId", rs.getInt("bookingId"));
                    booking.put("pickupDate", rs.getString("startDate"));
                    booking.put("returnDate", rs.getString("endDate"));
                    booking.put("status", rs.getString("status") != null ? rs.getString("status") : "Pending");
                    booking.put("vehicleName", rs.getString("vehicleName"));
                    booking.put("totalCost", rs.getDouble("totalCost"));
                    customerBookings.add(booking);
                }
                request.setAttribute("customerBookings", customerBookings);

                // Add sample booking if none exist
                if (customerBookings.isEmpty()) {
                    java.util.Map<String, Object> sampleBooking = new java.util.HashMap<>();
                    sampleBooking.put("bookingId", 1);
                    sampleBooking.put("pickupDate", "2025-09-27");
                    sampleBooking.put("returnDate", "2025-09-30");
                    sampleBooking.put("status", "Confirmed");
                    sampleBooking.put("vehicleName", "Toyota Corolla");
                    sampleBooking.put("totalCost", 120.0);
                    customerBookings.add(sampleBooking);
                    request.setAttribute("customerBookings", customerBookings);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void loadCustomerPaymentsData(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        List<java.util.Map<String, Object>> customerPayments = new ArrayList<>();

        if (userId != null) {
            try (Connection conn = DBConnection.getConnection()) {
                // Load customer payments
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT p.paymentId, p.bookingId, p.amount, p.paymentMethod, p.paymentDate, v.vehicleName " +
                    "FROM Payments p " +
                    "JOIN Bookings b ON p.bookingId = b.bookingId " +
                    "JOIN Vehicles v ON b.vehicleId = v.vehicleId " +
                    "WHERE b.userId = ? " +
                    "ORDER BY p.paymentDate DESC"
                );
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    java.util.Map<String, Object> payment = new java.util.HashMap<>();
                    payment.put("paymentId", rs.getInt("paymentId"));
                    payment.put("bookingId", rs.getInt("bookingId"));
                    payment.put("amount", rs.getDouble("amount"));
                    payment.put("paymentMethod", rs.getString("paymentMethod"));
                    payment.put("paymentDate", rs.getString("paymentDate"));
                    payment.put("vehicleName", rs.getString("vehicleName"));
                    customerPayments.add(payment);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Add sample payment for testing if none exist
        if (customerPayments.isEmpty()) {
            java.util.Map<String, Object> samplePayment = new java.util.HashMap<>();
            samplePayment.put("paymentId", 1);
            samplePayment.put("bookingId", 1);
            samplePayment.put("amount", 120.0);
            samplePayment.put("paymentMethod", "Credit Card");
            samplePayment.put("paymentDate", "2025-09-26");
            samplePayment.put("vehicleName", "Toyota Corolla");
            customerPayments.add(samplePayment);
        }

        // Set attributes
        request.setAttribute("customerPayments", customerPayments);
        request.setAttribute("totalPayments", customerPayments.size());
        double totalAmount = 0;
        for (java.util.Map<String, Object> payment : customerPayments) {
            totalAmount += (Double) payment.get("amount");
        }
        request.setAttribute("totalAmount", totalAmount);
        List<java.util.Map<String, Object>> recentPaymentsList = new ArrayList<>();
        int cnt = 0;
        for (java.util.Map<String, Object> payment : customerPayments) {
            if (cnt < 5) {
                recentPaymentsList.add(payment);
                cnt++;
            } else {
                break;
            }
        }
        request.setAttribute("recentPayments", recentPaymentsList);
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
