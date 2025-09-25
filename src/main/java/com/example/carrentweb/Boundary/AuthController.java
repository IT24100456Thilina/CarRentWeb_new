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

@WebServlet("/AuthController")
public class AuthController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("HomeServlet?logout=1");
            return;
        }

        // Default: forward to login page
        response.sendRedirect("cargo-landing.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {
            if ("register".equals(action)) {
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = normalizeRole(request.getParameter("role"));

                boolean hasRoleColumn = hasColumn(conn, "Users", "role");

                if (hasRoleColumn) {
                    String sql = "INSERT INTO Users(fullName, email, phone, username, password, role) VALUES (?, ?, ?, ?, ?, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, fullName);
                    ps.setString(2, email);
                    ps.setString(3, phone);
                    ps.setString(4, username);
                    ps.setString(5, password);
                    ps.setString(6, role);
                    ps.executeUpdate();
                } else {
                    String sql = "INSERT INTO Users(fullName, email, phone, username, password) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, fullName);
                    ps.setString(2, email);
                    ps.setString(3, phone);
                    ps.setString(4, username);
                    ps.setString(5, password);
                    ps.executeUpdate();
                }

                response.sendRedirect("cargo-landing.jsp?registered=1");

            } else if ("login".equals(action)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = normalizeRole(request.getParameter("role"));

                boolean hasRoleColumn = hasColumn(conn, "Users", "role");

                ResultSet rs;
                if (hasRoleColumn) {
                    String sql = "SELECT * FROM Users WHERE username=? AND password=? AND role=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    ps.setString(3, role);
                    rs = ps.executeQuery();
                } else {
                    String sql = "SELECT * FROM Users WHERE username=? AND password=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    rs = ps.executeQuery();
                }

                if (rs.next()) {
                    HttpSession session = request.getSession(true);
                    int userId = rs.getInt("userId");
                    session.setAttribute("userFullName", rs.getString("fullName"));
                    session.setAttribute("userId", userId);
                    session.setAttribute("username", rs.getString("username"));

                    // Debug logging
                    System.out.println("AuthController: Login successful for userId = " + userId);
                    System.out.println("AuthController: username = " + rs.getString("username"));

                    // Since Users table doesn't have role column, use request parameter
                    String resolvedRole = normalizeRole(role);
                    session.setAttribute("role", resolvedRole);

                    // Role-based redirect
                    switch (resolvedRole) {
                        case "customer":
                            response.sendRedirect("HomeServlet?page=customer-vehicles");
                            break;
                        case "admin":
                            response.sendRedirect("AdminServlet");
                            break;
                        default:
                            response.sendRedirect("cargo-landing.jsp");
                    }
                } else {
                    response.sendRedirect("HomeServlet");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("cargo-landing.jsp?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    private static boolean hasColumn(Connection connection, String tableName, String columnName) {
        try {
            DatabaseMetaData metaData = connection.getMetaData();
            try (ResultSet columns = metaData.getColumns(null, null, tableName, columnName)) {
                return columns.next();
            }
        } catch (Exception e) {
            return false;
        }
    }

    private static String normalizeRole(String role) {
        if (role == null) {
            return "user";
        }
        role = role.trim().toLowerCase();
        if (role.equals("customer") || role.equals("admin") || role.equals("user")) {
            return role;
        }
        return "user";
    }
}
