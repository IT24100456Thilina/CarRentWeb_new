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

@WebServlet("/PromotionController")
public class PromotionController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("get".equals(action)) {
            getPromotion(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void getPromotion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, title, description, badge, discountCode, discountType, discountValue, validTill, active, type, createdDate FROM Promotions WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(request.getParameter("id")));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String json = String.format(
                    "{\"id\":%d,\"title\":\"%s\",\"description\":\"%s\",\"badge\":\"%s\",\"discountCode\":\"%s\",\"discountType\":\"%s\",\"discountValue\":%s,\"validTill\":\"%s\",\"active\":%b,\"type\":\"%s\",\"createdDate\":\"%s\"}",
                    rs.getInt("id"),
                    rs.getString("title").replace("\"", "\\\""),
                    rs.getString("description").replace("\"", "\\\""),
                    rs.getString("badge") != null ? rs.getString("badge").replace("\"", "\\\"") : "",
                    rs.getString("discountCode") != null ? rs.getString("discountCode").replace("\"", "\\\"") : "",
                    rs.getString("discountType"),
                    rs.getBigDecimal("discountValue") != null ? rs.getBigDecimal("discountValue").toString() : "null",
                    rs.getString("validTill"),
                    rs.getBoolean("active"),
                    rs.getString("type"),
                    rs.getString("createdDate")
                );
                response.getWriter().write(json);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Promotion not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "add";
        try (Connection conn = DBConnection.getConnection()) {
            switch (action) {
                case "add": {
                    String sql = "INSERT INTO Promotions(title, description, badge, discountCode, discountType, discountValue, validTill, active, type) VALUES (?, ?, ?, ?, ?, ?, ?, 1, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, request.getParameter("title"));
                    ps.setString(2, request.getParameter("description"));
                    ps.setString(3, request.getParameter("badge"));
                    ps.setString(4, request.getParameter("discountCode"));
                    ps.setString(5, request.getParameter("discountType"));
                    String discountValueStr = request.getParameter("discountValue");
                    if (discountValueStr != null && !discountValueStr.trim().isEmpty()) {
                        ps.setBigDecimal(6, new java.math.BigDecimal(discountValueStr));
                    } else {
                        ps.setNull(6, java.sql.Types.DECIMAL);
                    }
                    ps.setString(7, request.getParameter("validTill"));
                    ps.setString(8, request.getParameter("type"));
                    ps.executeUpdate();
                    break;
                }
                case "update": {
                    String sql = "UPDATE Promotions SET title=?, description=?, badge=?, discountCode=?, discountType=?, discountValue=?, validTill=?, active=?, type=? WHERE id=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, request.getParameter("title"));
                    ps.setString(2, request.getParameter("description"));
                    ps.setString(3, request.getParameter("badge"));
                    ps.setString(4, request.getParameter("discountCode"));
                    ps.setString(5, request.getParameter("discountType"));
                    String discountValueStr = request.getParameter("discountValue");
                    if (discountValueStr != null && !discountValueStr.trim().isEmpty()) {
                        ps.setBigDecimal(6, new java.math.BigDecimal(discountValueStr));
                    } else {
                        ps.setNull(6, java.sql.Types.DECIMAL);
                    }
                    ps.setString(7, request.getParameter("validTill"));
                    ps.setBoolean(8, Boolean.parseBoolean(request.getParameter("active")));
                    ps.setString(9, request.getParameter("type"));
                    ps.setInt(10, Integer.parseInt(request.getParameter("id")));
                    ps.executeUpdate();
                    break;
                }
                case "delete": {
                    String idsParam = request.getParameter("ids");
                    if (idsParam != null && !idsParam.trim().isEmpty()) {
                        // Bulk delete
                        String[] idArray = idsParam.split(",");
                        String sql = "DELETE FROM Promotions WHERE id=?";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        for (String id : idArray) {
                            ps.setInt(1, Integer.parseInt(id.trim()));
                            ps.executeUpdate();
                        }
                    } else {
                        // Single delete
                        String sql = "DELETE FROM Promotions WHERE id=?";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setInt(1, Integer.parseInt(request.getParameter("id")));
                        ps.executeUpdate();
                    }
                    break;
                }
            }
            response.sendRedirect("admin-crud.jsp?promotionsUpdated=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }
}




