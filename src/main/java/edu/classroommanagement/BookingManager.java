package edu.classroommanagement;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class BookingManager {
    public void addBooking(Booking booking) {
        String sql = "INSERT INTO bookings (room_id, user_id, booking_date, start_time, end_time, status, reason) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, booking.getRoomId());
            stmt.setInt(2, booking.getUserId());
            stmt.setDate(3, java.sql.Date.valueOf(booking.getBookingDate()));
            stmt.setTime(4, java.sql.Time.valueOf(booking.getStartTime()));
            stmt.setTime(5, java.sql.Time.valueOf(booking.getEndTime()));
            stmt.setString(6, booking.getStatus());
            stmt.setString(7, booking.getReason());
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void updateBookingStatus(int id, String status) {
        String sql = "UPDATE bookings SET status = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setId(rs.getInt("id"));
                booking.setRoomId(rs.getInt("room_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setBookingDate(rs.getDate("booking_date").toLocalDate());
                booking.setStartTime(rs.getTime("start_time").toLocalTime());
                booking.setEndTime(rs.getTime("end_time").toLocalTime());
                booking.setStatus(rs.getString("status"));
                booking.setReason(rs.getString("reason"));
                bookings.add(booking);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return bookings;
    }
}