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

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private BookingManager bookingManager = new BookingManager();
    private RoomManager roomManager = new RoomManager();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        if ("create".equals(action) && (user.getRole().equals("GV") || user.getRole().equals("SV"))) {
            request.setAttribute("rooms", roomManager.getAllRooms());
            request.getRequestDispatcher("/WEB-INF/bookingCreate.jsp").forward(request, response);
        } else if ("list".equals(action)) {
            request.setAttribute("bookings", bookingManager.getAllBookings());
            request.getRequestDispatcher("/WEB-INF/bookingList.jsp").forward(request, response);
        } else if ("approve".equals(action) && user.getRole().equals("ADMIN")) {
            int id = Integer.parseInt(request.getParameter("id"));
            bookingManager.updateBookingStatus(id, "APPROVED");
            response.sendRedirect("booking?action=list");
        } else if ("cancel".equals(action) && user.getRole().equals("ADMIN")) {
            int id = Integer.parseInt(request.getParameter("id"));
            bookingManager.updateBookingStatus(id, "CANCELLED");
            response.sendRedirect("booking?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        if ("create".equals(request.getParameter("action")) && (user.getRole().equals("GV") || user.getRole().equals("SV"))) {
            Booking booking = new Booking();
            booking.setRoomId(Integer.parseInt(request.getParameter("roomId")));
            booking.setUserId(user.getId());
            booking.setBookingDate(LocalDate.parse(request.getParameter("bookingDate")));
            booking.setStartTime(LocalTime.parse(request.getParameter("startTime")));
            booking.setEndTime(LocalTime.parse(request.getParameter("endTime")));
            booking.setStatus("PENDING");
            booking.setReason(request.getParameter("reason"));
            bookingManager.addBooking(booking);
            response.sendRedirect("booking?action=list");
        }
    }
}