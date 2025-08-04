<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Thêm phòng học</title></head>
<body>
    <h2>Thêm mới phòng học</h2>
    <form method="post" action="classroom">
        Tên phòng: <input type="text" name="name"/><br/>
        Sức chứa: <input type="number" name="capacity"/><br/>
        <input type="submit" value="Lưu"/>
    </form>
</body>
</html>
