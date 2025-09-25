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

@WebServlet("/VehicleController")
public class VehicleController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "add";
        try (Connection conn = DBConnection.getConnection()) {
            switch (action) {
                case "add": {
                    String sql = "INSERT INTO Vehicles(vehicleId, vehicleName, vehicleType, dailyPrice, available, imageUrl) VALUES (?, ?, ?, ?, 1, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(request.getParameter("vehicleId")));
                    ps.setString(2, request.getParameter("vehicleName"));
                    ps.setString(3, request.getParameter("vehicleType"));
                    ps.setDouble(4, Double.parseDouble(request.getParameter("dailyPrice")));
                    ps.setString(5, request.getParameter("imageUrl"));
                    ps.executeUpdate();
                    break;
                }
                case "update": {
                    String sql = "UPDATE Vehicles SET vehicleName=?, vehicleType=?, dailyPrice=?, available=?, imageUrl=? WHERE vehicleId=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, request.getParameter("vehicleName"));
                    ps.setString(2, request.getParameter("vehicleType"));
                    ps.setDouble(3, Double.parseDouble(request.getParameter("dailyPrice")));
                    ps.setBoolean(4, Boolean.parseBoolean(request.getParameter("available")));
                    ps.setString(5, request.getParameter("imageUrl"));
                    ps.setInt(6, Integer.parseInt(request.getParameter("vehicleId")));
                    ps.executeUpdate();
                    break;
                }
                case "delete": {
                    String sql = "DELETE FROM Vehicles WHERE vehicleId=?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(request.getParameter("vehicleId")));
                    ps.executeUpdate();
                    break;
                }
            }
            response.sendRedirect("AdminServlet?vehiclesUpdated=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminServlet?errorMsg=" + java.net.URLEncoder.encode(e.getMessage(), java.nio.charset.StandardCharsets.UTF_8));
        }
    }
}


