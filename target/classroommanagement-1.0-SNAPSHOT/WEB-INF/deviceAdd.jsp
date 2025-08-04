<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Thiết bị</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4" style="color: #ff6f61;">Thêm Thiết bị</h2>
        <form action="device" method="post">
            <input type="hidden" name="action" value="add">
            <div class="mb-3">
                <label class="form-label">Tên thiết bị</label>
                <input type="text" name="name" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Phòng</label>
                <select name="roomId" class="form-select" required>
                    <c:forEach var="room" items="${rooms}">
                        <option value="${room.id}">${room.roomNumber}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Trạng thái</label>
                <select name="status" class="form-select" required>
                    <option value="WORKING">Đang hoạt động</option>
                    <option value="BROKEN">Hỏng</option>
                    <option value="MAINTENANCE">Bảo trì</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Ghi chú tình trạng</label>
                <textarea name="conditionNotes" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Thêm</button>
            <a href="device?action=list" class="btn btn-secondary">Hủy</a>
        </form>
        <c:if test="${not empty message}"><p class="text-success text-center mt-2">${message}</p></c:if>
        <c:if test="${not empty error}"><p class="text-danger text-center mt-2">${error}</p></c:if>
    </div>
</body>
</html>