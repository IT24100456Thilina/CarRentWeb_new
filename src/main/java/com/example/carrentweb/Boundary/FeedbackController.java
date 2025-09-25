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

@WebServlet("/FeedbackController")
public class FeedbackController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String comments = request.getParameter("comments");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String bookingIdStr = request.getParameter("bookingId");
        Integer bookingId = (bookingIdStr == null || bookingIdStr.isEmpty()) ? null : Integer.parseInt(bookingIdStr);

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO Feedbacks(bookingId, comments, rating) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            if (bookingId != null) ps.setInt(1, bookingId); else ps.setNull(1, java.sql.Types.INTEGER);
            ps.setString(2, comments);
            ps.setInt(3, rating);
            ps.executeUpdate();

            response.sendRedirect("feedback.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("feedback.jsp?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }
}

