package com.example.carrentweb.Boundary;

import com.example.carrentweb.Entity.Car;
import com.example.carrentweb.ControlSql.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Try to load from DB Vehicles; if fails, fallback to sample
        List<Car> carList = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            java.sql.PreparedStatement ps = conn.prepareStatement("SELECT vehicleId, vehicleName, vehicleType, dailyPrice, imageUrl FROM Vehicles");
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                carList.add(new Car(
                        rs.getInt("vehicleId"),
                        rs.getString("vehicleName"),
                        rs.getString("vehicleType"),
                        rs.getDouble("dailyPrice"),
                        rs.getString("imageUrl")
                ));
            }
        } catch (Exception ignore) {
            carList.add(new Car(1, "Toyota Corolla", "Sedan", 45, "corolla.jpg"));
            carList.add(new Car(2, "Honda Civic", "Sedan", 50, "civic.jpg"));
            carList.add(new Car(3, "Jeep Wrangler", "SUV", 80, "jeep.jpg"));
            carList.add(new Car(4, "BMW X5", "Luxury SUV", 120, "bmw.jpg"));
        }
        request.setAttribute("carList", carList);

        // Promotions
        List<java.util.Map<String,String>> promotions = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT id, title, description, badge, validTill FROM Promotions WHERE active = 1 ORDER BY id DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                java.util.Map<String,String> p = new java.util.HashMap<>();
                p.put("title", rs.getString("title"));
                p.put("description", rs.getString("description"));
                String badge = rs.getString("badge");
                if (badge != null) p.put("badge", badge);
                String valid = rs.getString("validTill");
                if (valid != null) p.put("validTill", valid);
                promotions.add(p);
            }
        } catch (Exception ignore) {}
        if (!promotions.isEmpty()) {
            request.setAttribute("promotions", promotions);
        }

        // Forward to JSP
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
