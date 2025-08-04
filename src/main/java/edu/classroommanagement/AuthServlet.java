package edu.classroommanagement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private UserManager userManager = new UserManager();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        if ("logout".equals(action) && session != null) {
            session.invalidate();
            response.sendRedirect("login.jsp");
            return;
        }
        if ("changePassword".equals(action) && session != null && session.getAttribute("user") != null) {
            request.getRequestDispatcher("/WEB-INF/changePassword.jsp").forward(request, response);
            return;
        }
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("login".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            User user = userManager.getUserByUsername(username);
            if (user != null && user.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                response.sendRedirect("dashboard.jsp");
            } else {
                request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else if ("changePassword".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                User user = (User) session.getAttribute("user");
                String oldPassword = request.getParameter("oldPassword");
                String newPassword = request.getParameter("newPassword");
                if (user.getPassword().equals(oldPassword)) {
                    user.setPassword(newPassword);
                    userManager.updateUser(user);
                    request.setAttribute("message", "Mật khẩu đã được đổi thành công");
                } else {
                    request.setAttribute("error", "Mật khẩu cũ không đúng");
                }
                request.getRequestDispatcher("/WEB-INF/changePassword.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        }
    }
}