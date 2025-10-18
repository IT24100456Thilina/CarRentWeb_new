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

@WebServlet("/UserController")
public class UserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("get".equals(action)) {
            getUser(request, response);
        } else {
            doPost(request, response);
        }
    }

    private void getUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT userId, fullName, username, email, password FROM Users WHERE userId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(request.getParameter("id")));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String json = String.format(
                    "{\"userId\":%d,\"fullName\":\"%s\",\"username\":\"%s\",\"email\":\"%s\",\"password\":\"%s\"}",
                    rs.getInt("userId"),
                    rs.getString("fullName").replace("\"", "\\\""),
                    rs.getString("username").replace("\"", "\\\""),
                    rs.getString("email").replace("\"", "\\\""),
                    rs.getString("password").replace("\"", "\\\"")
                );
                response.getWriter().write(json);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
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
                    String fullName = request.getParameter("fullName");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String role = request.getParameter("role");

                    if (phone == null || !phone.matches("\\d{10}")) {
                        response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode("Phone number must be exactly 10 digits", java.nio.charset.StandardCharsets.UTF_8));
                        return;
                    }

                    String sql = "INSERT INTO Users(fullName, email, phone, username, password, role) VALUES (?, ?, ?, ?, ?, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, fullName);
                    ps.setString(2, email);
                    ps.setString(3, phone);
                    ps.setString(4, username);
                    ps.setString(5, password);
                    ps.setString(6, role);
                    ps.executeUpdate();

                    response.sendRedirect("admin-crud.jsp?userCreated=1");
                    break;
                }
                case "update": {
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    String fullName = request.getParameter("fullName");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String role = request.getParameter("role");

                    if (phone == null || !phone.matches("\\d{10}")) {
                        response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode("Phone number must be exactly 10 digits", java.nio.charset.StandardCharsets.UTF_8));
                        return;
                    }

                    String sql = "UPDATE Users SET fullName=?, email=?, phone=?, username=?, password=?, role=? WHERE userId=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, fullName);
                    ps.setString(2, email);
                    ps.setString(3, phone);
                    ps.setString(4, username);
                    ps.setString(5, password);
                    ps.setString(6, role);
                    ps.setInt(7, userId);
                    ps.executeUpdate();

                    response.sendRedirect("admin-crud.jsp?userUpdated=1");
                    break;
                }
                case "delete": {
                    String idsParam = request.getParameter("ids");
                    if (idsParam != null && !idsParam.trim().isEmpty()) {
                        // Bulk delete
                        String[] idArray = idsParam.split(",");
                        String sql = "DELETE FROM Users WHERE userId=?";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        for (String id : idArray) {
                            ps.setInt(1, Integer.parseInt(id.trim()));
                            ps.executeUpdate();
                        }
                    } else {
                        // Single delete
                        int userId = Integer.parseInt(request.getParameter("userId"));
                        String sql = "DELETE FROM Users WHERE userId=?";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setInt(1, userId);
                        ps.executeUpdate();
                    }

                    response.sendRedirect("admin-crud.jsp?userDeleted=1");
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