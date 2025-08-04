<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đổi mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('${pageContext.request.contextPath}/images/cmc.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            background-color: rgba(255, 255, 255, 0.95); /* Slightly transparent white for better contrast */
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="card p-4" style="max-width: 400px; margin: auto;">
            <h2 class="text-center mb-4" style="color: #ff6f61;">Đổi mật khẩu</h2>
            <form action="auth" method="post">
                <input type="hidden" name="action" value="changePassword">
                <div class="mb-3">
                    <label class="form-label">Mật khẩu cũ</label>
                    <input type="password" name="oldPassword" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Mật khẩu mới</label>
                    <input type="password" name="newPassword" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Cập nhật</button>
                <c:if test="${not empty error}"><p class="text-danger text-center mt-2">${error}</p></c:if>
                <c:if test="${not empty message}"><p class="text-success text-center mt-2">${message}</p></c:if>
            </form>
        </div>
    </div>
</body>
</html>