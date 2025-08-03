package edu.classroommanagement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
    private UserManager userManager = new UserManager();
    private RoomManager roomManager = new RoomManager();
    private DeviceManager deviceManager = new DeviceManager();
    private ScheduleManager scheduleManager = new ScheduleManager();

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
            try {
                // Set counts for users, rooms, devices, and schedules
                request.setAttribute("userCount", userManager.getAllUsers().size());
                request.setAttribute("roomCount", roomManager.getAllRooms().size());
                request.setAttribute("deviceCount", deviceManager.getAllDevices().size());
                request.setAttribute("scheduleCount", scheduleManager.getAllSchedules().size());
                request.getRequestDispatcher("/WEB-INF/reportList.jsp").forward(request, response);
            } catch (Exception e) {
                session.setAttribute("error", "Lỗi khi lấy dữ liệu báo cáo: " + e.getMessage());
                response.sendRedirect("dashboard");
            }
        } else {
            response.sendRedirect("dashboard");
        }
    }
}