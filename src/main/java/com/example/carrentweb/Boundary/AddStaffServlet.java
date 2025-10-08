package com.example.carrentweb.Boundary;

import com.example.carrentweb.ControlSql.StaffDAOImpl;
import com.example.carrentweb.Entity.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AddStaffServlet")
public class AddStaffServlet extends HttpServlet {

    private StaffDAOImpl staffDAO;

    @Override
    public void init() throws ServletException {
        staffDAO = new StaffDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("get".equals(action)) {
            try {
                getStaff(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
            }
        } else {
            // Redirect to the add staff form
            response.sendRedirect("add-staff.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "add";

        try {
            switch (action) {
                case "add":
                    addStaff(request, response);
                    break;
                case "delete":
                    deleteStaff(request, response);
                    break;
                default:
                    response.sendRedirect("admin-crud.jsp?errorMsg=" + java.net.URLEncoder.encode("Invalid action", java.nio.charset.StandardCharsets.UTF_8));
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add-staff.jsp?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }

    private void addStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        // Get form parameters
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String position = request.getParameter("position");
        String department = request.getParameter("department");

        // Basic validation
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            position == null || position.trim().isEmpty() ||
            department == null || department.trim().isEmpty()) {
            response.sendRedirect("add-staff.jsp?errorMsg=" + java.net.URLEncoder.encode("All fields are required", java.nio.charset.StandardCharsets.UTF_8));
            return;
        }

        // Check if username already exists
        if (staffDAO.isUsernameExists(username)) {
            response.sendRedirect("add-staff.jsp?errorMsg=" + java.net.URLEncoder.encode("Username already exists", java.nio.charset.StandardCharsets.UTF_8));
            return;
        }

        // Check if email already exists
        if (staffDAO.isEmailExists(email)) {
            response.sendRedirect("add-staff.jsp?errorMsg=" + java.net.URLEncoder.encode("Email already exists", java.nio.charset.StandardCharsets.UTF_8));
            return;
        }

        // Create staff object
        Staff staff = new Staff(fullName, email, phone, username, password, position, department);

        // Add to database
        staffDAO.addStaff(staff);

        // Redirect with success message
        response.sendRedirect("admin-crud.jsp?successMsg=" + java.net.URLEncoder.encode("Staff member added successfully", java.nio.charset.StandardCharsets.UTF_8));
    }

    private void getStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        response.setContentType("application/json");
        try {
            int staffId = Integer.parseInt(request.getParameter("id"));
            Staff staff = staffDAO.getStaffById(staffId);

            if (staff != null) {
                String json = String.format(
                    "{\"staffId\":%d,\"fullName\":\"%s\",\"email\":\"%s\",\"phone\":\"%s\",\"username\":\"%s\",\"passwordHash\":\"%s\",\"position\":\"%s\",\"department\":\"%s\",\"isActive\":%b}",
                    staff.getStaffId(),
                    staff.getFullName().replace("\"", "\\\""),
                    staff.getEmail().replace("\"", "\\\""),
                    staff.getPhone().replace("\"", "\\\""),
                    staff.getUsername().replace("\"", "\\\""),
                    staff.getPasswordHash().replace("\"", "\\\""),
                    staff.getPosition().replace("\"", "\\\""),
                    staff.getDepartment().replace("\"", "\\\""),
                    staff.isActive()
                );
                response.getWriter().write(json);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Staff member not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private void deleteStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String idsParam = request.getParameter("ids");
        if (idsParam != null && !idsParam.trim().isEmpty()) {
            // Bulk delete
            String[] idArray = idsParam.split(",");
            for (String id : idArray) {
                int staffId = Integer.parseInt(id.trim());
                staffDAO.deleteStaff(staffId);
            }
        } else {
            // Single delete
            int staffId = Integer.parseInt(request.getParameter("staffId"));
            staffDAO.deleteStaff(staffId);
        }

        // Redirect with success message
        response.sendRedirect("admin-crud.jsp?successMsg=" + java.net.URLEncoder.encode("Staff member(s) deleted successfully", java.nio.charset.StandardCharsets.UTF_8));
    }
}