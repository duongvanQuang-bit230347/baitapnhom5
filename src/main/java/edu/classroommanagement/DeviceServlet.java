package edu.classroommanagement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/device")
public class DeviceServlet extends HttpServlet {
    private DeviceManager deviceManager = new DeviceManager();
    private RoomManager roomManager = new RoomManager();

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
            request.setAttribute("devices", deviceManager.getAllDevices()); // Thêm danh sách thiết bị
            request.setAttribute("rooms", roomManager.getAllRooms());
            request.getRequestDispatcher("/WEB-INF/deviceList.jsp").forward(request, response);
        } else if ("addForm".equals(action)) {
            request.setAttribute("rooms", roomManager.getAllRooms());
            request.getRequestDispatcher("/WEB-INF/deviceAdd.jsp").forward(request, response);
        } else if ("editForm".equals(action)) {
            String id = request.getParameter("id");
            if (id != null && !id.isEmpty()) {
                try {
                    int deviceId = Integer.parseInt(id);
                    Device device = deviceManager.getDeviceById(deviceId); // Cần thêm getDeviceById trong DeviceManager
                    if (device != null) {
                        request.setAttribute("device", device);
                        request.setAttribute("rooms", roomManager.getAllRooms());
                        request.getRequestDispatcher("/WEB-INF/deviceEdit.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Không tìm thấy thiết bị!");
                        request.getRequestDispatcher("/WEB-INF/deviceList.jsp").forward(request, response);
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID không hợp lệ!");
                    request.getRequestDispatcher("/WEB-INF/deviceList.jsp").forward(request, response);
                }
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
        try {
            if ("add".equals(request.getParameter("action"))) {
                Device device = new Device();
                device.setName(request.getParameter("name"));
                device.setRoomId(Integer.parseInt(request.getParameter("roomId")));
                device.setStatus(request.getParameter("status"));
                device.setConditionNotes(request.getParameter("conditionNotes"));
                deviceManager.addDevice(device);
                request.setAttribute("message", "Thêm thiết bị thành công");
            } else if ("update".equals(request.getParameter("action"))) {
                Device device = new Device();
                device.setId(Integer.parseInt(request.getParameter("id")));
                device.setName(request.getParameter("name"));
                device.setRoomId(Integer.parseInt(request.getParameter("roomId")));
                device.setStatus(request.getParameter("status"));
                device.setConditionNotes(request.getParameter("conditionNotes"));
                deviceManager.updateDevice(device);
                request.setAttribute("message", "Cập nhật thiết bị thành công");
            } else if ("delete".equals(request.getParameter("action"))) {
                String id = request.getParameter("id");
                if (id != null && !id.isEmpty()) {
                    try {
                        int deviceId = Integer.parseInt(id);
                        deviceManager.deleteDevice(deviceId); // Cần thêm deleteDevice trong DeviceManager
                        request.setAttribute("message", "Xóa thiết bị thành công");
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "ID không hợp lệ!");
                    }
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }
        response.sendRedirect("device?action=list"); // Reload danh sách
    }
}