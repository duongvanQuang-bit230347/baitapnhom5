<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa Phòng Học</title>
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
            const roomNumber = document.querySelector('input[name="roomNumber"]').value;
            const capacity = document.querySelector('input[name="capacity"]').value;
            if (!roomNumber.match(/^[A-Za-z0-9-]+$/)) {
                alert("Số phòng chỉ được chứa chữ cái, số và dấu gạch ngang!");
                return false;
            }
            if (capacity <= 0) {
                alert("Dung lượng phải lớn hơn 0!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="card">
            <h2 class="mb-4 text-center text-2xl font-bold text-[#ff6f61]">Sửa Phòng Học</h2>
            <form action="room" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${room.id}">
                <div class="mb-3">
                    <label class="form-label">Số phòng</label>
                    <input type="text" name="roomNumber" class="form-control" value="${room.roomNumber}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Dung lượng</label>
                    <input type="number" name="capacity" class="form-control" value="${room.capacity}" required min="1">
                </div>
                <div class="mb-3">
                    <label class="form-label">Trạng thái</label>
                    <select name="status" class="form-select" required>
                        <option value="AVAILABLE" ${room.status == 'AVAILABLE' ? 'selected' : ''}>Sẵn sàng</option>
                        <option value="OCCUPIED" ${room.status == 'OCCUPIED' ? 'selected' : ''}>Đang sử dụng</option>
                        <option value="MAINTENANCE" ${room.status == 'MAINTENANCE' ? 'selected' : ''}>Bảo trì</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Vị trí</label>
                    <input type="text" name="location" class="form-control" value="${room.location}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Ghi chú</label>
                    <textarea name="notes" class="form-control">${room.notes}</textarea>
                </div>
                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                    <a href="room?action=list" class="btn btn-secondary">Hủy</a>
                </div>
            </form>
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
</body>
</html>