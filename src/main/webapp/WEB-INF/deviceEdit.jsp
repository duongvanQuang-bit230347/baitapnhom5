<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa Thiết Bị</title>
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
        .form-label {
            color: #374151;
            font-weight: 600;
        }
        .btn-primary {
            background: linear-gradient(45deg, #ff6f61, #e53e3e);
            border: none;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: linear-gradient(45deg, #e53e3e, #ff6f61);
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
    <script>
        function validateForm() {
            const name = document.querySelector('input[name="name"]').value;
            if (!name.match(/^[A-Za-z0-9\s-]+$/)) {
                alert("Tên thiết bị chỉ được chứa chữ cái, số, khoảng trắng và dấu gạch ngang!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="card">
            <h2 class="mb-4 text-center text-2xl font-bold text-[#ff6f61]">Sửa Thiết Bị</h2>
            <form action="device" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${device.id}">
                <div class="mb-3">
                    <label class="form-label">Tên Thiết Bị</label>
                    <input type="text" name="name" class="form-control" value="${device.name}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Phòng</label>
                    <select name="roomId" class="form-select" required>
                        <c:forEach var="room" items="${rooms}">
                            <option value="${room.id}" ${device.roomId == room.id ? 'selected' : ''}>${room.roomNumber} (${room.status})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Trạng Thái</label>
                    <select name="status" class="form-select" required>
                        <option value="WORKING" ${device.status == 'WORKING' ? 'selected' : ''}>Đang Hoạt Động</option>
                        <option value="BROKEN" ${device.status == 'BROKEN' ? 'selected' : ''}>Hỏng</option>
                        <option value="MAINTENANCE" ${device.status == 'MAINTENANCE' ? 'selected' : ''}>Bảo Trì</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Ghi Chú Tình Trạng</label>
                    <textarea name="conditionNotes" class="form-control">${device.conditionNotes}</textarea>
                </div>
                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-primary">Cập Nhật</button>
                    <a href="device?action=list" class="btn btn-secondary">Hủy</a>
                </div>
            </form>
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