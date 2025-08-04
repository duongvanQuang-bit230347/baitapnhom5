<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4" style="color: #ff6f61;">Thêm Tài khoản</h2>
        <form action="user" method="post">
            <input type="hidden" name="action" value="add">
            <div class="mb-3">
                <label class="form-label">Tên đăng nhập</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Mật khẩu</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Vai trò</label>
                <select name="role" class="form-select" required>
                    <option value="ADMIN">Admin</option>
                    <option value="GV">Giáo viên</option>
                    <option value="SV">Sinh viên</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Họ tên</label>
                <input type="text" name="fullName" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Số điện thoại</label>
                <input type="text" name="phone" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">Địa chỉ</label>
                <input type="text" name="address" class="form-control">
            </div>
            <button type="submit" class="btn btn-primary">Thêm</button>
            <a href="user?action=list" class="btn btn-secondary">Hủy</a>
        </form>
    </div>
</body>
</html>