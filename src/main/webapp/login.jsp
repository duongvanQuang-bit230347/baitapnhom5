<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đăng nhập Hệ thống - CMC University</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('${pageContext.request.contextPath}/images/cmc.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Noto Sans', sans-serif;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(10px);
            max-width: 400px;
            width: 100%;
        }
        .login-title {
            color: #1e40af;
            font-size: 2.25rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 1.5rem;
            text-transform: uppercase;
        }
        .form-control {
            border-radius: 12px;
            border: 1px solid #d1d5db;
            padding: 0.75rem;
            transition: border-color 0.3s ease;
        }
        .form-control:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
        }
        .btn-login {
            background: linear-gradient(45deg, #3b82f6, #60a5fa);
            border: none;
            color: white;
            padding: 0.75rem;
            border-radius: 12px;
            font-weight: 600;
            transition: transform 0.3s ease, background 0.3s ease;
        }
        .btn-login:hover {
            transform: scale(1.05);
            background: linear-gradient(45deg, #2563eb, #3b82f6);
        }
        .forgot-password {
            display: block;
            text-align: center;
            margin-top: 1rem;
            color: #3b82f6;
            text-decoration: none;
            font-size: 0.9rem;
        }
        .forgot-password:hover {
            text-decoration: underline;
        }
        .logo {
            display: block;
            margin: 0 auto 1rem;
            max-width: 120px;
        }
    </style>
</head>
<body>
    <div class="login-card">
        <img src="${pageContext.request.contextPath}/images/cmc-university-logo.png" alt="CMC University Logo" class="logo">
        <h2 class="login-title">Đăng nhập</h2>
        <form action="auth" method="post">
            <input type="hidden" name="action" value="login">
            <div class="mb-4">
                <label class="form-label text-gray-700 font-medium">Tên đăng nhập</label>
                <input type="text" name="username" class="form-control" placeholder="Nhập tên đăng nhập" required>
            </div>
            <div class="mb-4">
                <label class="form-label text-gray-700 font-medium">Mật khẩu</label>
                <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
            </div>
            <button type="submit" class="btn btn-login w-full">Đăng nhập</button>
            <a href="forgot-password" class="forgot-password">Quên mật khẩu?</a>
            <c:if test="${not empty error}">
                <p class="text-red-500 text-center mt-3 text-sm">${error}</p>
            </c:if>
        </form>
    </div>
</body>
</html>