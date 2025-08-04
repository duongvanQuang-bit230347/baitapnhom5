<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Classroom" %>
<%@ page import="java.util.List" %>
<html>
<head><title>Classroom List</title></head>
<body>
    <h2>Danh sách phòng học</h2>
    <a href="classroom?action=add">Thêm phòng học</a>
    <table border="1">
        <tr><th>ID</th><th>Tên phòng</th><th>Sức chứa</th></tr>
        <%
            List<Classroom> list = (List<Classroom>) request.getAttribute("classrooms");
            for (Classroom c : list) {
        %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getName() %></td>
            <td><%= c.getCapacity() %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
