<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Thời Khóa Biểu</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.tailwindcss.com/3.3.3/tailwind.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
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
        $(document).ready(function(){
            $('#scheduleDate').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true
            });
        });
        function validateForm() {
            const startTime = document.querySelector('input[name="startTime"]').value;
            const endTime = document.querySelector('input[name="endTime"]').value;
            const scheduleDate = document.querySelector('input[name="scheduleDate"]').value;
            if (!scheduleDate.match(/^\d{4}-\d{2}-\d{2}$/)) {
                alert("Vui lòng chọn ngày hợp lệ!");
                return false;
            }
            if (endTime <= startTime) {
                alert("Giờ kết thúc phải sau giờ bắt đầu!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="card">
            <h2 class="mb-4 text-center text-2xl font-bold text-[#ff6f61]">Thêm Thời Khóa Biểu</h2>
            <form action="schedule" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="add">
                <div class="mb-3">
                    <label class="form-label">Phòng</label>
                    <select name="roomId" class="form-select" required>
                        <c:forEach var="room" items="${rooms}">
                            <option value="${room.id}">${room.roomNumber} (${room.status})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Người Dùng</label>
                    <select name="userId" class="form-select" required>
                        <c:forEach var="user" items="${users}">
                            <option value="${user.id}">${user.fullName} (${user.role})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Ngày</label>
                    <input type="text" name="scheduleDate" id="scheduleDate" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Giờ Bắt Đầu</label>
                    <input type="time" name="startTime" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Giờ Kết Thúc</label>
                    <input type="time" name="endTime" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Môn Học</label>
                    <input type="text" name="subject" class="form-control" required>
                </div>
                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-primary">Thêm</button>
                    <a href="schedule?action=list" class="btn btn-secondary">Hủy</a>
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