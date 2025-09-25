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

@WebServlet("/PromotionController")
public class PromotionController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "add";
        try (Connection conn = DBConnection.getConnection()) {
            switch (action) {
                case "add": {
                    String sql = "INSERT INTO Promotions(title, description, badge, validTill, active) VALUES (?, ?, ?, ?, 1)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, request.getParameter("title"));
                    ps.setString(2, request.getParameter("description"));
                    ps.setString(3, request.getParameter("badge"));
                    ps.setString(4, request.getParameter("validTill"));
                    ps.executeUpdate();
                    break;
                }
                case "update": {
                    String sql = "UPDATE Promotions SET title=?, description=?, badge=?, validTill=?, active=? WHERE id=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, request.getParameter("title"));
                    ps.setString(2, request.getParameter("description"));
                    ps.setString(3, request.getParameter("badge"));
                    ps.setString(4, request.getParameter("validTill"));
                    ps.setBoolean(5, Boolean.parseBoolean(request.getParameter("active")));
                    ps.setInt(6, Integer.parseInt(request.getParameter("id")));
                    ps.executeUpdate();
                    break;
                }
                case "delete": {
                    String sql = "DELETE FROM Promotions WHERE id=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(request.getParameter("id")));
                    ps.executeUpdate();
                    break;
                }
            }
            response.sendRedirect("AdminServlet?promotionsUpdated=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }
}




