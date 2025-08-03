<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tạo Yêu cầu Đặt phòng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <script>
        $(document).ready(function(){
            $('#bookingDate').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true
            });
        });
    </script>
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4" style="color: #ff6f61;">Tạo Yêu cầu Đặt phòng</h2>
        <form action="booking" method="post">
            <input type="hidden" name="action" value="create">
            <div class="mb-3">
                <label class="form-label">Phòng</label>
                <select name="roomId" class="form-select" required>
                    <c:forEach var="room" items="${rooms}">
                        <option value="${room.id}">${room.roomNumber} (${room.status})</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Ngày</label>
                <input type="text" name="bookingDate" id="bookingDate" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Giờ bắt đầu</label>
                <input type="time" name="startTime" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Giờ kết thúc</label>
                <input type="time" name="endTime" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Lý do</label>
                <textarea name="reason" class="form-control" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Gửi yêu cầu</button>
            <a href="booking?action=list" class="btn btn-secondary">Hủy</a>
        </form>
    </div>
</body>
</html>