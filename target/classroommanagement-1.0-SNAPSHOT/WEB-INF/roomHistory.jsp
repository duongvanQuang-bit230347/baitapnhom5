<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Sử Dụng Phòng</title>
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
        .table {
            table-layout: fixed;
            width: 100%;
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
            <h2 class="mb-4 text-center text-2xl font-bold text-[#ff6f61]">Lịch Sử Sử Dụng Phòng</h2>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Phòng</th>
                        <th>Người Dùng</th>
                        <th>Ngày Đặt</th>
                        <th>Giờ Bắt Đầu</th>
                        <th>Giờ Kết Thúc</th>
                        <th>Trạng Thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${history}">
                        <tr>
                            <td>${booking.roomId}</td>
                            <td>${booking.userName}</td>
                            <td>${booking.bookingDate}</td>
                            <td>${booking.startTime}</td>
                            <td>${booking.endTime}</td>
                            <td>${booking.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <a href="room?action=list" class="btn btn-secondary mt-3">Quay Lại</a>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
        </div>
    </div>
</body>
</html>