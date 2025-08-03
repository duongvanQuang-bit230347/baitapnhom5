<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Phòng học</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4" style="color: #ff6f61;">Thêm Phòng học</h2>
        <form action="room" method="post">
            <input type="hidden" name="action" value="add">
            <div class="mb-3">
                <label class="form-label">Số phòng</label>
                <input type="text" name="roomNumber" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Dung lượng</label>
                <input type="number" name="capacity" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Trạng thái</label>
                <select name="status" class="form-select" required>
                    <option value="AVAILABLE">Sẵn sàng</option>
                    <option value="OCCUPIED">Đang sử dụng</option>
                    <option value="MAINTENANCE">Bảo trì</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Vị trí</label>
                <input type="text" name="location" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Ghi chú</label>
                <textarea name="notes" class="form-control"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Thêm</button>
            <a href="room?action=list" class="btn btn-secondary">Hủy</a>
        </form>
    </div>
</body>
</html>