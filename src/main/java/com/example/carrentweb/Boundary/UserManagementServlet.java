package com.example.carrentweb.Boundary;

import com.example.carrentweb.ControlSql.UserDAOImpl;
import com.example.carrentweb.Entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/UserManagementServlet")
public class UserManagementServlet extends HttpServlet {

    private UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("updateRole".equals(action)) {
            handleUpdateRole(request, response);
        } else if ("saveChanges".equals(action)) {
            handleSaveChanges(request, response);
        } else if ("discardChanges".equals(action)) {
            handleDiscardChanges(request, response);
        } else {
            response.sendRedirect("admin-crud.jsp?error=Invalid action");
        }
    }

    private void handleUpdateRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String role = request.getParameter("role");
        String permissions = request.getParameter("permissions"); // e.g., comma-separated

        try {
            // Validate role
            if (!"customer".equals(role) && !"admin".equals(role) && !"other".equals(role)) {
                response.sendRedirect("admin-crud.jsp?error=Invalid role");
                return;
            }

            // Store in session for review
            request.getSession().setAttribute("pendingUserId", userId);
            request.getSession().setAttribute("pendingRole", role);
            request.getSession().setAttribute("pendingPermissions", permissions);

            response.sendRedirect("admin-crud.jsp?review=true");
        } catch (Exception e) {
            response.sendRedirect("admin-crud.jsp?error=" + e.getMessage());
        }
    }

    private void handleSaveChanges(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer userId = (Integer) request.getSession().getAttribute("pendingUserId");
        String role = (String) request.getSession().getAttribute("pendingRole");
        String permissions = (String) request.getSession().getAttribute("pendingPermissions");

        if (userId == null || role == null) {
            response.sendRedirect("admin-crud.jsp?error=No changes to save");
            return;
        }

        try {
            userDAO.updateUserRoleAndPermissions(userId, role, permissions);

            // Clear session
            request.getSession().removeAttribute("pendingUserId");
            request.getSession().removeAttribute("pendingRole");
            request.getSession().removeAttribute("pendingPermissions");

            response.sendRedirect("admin-crud.jsp?success=User role updated successfully");
        } catch (SQLException e) {
            response.sendRedirect("admin-crud.jsp?error=" + e.getMessage());
        }
    }

    private void handleDiscardChanges(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Clear session
        request.getSession().removeAttribute("pendingUserId");
        request.getSession().removeAttribute("pendingRole");
        request.getSession().removeAttribute("pendingPermissions");

        response.sendRedirect("admin-crud.jsp?cancelled=Changes discarded");
    }
}