<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xóa Thời Khóa Biểu</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.tailwindcss.com/3.3.3/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
        }
        .container {
            max-width: 600px;
            margin-top: 2rem;
        }
        .card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .btn-danger {
            background: linear-gradient(45deg, #ef4444, #f87171);
            border: none;
            transition: all 0.3s ease;
        }
        .btn-danger:hover {
            background: linear-gradient(45deg, #dc2626, #ef4444);
            transform: scale(1.05);
        }
        .btn-secondary {
            background: linear-gradient(45deg, #3b82f6, #60a5fa);
            border: none;
            transition: all 0.3s ease;
        }
        .btn-secondary:hover {
            background: linear-gradient(45deg, #2563eb, #3b82f6);
            transform: scale(1.05);
        }
        .alert {
            position: fixed;
            top: 1rem;
            right: 1rem;
            z-index: 1000;
            animation: slideIn 0.5s ease-out, slideOut 0.5s ease-out 4s forwards;
        }
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        @keyframes slideOut {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h2 class="mb-4 text-center text-2xl font-bold text-[#ff6f61]">Xóa Thời Khóa Biểu</h2>
            <c:choose>
                <c:when test="${not empty schedule}">
                    <h4 class="mb-3">Bạn có chắc chắn muốn xóa thời khóa biểu này?</h4>
                    <p><strong>Phòng:</strong> 
                        <c:forEach var="room" items="${rooms}">
                            <c:if test="${room.id == schedule.roomId}">${room.roomNumber}</c:if>
                        </c:forEach>
                    </p>
                    <p><strong>Người Dùng:</strong> 
                        <c:forEach var="user" items="${users}">
                            <c:if test="${user.id == schedule.userId}">${user.fullName}</c:if>
                        </c:forEach>
                    </p>
                    <p><strong>Ngày:</strong> ${schedule.scheduleDate}</p>
                    <p><strong>Giờ Bắt Đầu:</strong> ${schedule.startTime}</p>
                    <p><strong>Giờ Kết Thúc:</strong> ${schedule.endTime}</p>
                    <p><strong>Môn Học:</strong> ${schedule.subject}</p>
                    <form action="schedule" method="post">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${schedule.id}">
                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-danger">Xóa</button>
                            <a href="schedule?action=list" class="btn btn-secondary">Hủy</a>
                        </div>
                    </form>
                </c:when>
                <c:otherwise>
                    <p class="text-danger text-center">Không tìm thấy thời khóa biểu để xóa!</p>
                    <a href="schedule?action=list" class="btn btn-secondary mt-3">Quay lại danh sách</a>
                </c:otherwise>
            </c:choose>
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success">${sessionScope.message}</div>
                <c:remove var="message" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger">${sessionScope.error}</div>
                <c:remove var="error" scope="session"/>
            </c:if>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>