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
import java.util.Arrays;
import java.util.List;

@WebServlet("/AdminBoardController")
public class AdminBoardController extends HttpServlet {

    private StaffDAOImpl staffDAO = new StaffDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is admin
        if (!"admin".equals(request.getSession().getAttribute("role"))) {
            response.sendRedirect("cargo-landing.jsp?errorMsg=Access denied");
            return;
        }

        try {
            // Fetch staff with positions: Marketing, Executive, Account
            List<String> positions = Arrays.asList("Marketing", "Executive", "Account");
            List<Staff> staffList = staffDAO.getStaffByPositions(positions);
            request.setAttribute("staffList", staffList);

            request.getRequestDispatcher("AdminBoard.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("cargo-landing.jsp?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }
}