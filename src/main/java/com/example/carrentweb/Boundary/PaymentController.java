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
                    double amount = Double.parseDouble(request.getParameter("amount"));
                    String paymentMethod = request.getParameter("paymentMethod");

                    String sql = "INSERT INTO Payments(bookingId, amount, paymentMethod) VALUES (?, ?, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, bookingId);
                    ps.setDouble(2, amount);
                    ps.setString(3, paymentMethod);
                    ps.executeUpdate();

                    response.sendRedirect("HomeServlet?page=customer-feedback&bookingId=" + bookingId);
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
}
