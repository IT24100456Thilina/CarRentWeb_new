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

@WebServlet("/PaymentController")
public class PaymentController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        double amount = Double.parseDouble(request.getParameter("amount"));
        String paymentMethod = request.getParameter("paymentMethod");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO Payments(bookingId, amount, paymentMethod) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookingId);
            ps.setDouble(2, amount);
            ps.setString(3, paymentMethod);
            ps.executeUpdate();
            response.sendRedirect("payment.jsp?success=1&bookingId=" + bookingId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("payment.jsp?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }
}
