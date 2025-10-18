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

                // Phone validation
                if (phone == null || !phone.matches("\\d{10}")) {
                    response.sendRedirect("cargo-landing.jsp?errorMsg=" + java.net.URLEncoder.encode("Phone number must be exactly 10 digits", java.nio.charset.StandardCharsets.UTF_8));
                    return;
                }

                // Email validation
                if (email == null || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                    response.sendRedirect("cargo-landing.jsp?errorMsg=" + java.net.URLEncoder.encode("Please enter a valid email address", java.nio.charset.StandardCharsets.UTF_8));
                    return;
                }

                if ("admin".equals(role)) {
                    // For admin, register in Staff table
                    String position = request.getParameter("position");
                    String department = request.getParameter("department");
                    if (position == null || position.trim().isEmpty()) {
                        position = "Executive"; // default
                    }
                    if (department == null || department.trim().isEmpty()) {
                        department = "Management"; // default
                    }

                    String sql = "INSERT INTO Staff(fullName, email, phone, username, password, position, department, isActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, fullName);
                    ps.setString(2, email);
                    ps.setString(3, phone);
                    ps.setString(4, username);
                    ps.setString(5, password);
                    ps.setString(6, position);
                    ps.setString(7, department);
                    ps.setBoolean(8, true);
                    ps.executeUpdate();
                } else {
                    // For customer, register in Users table
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
                }

                if ("admin".equals(role)) {
                    response.sendRedirect("cargo-landing.jsp?registration=success&role=admin");
                } else {
                    response.sendRedirect("cargo-landing.jsp?registration=success");
                }

            } else if ("login".equals(action)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = normalizeRole(request.getParameter("role"));

                ResultSet rs;
                if ("admin".equals(role)) {
                    // For admin, check Staff table, excluding Marketing, Executive, Account positions
                    String sql = "SELECT * FROM Staff WHERE username=? AND password=? AND isActive=? AND position NOT IN ('Marketing', 'Executive', 'Account')";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    ps.setBoolean(3, true);
                    rs = ps.executeQuery();
                } else {
                    // For customer, check Users table
                    boolean hasRoleColumn = hasColumn(conn, "Users", "role");

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
                }

                if (rs.next()) {
                    HttpSession session = request.getSession(true);
                    String fullName = rs.getString("fullName");
                    session.setAttribute("userFullName", fullName);
                    session.setAttribute("username", rs.getString("username"));
                    session.setAttribute("userEmail", rs.getString("email"));
                    session.setAttribute("userPhone", rs.getString("phone"));

                    if ("admin".equals(role)) {
                        int staffId = rs.getInt("staffId");
                        session.setAttribute("userId", staffId);
                        session.setAttribute("position", rs.getString("position"));
                        session.setAttribute("department", rs.getString("department"));
                    } else {
                        int userId = rs.getInt("userId");
                        session.setAttribute("userId", userId);
                    }

                    // Split fullName into first and last name for auto-fill
                    String[] nameParts = fullName.split(" ", 2);
                    session.setAttribute("userFirstName", nameParts.length > 0 ? nameParts[0] : "");
                    session.setAttribute("userLastName", nameParts.length > 1 ? nameParts[1] : "");

                    // Debug logging
                    System.out.println("AuthController: Login successful for username = " + rs.getString("username"));

                    session.setAttribute("role", role);

                    // Role-based redirect
                    switch (role) {
                        case "customer":
                            response.sendRedirect("HomeServlet?page=customer-vehicles&login=1");
                            break;
                        case "admin":
                            // Check position and department for specific redirects
                            String position = rs.getString("position");
                            String department = rs.getString("department");
                            if ("Marketing Executive".equals(position)) {
                                response.sendRedirect("admin-campaign-create.jsp?login=1");
                            } else if ("Accountant".equals(position)) {
                                response.sendRedirect("IncomeReportServlet?login=1");
                            } else if ("Customer Service".equals(department) || "Customer Service Executive".equals(position)) {
                                response.sendRedirect("CustomerServiceServlet?login=1");
                            } else if ("Fleet Supervisor".equals(position) || "Fleet Management".equals(department)) {
                                response.sendRedirect("FleetSupervisorServlet?action=viewFleet&login=1");
                            } else if ("Operations Manager".equals(position) || "Operations".equals(department)) {
                                response.sendRedirect("OperationalReportServlet?login=1");
                            } else {
                                response.sendRedirect("AdminServlet?login=1");
                            }
                            break;
                        default:
                            response.sendRedirect("cargo-landing.jsp");
                    }
                } else {
                    response.sendRedirect("cargo-landing.jsp?login=error");
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
            try (ResultSet columns = metaData.getColumns(null, "dbo", tableName, columnName)) {
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
