package edu.classroommanagement;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {
    private ScheduleManager scheduleManager = new ScheduleManager();
    private RoomManager roomManager = new RoomManager();
    private UserManager userManager = new UserManager();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !((User) session.getAttribute("user")).getRole().equals("ADMIN")) {
            response.sendRedirect("login.jsp");
            return;
        }
        String action = request.getParameter("action");
        if ("list".equals(action)) {
            request.setAttribute("schedules", scheduleManager.getAllSchedules());
            request.setAttribute("rooms", roomManager.getAllRooms());
            request.setAttribute("users", userManager.getAllUsers());
            request.getRequestDispatcher("/WEB-INF/scheduleList.jsp").forward(request, response);
        } else if ("addForm".equals(action)) {
            request.setAttribute("rooms", roomManager.getAllRooms());
            request.setAttribute("users", userManager.getAllUsers());
            request.getRequestDispatcher("/WEB-INF/scheduleAdd.jsp").forward(request, response);
        } else if ("editForm".equals(action)) {
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                try {
                    int scheduleId = Integer.parseInt(id);
                    System.out.println("ScheduleServlet: Fetching schedule for editForm with ID: " + scheduleId); // Debug log
                    Schedule schedule = scheduleManager.getScheduleById(scheduleId);
                    if (schedule != null) {
                        request.setAttribute("schedule", schedule);
                        request.setAttribute("rooms", roomManager.getAllRooms());
                        request.setAttribute("users", userManager.getAllUsers());
                        request.getRequestDispatcher("/WEB-INF/scheduleEdit.jsp").forward(request, response);
                    } else {
                        session.setAttribute("error", "Không tìm thấy thời khóa biểu với ID: " + scheduleId);
                        response.sendRedirect("schedule?action=list");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("error", "ID không hợp lệ!");
                    response.sendRedirect("schedule?action=list");
                }
            } else {
                session.setAttribute("error", "ID không được cung cấp!");
                response.sendRedirect("schedule?action=list");
            }
        } else if ("deleteForm".equals(action)) {
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                try {
                    int scheduleId = Integer.parseInt(id);
                    System.out.println("ScheduleServlet: Fetching schedule for deleteForm with ID: " + scheduleId); // Debug log
                    Schedule schedule = scheduleManager.getScheduleById(scheduleId);
                    if (schedule != null) {
                        request.setAttribute("schedule", schedule);
                        request.setAttribute("rooms", roomManager.getAllRooms());
                        request.setAttribute("users", userManager.getAllUsers());
                        request.getRequestDispatcher("/WEB-INF/scheduleDelete.jsp").forward(request, response);
                    } else {
                        session.setAttribute("error", "Không tìm thấy thời khóa biểu với ID: " + scheduleId);
                        response.sendRedirect("schedule?action=list");
                    }
                } catch (NumberFormatException e) {
                    session.setAttribute("error", "ID không hợp lệ!");
                    response.sendRedirect("schedule?action=list");
                }
            } else {
                session.setAttribute("error", "ID không được cung cấp!");
                response.sendRedirect("schedule?action=list");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !((User) session.getAttribute("user")).getRole().equals("ADMIN")) {
            response.sendRedirect("login.jsp");
            return;
        }
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                String roomIdStr = request.getParameter("roomId");
                String userIdStr = request.getParameter("userId");
                String scheduleDate = request.getParameter("scheduleDate");
                String startTime = request.getParameter("startTime");
                String endTime = request.getParameter("endTime");
                String subject = request.getParameter("subject");
                if (roomIdStr == null || userIdStr == null || scheduleDate == null || startTime == null || endTime == null || subject == null ||
                    roomIdStr.trim().isEmpty() || userIdStr.trim().isEmpty() || scheduleDate.trim().isEmpty() ||
                    startTime.trim().isEmpty() || endTime.trim().isEmpty() || subject.trim().isEmpty()) {
                    throw new IllegalArgumentException("Tất cả các trường đều bắt buộc!");
                }
                LocalTime start = LocalTime.parse(startTime);
                LocalTime end = LocalTime.parse(endTime);
                if (!end.isAfter(start)) {
                    throw new IllegalArgumentException("Giờ kết thúc phải sau giờ bắt đầu!");
                }
                Schedule schedule = new Schedule();
                schedule.setRoomId(Integer.parseInt(roomIdStr));
                schedule.setUserId(Integer.parseInt(userIdStr));
                schedule.setScheduleDate(LocalDate.parse(scheduleDate));
                schedule.setStartTime(start);
                schedule.setEndTime(end);
                schedule.setSubject(subject);
                scheduleManager.addSchedule(schedule);
                session.setAttribute("message", "Thêm thời khóa biểu thành công!");
                response.sendRedirect("schedule?action=list");
            } else if ("update".equals(action)) {
                String id = request.getParameter("id");
                String roomIdStr = request.getParameter("roomId");
                String userIdStr = request.getParameter("userId");
                String scheduleDate = request.getParameter("scheduleDate");
                String startTime = request.getParameter("startTime");
                String endTime = request.getParameter("endTime");
                String subject = request.getParameter("subject");
                if (id == null || roomIdStr == null || userIdStr == null || scheduleDate == null || startTime == null || endTime == null || subject == null ||
                    id.trim().isEmpty() || roomIdStr.trim().isEmpty() || userIdStr.trim().isEmpty() ||
                    scheduleDate.trim().isEmpty() || startTime.trim().isEmpty() || endTime.trim().isEmpty() || subject.trim().isEmpty()) {
                    throw new IllegalArgumentException("Tất cả các trường đều bắt buộc!");
                }
                int scheduleId = Integer.parseInt(id);
                System.out.println("ScheduleServlet: Updating schedule with ID: " + scheduleId); // Debug log
                Schedule existingSchedule = scheduleManager.getScheduleById(scheduleId);
                if (existingSchedule == null) {
                    throw new IllegalArgumentException("Thời khóa biểu không tồn tại!");
                }
                LocalTime start = LocalTime.parse(startTime);
                LocalTime end = LocalTime.parse(endTime);
                if (!end.isAfter(start)) {
                    throw new IllegalArgumentException("Giờ kết thúc phải sau giờ bắt đầu!");
                }
                Schedule schedule = new Schedule();
                schedule.setId(scheduleId);
                schedule.setRoomId(Integer.parseInt(roomIdStr));
                schedule.setUserId(Integer.parseInt(userIdStr));
                schedule.setScheduleDate(LocalDate.parse(scheduleDate));
                schedule.setStartTime(start);
                schedule.setEndTime(end);
                schedule.setSubject(subject);
                scheduleManager.updateSchedule(schedule);
                session.setAttribute("message", "Cập nhật thời khóa biểu thành công!");
                response.sendRedirect("schedule?action=list");
            } else if ("delete".equals(action)) {
                String id = request.getParameter("id");
                if (id == null || id.trim().isEmpty()) {
                    throw new IllegalArgumentException("ID không hợp lệ!");
                }
                int scheduleId = Integer.parseInt(id);
                System.out.println("ScheduleServlet: Deleting schedule with ID: " + scheduleId); // Debug log
                Schedule existingSchedule = scheduleManager.getScheduleById(scheduleId);
                if (existingSchedule == null) {
                    throw new IllegalArgumentException("Thời khóa biểu không tồn tại!");
                }
                scheduleManager.deleteSchedule(scheduleId);
                session.setAttribute("message", "Xóa thời khóa biểu thành công!");
                response.sendRedirect("schedule?action=list");
            }
        } catch (IllegalArgumentException e) {
            session.setAttribute("error", e.getMessage());
            response.sendRedirect("schedule?action=list");
        } catch (Exception e) {
            session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect("schedule?action=list");
        }
    }
}