package edu.classroommanagement;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomManager {
    public void addRoom(Room room) {
        String sql = "INSERT INTO rooms (room_number, capacity, status, location, notes) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, room.getRoomNumber());
            stmt.setInt(2, room.getCapacity());
            stmt.setString(3, room.getStatus());
            stmt.setString(4, room.getLocation());
            stmt.setString(5, room.getNotes());
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void updateRoom(Room room) {
        String sql = "UPDATE rooms SET room_number = ?, capacity = ?, status = ?, location = ?, notes = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, room.getRoomNumber());
            stmt.setInt(2, room.getCapacity());
            stmt.setString(3, room.getStatus());
            stmt.setString(4, room.getLocation());
            stmt.setString(5, room.getNotes());
            stmt.setInt(6, room.getId());
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void deleteRoom(int id) {
        String sql = "DELETE FROM rooms WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Room room = new Room();
                room.setId(rs.getInt("id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setCapacity(rs.getInt("capacity"));
                room.setStatus(rs.getString("status"));
                room.setLocation(rs.getString("location"));
                room.setNotes(rs.getString("notes"));
                rooms.add(room);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return rooms;
    }

    public Room getRoomById(int id) {
        Room room = null;
        String sql = "SELECT * FROM rooms WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                room = new Room();
                room.setId(rs.getInt("id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setCapacity(rs.getInt("capacity"));
                room.setStatus(rs.getString("status"));
                room.setLocation(rs.getString("location"));
                room.setNotes(rs.getString("notes"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return room;
    }
}