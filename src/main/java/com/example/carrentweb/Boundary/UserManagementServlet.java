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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("get".equals(action)) {
            handleGetUser(request, response);
        } else {
            response.sendRedirect("admin-crud.jsp?error=Invalid action");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("updateRole".equals(action)) {
            handleUpdateRole(request, response);
        } else if ("saveChanges".equals(action)) {
            handleSaveChanges(request, response);
        } else if ("discardChanges".equals(action)) {
            handleDiscardChanges(request, response);
        } else if ("create".equals(action)) {
            handleCreateUser(request, response);
        } else if ("update".equals(action)) {
            handleUpdateUser(request, response);
        } else if ("deactivate".equals(action)) {
            handleDeactivateUser(request, response);
        } else if ("activate".equals(action)) {
            handleActivateUser(request, response);
        } else if ("delete".equals(action)) {
            handleDeleteUser(request, response);
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

    private void handleGetUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        try {
            int userId = Integer.parseInt(request.getParameter("id"));
            User user = userDAO.getUserById(userId);

            if (user != null) {
                String json = String.format(
                    "{\"userId\":%d,\"fullName\":\"%s\",\"email\":\"%s\",\"phone\":\"%s\",\"username\":\"%s\",\"passwordHash\":\"%s\",\"role\":\"%s\",\"isActive\":%b}",
                    user.getUserId(),
                    user.getFullName().replace("\"", "\\\""),
                    user.getEmail().replace("\"", "\\\""),
                    user.getPhone() != null ? user.getPhone().replace("\"", "\\\"") : "",
                    user.getUsername().replace("\"", "\\\""),
                    user.getPasswordHash().replace("\"", "\\\""),
                    user.getRole(),
                    user.isActive()
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

    private void handleCreateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Basic validation
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            response.sendRedirect("admin-crud.jsp?error=All required fields must be filled");
            return;
        }

        try {
            // Check if username already exists
            if (userDAO.isUsernameExists(username)) {
                response.sendRedirect("admin-crud.jsp?error=Username already exists");
                return;
            }

            // Check if email already exists
            if (userDAO.isEmailExists(email)) {
                response.sendRedirect("admin-crud.jsp?error=Email already exists");
                return;
            }

            // Validate role
            if (!"customer".equals(role) && !"admin".equals(role) && !"staff".equals(role) && !"executive".equals(role)) {
                role = "customer"; // Default to customer
            }

            // Create user
            User user = new User(fullName, email, phone, username, password, role);
            userDAO.createUser(user);

            response.sendRedirect("admin-crud.jsp?success=User created successfully");
        } catch (Exception e) {
            response.sendRedirect("admin-crud.jsp?error=" + e.getMessage());
        }
    }

    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Basic validation
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            username == null || username.trim().isEmpty()) {
            response.sendRedirect("admin-crud.jsp?error=All required fields must be filled");
            return;
        }

        try {
            // Get existing user
            User user = userDAO.getUserById(userId);
            if (user == null) {
                response.sendRedirect("admin-crud.jsp?error=User not found");
                return;
            }

            // Check if username is taken by another user
            if (!user.getUsername().equals(username) && userDAO.isUsernameExists(username)) {
                response.sendRedirect("admin-crud.jsp?error=Username already exists");
                return;
            }

            // Check if email is taken by another user
            if (!user.getEmail().equals(email) && userDAO.isEmailExists(email)) {
                response.sendRedirect("admin-crud.jsp?error=Email already exists");
                return;
            }

            // Update user
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setUsername(username);
            if (password != null && !password.trim().isEmpty()) {
                user.setPasswordHash(password);
            }
            user.setRole(role);

            userDAO.updateUser(user);

            response.sendRedirect("admin-crud.jsp?success=User updated successfully");
        } catch (Exception e) {
            response.sendRedirect("admin-crud.jsp?error=" + e.getMessage());
        }
    }

    private void handleDeactivateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        try {
            userDAO.deactivateUser(userId);
            response.sendRedirect("admin-crud.jsp?success=User deactivated successfully");
        } catch (Exception e) {
            response.sendRedirect("admin-crud.jsp?error=" + e.getMessage());
        }
    }

    private void handleActivateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        try {
            userDAO.activateUser(userId);
            response.sendRedirect("admin-crud.jsp?success=User activated successfully");
        } catch (Exception e) {
            response.sendRedirect("admin-crud.jsp?error=" + e.getMessage());
        }
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        try {
            userDAO.deleteUser(userId);
            response.sendRedirect("admin-crud.jsp?success=User deleted successfully");
        } catch (Exception e) {
            response.sendRedirect("admin-crud.jsp?error=" + e.getMessage());
        }
    }
}