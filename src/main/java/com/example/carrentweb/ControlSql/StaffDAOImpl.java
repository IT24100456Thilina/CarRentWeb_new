package com.example.carrentweb.ControlSql;

import com.example.carrentweb.Entity.Staff;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StaffDAOImpl {

    public Staff getStaffById(int staffId) throws SQLException {
        String sql = "SELECT staffId, fullName, email, phone, username, password, position, department, isActive FROM Staff WHERE staffId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Staff staff = new Staff();
                staff.setStaffId(rs.getInt("staffId"));
                staff.setFullName(rs.getString("fullName"));
                staff.setEmail(rs.getString("email"));
                staff.setPhone(rs.getString("phone"));
                staff.setUsername(rs.getString("username"));
                staff.setPasswordHash(rs.getString("password"));
                staff.setPosition(rs.getString("position"));
                staff.setDepartment(rs.getString("department"));
                staff.setActive(rs.getBoolean("isActive"));
                return staff;
            }
        }
        return null;
    }

    public List<Staff> getAllStaff() throws SQLException {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT staffId, fullName, email, phone, username, password, position, department, isActive FROM Staff ORDER BY staffId";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Staff staff = new Staff();
                staff.setStaffId(rs.getInt("staffId"));
                staff.setFullName(rs.getString("fullName"));
                staff.setEmail(rs.getString("email"));
                staff.setPhone(rs.getString("phone"));
                staff.setUsername(rs.getString("username"));
                staff.setPasswordHash(rs.getString("password"));
                staff.setPosition(rs.getString("position"));
                staff.setDepartment(rs.getString("department"));
                staff.setActive(rs.getBoolean("isActive"));
                staffList.add(staff);
            }
        }
        return staffList;
    }

    public void addStaff(Staff staff) throws SQLException {
        String sql = "INSERT INTO Staff (fullName, email, phone, username, password, position, department, isActive) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, staff.getFullName());
            ps.setString(2, staff.getEmail());
            ps.setString(3, staff.getPhone());
            ps.setString(4, staff.getUsername());
            ps.setString(5, staff.getPasswordHash());
            ps.setString(6, staff.getPosition());
            ps.setString(7, staff.getDepartment());
            ps.setBoolean(8, staff.isActive());
            ps.executeUpdate();
        }
    }

    public void updateStaff(Staff staff) throws SQLException {
        String sql = "UPDATE Staff SET fullName = ?, email = ?, phone = ?, username = ?, password = ?, position = ?, department = ?, isActive = ? WHERE staffId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, staff.getFullName());
            ps.setString(2, staff.getEmail());
            ps.setString(3, staff.getPhone());
            ps.setString(4, staff.getUsername());
            ps.setString(5, staff.getPasswordHash());
            ps.setString(6, staff.getPosition());
            ps.setString(7, staff.getDepartment());
            ps.setBoolean(8, staff.isActive());
            ps.setInt(9, staff.getStaffId());
            ps.executeUpdate();
        }
    }

    public void deleteStaff(int staffId) throws SQLException {
        String sql = "DELETE FROM Staff WHERE staffId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.executeUpdate();
        }
    }

    public boolean isUsernameExists(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Staff WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Staff WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public List<Staff> getStaffByPositions(List<String> positions) throws SQLException {
        List<Staff> staffList = new ArrayList<>();
        String placeholders = String.join(",", positions.stream().map(p -> "?").toArray(String[]::new));
        String sql = "SELECT staffId, fullName, email, phone, username, password, position, department, isActive FROM Staff WHERE position IN (" + placeholders + ") ORDER BY staffId";
        try (Connection conn = DBConnection.getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < positions.size(); i++) {
                ps.setString(i + 1, positions.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Staff staff = new Staff();
                staff.setStaffId(rs.getInt("staffId"));
                staff.setFullName(rs.getString("fullName"));
                staff.setEmail(rs.getString("email"));
                staff.setPhone(rs.getString("phone"));
                staff.setUsername(rs.getString("username"));
                staff.setPasswordHash(rs.getString("password"));
                staff.setPosition(rs.getString("position"));
                staff.setDepartment(rs.getString("department"));
                staff.setActive(rs.getBoolean("isActive"));
                staffList.add(staff);
            }
        }
        return staffList;
    }
}