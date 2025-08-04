package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClassroomDAO;
import model.Classroom;

public class ClassroomServlet extends HttpServlet {

    private ClassroomDAO dao;

    @Override
    public void init() {
        dao = new ClassroomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("add".equals(action)) {
            req.getRequestDispatcher("add.jsp").forward(req, resp);
        } else {
            req.setAttribute("classrooms", dao.getAll());
            req.getRequestDispatcher("list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        int capacity = Integer.parseInt(req.getParameter("capacity"));
        dao.add(new Classroom(0, name, capacity));
        resp.sendRedirect("classroom");
    }
}
