package edu.classroommanagement;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class ScheduleManager {
    public void addSchedule(Schedule schedule) {
        String sql = "INSERT INTO schedules (room_id, user_id, schedule_date, start_time, end_time, subject) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, schedule.getRoomId());
            stmt.setInt(2, schedule.getUserId());
            stmt.setDate(3, java.sql.Date.valueOf(schedule.getScheduleDate()));
            stmt.setTime(4, java.sql.Time.valueOf(schedule.getStartTime()));
            stmt.setTime(5, java.sql.Time.valueOf(schedule.getEndTime()));
            stmt.setString(6, schedule.getSubject());
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public void updateSchedule(Schedule schedule) {
        String sql = "UPDATE schedules SET room_id = ?, user_id = ?, schedule_date = ?, start_time = ?, end_time = ?, subject = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, schedule.getRoomId());
            stmt.setInt(2, schedule.getUserId());
            stmt.setDate(3, java.sql.Date.valueOf(schedule.getScheduleDate()));
            stmt.setTime(4, java.sql.Time.valueOf(schedule.getStartTime()));
            stmt.setTime(5, java.sql.Time.valueOf(schedule.getEndTime()));
            stmt.setString(6, schedule.getSubject());
            stmt.setInt(7, schedule.getId());
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<Schedule> getAllSchedules() {
        List<Schedule> schedules = new ArrayList<>();
        String sql = "SELECT * FROM schedules";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Schedule schedule = new Schedule();
                schedule.setId(rs.getInt("id"));
                schedule.setRoomId(rs.getInt("room_id"));
                schedule.setUserId(rs.getInt("user_id"));
                schedule.setScheduleDate(rs.getDate("schedule_date").toLocalDate());
                schedule.setStartTime(rs.getTime("start_time").toLocalTime());
                schedule.setEndTime(rs.getTime("end_time").toLocalTime());
                schedule.setSubject(rs.getString("subject"));
                schedules.add(schedule);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return schedules;
    }

    public Schedule getScheduleById(int id) {
        System.out.println("ScheduleManager: Fetching schedule with ID: " + id); // Debug log
        Schedule schedule = null;
        String sql = "SELECT * FROM schedules WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                schedule = new Schedule();
                schedule.setId(rs.getInt("id"));
                schedule.setRoomId(rs.getInt("room_id"));
                schedule.setUserId(rs.getInt("user_id"));
                schedule.setScheduleDate(rs.getDate("schedule_date").toLocalDate());
                schedule.setStartTime(rs.getTime("start_time").toLocalTime());
                schedule.setEndTime(rs.getTime("end_time").toLocalTime());
                schedule.setSubject(rs.getString("subject"));
                System.out.println("ScheduleManager: Successfully fetched schedule ID: " + id); // Debug log
            } else {
                System.out.println("ScheduleManager: No schedule found for ID: " + id); // Debug log
            }
        } catch (SQLException e) {
            System.err.println("ScheduleManager: SQL error for ID: " + id + " - " + e.getMessage()); // Debug log
            e.printStackTrace();
        }
        return schedule;
    }

    public void deleteSchedule(int id) {
        String sql = "DELETE FROM schedules WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }
}