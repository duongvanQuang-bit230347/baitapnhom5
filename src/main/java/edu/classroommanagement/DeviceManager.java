package edu.classroommanagement;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DeviceManager {
    public void addDevice(Device device) throws SQLException {
        String sql = "INSERT INTO devices (name, room_id, status, condition_notes) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, device.getName());
            stmt.setInt(2, device.getRoomId());
            stmt.setString(3, device.getStatus());
            stmt.setString(4, device.getConditionNotes());
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Thêm thiết bị thất bại, không có hàng nào bị ảnh hưởng.");
            }
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    device.setId(generatedKeys.getInt(1)); // Set ID mới
                } else {
                    throw new SQLException("Thêm thiết bị thất bại, không lấy được ID.");
                }
            }
        }
    }

    public void updateDevice(Device device) throws SQLException {
        String sql = "UPDATE devices SET name = ?, room_id = ?, status = ?, condition_notes = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, device.getName());
            stmt.setInt(2, device.getRoomId());
            stmt.setString(3, device.getStatus());
            stmt.setString(4, device.getConditionNotes());
            stmt.setInt(5, device.getId());
            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Cập nhật thiết bị thất bại, không có hàng nào bị ảnh hưởng.");
            }
        }
    }

    public List<Device> getAllDevices() {
        List<Device> devices = new ArrayList<>();
        String sql = "SELECT * FROM devices";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Device device = new Device();
                device.setId(rs.getInt("id"));
                device.setName(rs.getString("name"));
                device.setRoomId(rs.getInt("room_id"));
                device.setStatus(rs.getString("status"));
                device.setConditionNotes(rs.getString("condition_notes"));
                devices.add(device);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return devices;
    }

    public List<Device> getDevicesByRoom(int roomId) {
        List<Device> devices = new ArrayList<>();
        String sql = "SELECT * FROM devices WHERE room_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, roomId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Device device = new Device();
                device.setId(rs.getInt("id"));
                device.setName(rs.getString("name"));
                device.setRoomId(rs.getInt("room_id"));
                device.setStatus(rs.getString("status"));
                device.setConditionNotes(rs.getString("condition_notes"));
                devices.add(device);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return devices;
    }

    public Device getDeviceById(int id) {
        Device device = null;
        String sql = "SELECT * FROM devices WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                device = new Device();
                device.setId(rs.getInt("id"));
                device.setName(rs.getString("name"));
                device.setRoomId(rs.getInt("room_id"));
                device.setStatus(rs.getString("status"));
                device.setConditionNotes(rs.getString("condition_notes"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return device;
    }

    public void deleteDevice(int id) {
        String sql = "DELETE FROM devices WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}