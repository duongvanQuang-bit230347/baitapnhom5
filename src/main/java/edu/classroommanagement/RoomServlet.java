package edu.classroommanagement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/room")
public class RoomServlet extends HttpServlet {
    private RoomManager roomManager = new RoomManager();
    private DeviceManager deviceManager = new DeviceManager();

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
            request.setAttribute("rooms", roomManager.getAllRooms());
            request.getRequestDispatcher("/WEB-INF/roomList.jsp").forward(request, response);
        } else if ("addForm".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/roomAdd.jsp").forward(request, response);
        } else if ("editForm".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Room room = roomManager.getRoomById(id);
                if (room != null) {
                    request.setAttribute("room", room);
                    request.getRequestDispatcher("/WEB-INF/roomEdit.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("error", "Không tìm thấy phòng!");
                    response.sendRedirect("room?action=list");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("error", "ID không hợp lệ!");
                response.sendRedirect("room?action=list");
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
                Room room = new Room();
                room.setRoomNumber(request.getParameter("roomNumber"));
                room.setCapacity(Integer.parseInt(request.getParameter("capacity")));
                room.setStatus(request.getParameter("status"));
                room.setLocation(request.getParameter("location"));
                room.setNotes(request.getParameter("notes"));
                roomManager.addRoom(room);
                request.getSession().setAttribute("message", "Thêm phòng thành công!");
            } else if ("update".equals(action)) {
                Room room = new Room();
                room.setId(Integer.parseInt(request.getParameter("id")));
                room.setRoomNumber(request.getParameter("roomNumber"));
                room.setCapacity(Integer.parseInt(request.getParameter("capacity")));
                room.setStatus(request.getParameter("status"));
                room.setLocation(request.getParameter("location"));
                room.setNotes(request.getParameter("notes"));
                roomManager.updateRoom(room);
                request.getSession().setAttribute("message", "Cập nhật phòng thành công!");
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                roomManager.deleteRoom(id);
                request.getSession().setAttribute("message", "Xóa phòng thành công!");
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Dữ liệu không hợp lệ: " + e.getMessage());
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        }
        response.sendRedirect("room?action=list");
    }
}