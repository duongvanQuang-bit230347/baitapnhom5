<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Tài khoản</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <style>
        :root {
            --primary-color: #1e40af;
            --secondary-color: #60a5fa;
            --accent-color: #93c5fd;
            --bg-color: #f8fafc;
            --card-bg: rgba(255, 255, 255, 0.98);
            --text-color: #111827;
        }
        body {
            background-image: url('${pageContext.request.contextPath}/images/background.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
            -webkit-font-smoothing: antialiased;
        }
        .sidebar {
            width: 210px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-right: 1px solid rgba(255, 255, 255, 0.2);
            padding: 2rem 1rem;
            height: 100vh;
            position: fixed;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.15);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            transition: all 0.3s ease;
            color: #ffffff;
            z-index: 1000;
        }
        .sidebar:hover {
            box-shadow: 6px 0 24px rgba(0, 0, 0, 0.2);
            transform: translateX(2px);
        }
        .sidebar h3 {
            color: #ffffff;
            font-weight: 700;
            font-size: 1.3rem;
            margin-bottom: 1.5rem;
            text-align: center;
            letter-spacing: 0.5px;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }
        .sidebar .nav-link {
            background: rgba(255, 255, 255, 0.15);
            color: #ffffff;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
            font-size: 1rem;
            text-decoration: none;
            display: block;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .sidebar .nav-link:hover {
            background: rgba(255, 255, 255, 0.3);
            color: #e0f2fe;
            transform: translateX(4px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .sidebar .nav-link::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.3s ease, height 0.3s ease;
            z-index: -1;
        }
        .sidebar .nav-link:hover::after {
            width: 300px;
            height: 300px;
        }
        .main-content {
            margin-left: 210px;
            padding: 2.5rem;
            width: calc(100% - 210px);
            min-height: calc(100vh - 120px);
            display: flex;
            flex-direction: column;
            background: var(--bg-color);
            transition: margin-left 0.3s ease;
        }
        .card {
            background: var(--card-bg);
            border-radius: 18px;
            padding: 2.5rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            width: 100%;
            animation: fadeIn 0.5s ease-out;
        }
        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
        }
        .title {
            color: var(--primary-color);
            font-size: 2.6rem;
            font-weight: 800;
            text-align: center;
            margin-bottom: 2rem;
            letter-spacing: -0.025em;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }
        .btn-success {
            background: linear-gradient(45deg, #22c55e, #4ade80);
            border: none;
            color: white;
            padding: 0.85rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .btn-success:hover {
            background: linear-gradient(45deg, #16a34a, #22c55e);
            transform: scale(1.03);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .btn-success::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.3s ease, height 0.3s ease;
            z-index: -1;
        }
        .btn-success:hover::after {
            width: 300px;
            height: 300px;
        }
        .btn-warning {
            background: linear-gradient(45deg, #f59e0b, #fbbf24);
            border: none;
            color: white;
            padding: 0.85rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-right: 0.5rem;
        }
        .btn-warning:hover {
            background: linear-gradient(45deg, #d97706, #f59e0b);
            transform: scale(1.03);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .btn-warning::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.3s ease, height 0.3s ease;
            z-index: -1;
        }
        .btn-warning:hover::after {
            width: 300px;
            height: 300px;
        }
        .btn-danger {
            background: linear-gradient(45deg, #ef4444, #f87171);
            border: none;
            color: white;
            padding: 0.85rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .btn-danger:hover {
            background: linear-gradient(45deg, #dc2626, #ef4444);
            transform: scale(1.03);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .btn-danger::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transform: translate(-50%, -50%);
            transition: width 0.3s ease, height 0.3s ease;
            z-index: -1;
        }
        .btn-danger:hover::after {
            width: 300px;
            height: 300px;
        }
        .table {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            animation: fadeIn 0.5s ease-out;
            width: 100%;
        }
        .table th, .table td {
            padding: 1rem;
            vertical-align: middle;
            font-size: 0.95rem;
        }
        .table th {
            background: var(--secondary-color);
            color: white;
            font-weight: 600;
        }
        .table tbody tr {
            transition: background 0.3s ease;
        }
        .table tbody tr:hover {
            background: rgba(0, 0, 0, 0.05);
        }
        .alert {
            position: fixed;
            top: 1rem;
            right: 1rem;
            z-index: 2000;
            border-radius: 8px;
            padding: 1rem 1.5rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            animation: slideIn 0.5s ease-out, slideOut 0.5s ease-out 4s forwards;
            max-width: 400px;
        }
        .alert-success {
            background: linear-gradient(45deg, #22c55e, #4ade80);
            color: white;
        }
        .alert-danger {
            background: linear-gradient(45deg, #ef4444, #f87171);
            color: white;
        }
        .logo {
            display: block;
            margin: 0 auto 1.5rem;
            max-width: 130px;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.2));
            transition: transform 0.3s ease, filter 0.3s ease;
        }
        .logo:hover {
            transform: scale(1.05);
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.3));
        }
        .footer {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: #ffffff;
            padding: 1.5rem;
            text-align: center;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            margin-left: 210px;
            width: calc(100% - 210px);
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            align-items: center;
            box-shadow: 0 -2px 8px rgba(0, 0, 0, 0.1);
        }
        .footer a {
            color: #e0f2fe;
            text-decoration: none;
            margin: 0 0.5rem;
            font-weight: 600;
            font-size: 0.95rem;
            transition: color 0.3s ease, transform 0.3s ease;
        }
        .footer a:hover {
            color: #ffffff;
            text-decoration: underline;
            transform: scale(1.05);
        }
        .footer p {
            margin: 0.5rem 0;
            font-size: 0.95rem;
        }
        .footer .text-lg {
            background: linear-gradient(90deg, #ffffff, #e0f2fe);
            -webkit-background-clip: text;
            color: transparent;
            font-weight: 700;
            font-size: 1.1rem;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        @keyframes slideOut {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }
        @media (max-width: 1024px) {
            .sidebar {
                width: 190px;
            }
            .main-content {
                margin-left: 190px;
                width: calc(100% - 190px);
            }
            .footer {
                margin-left: 190px;
                width: calc(100% - 190px);
            }
        }
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: fixed;
                top: 0;
                left: -100%;
                padding: 1.5rem;
                transition: left 0.3s ease;
                z-index: 1000;
            }
            .sidebar.active {
                left: 0;
            }
            .main-content {
                margin-left: 0;
                width: 100%;
                padding: 1.5rem;
            }
            .footer {
                margin-left: 0;
                width: 100%;
                flex-direction: column;
                padding: 1.5rem;
            }
            .nav-link {
                display: block;
                margin: 0.5rem 0;
                width: 100%;
            }
            .card {
                padding: 1.5rem;
            }
            .title {
                font-size: 2.2rem;
            }
            .logo {
                max-width: 110px;
            }
            .table th, .table td {
                font-size: 0.9rem;
                padding: 0.75rem;
            }
            .toggle-menu {
                display: block;
                position: fixed;
                top: 1rem;
                left: 1rem;
                z-index: 1100;
                background: var(--secondary-color);
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            .toggle-menu:hover {
                background: #2563eb;
                transform: scale(1.05);
            }
        }
    </style>
</head>
<body>
    <c:if test="${empty user}">
        <c:redirect url="/jsp/login.jsp"/>
    </c:if>
    <div class="toggle-menu" onclick="toggleSidebar()">☰ Menu</div>
    <div class="sidebar">
        <img src="${pageContext.request.contextPath}/images/cmc-university-logo.png" alt="CMC University Logo" class="logo">
        <h3 class="text-lg font-semibold mb-3">Menu</h3>
        <c:if test="${user.role == 'ADMIN'}">
            <a href="user?action=list" class="nav-link">Quản lý Tài khoản</a>
            <a href="room?action=list" class="nav-link">Quản lý Phòng học</a>
            <a href="booking?action=list" class="nav-link">Quản lý Đặt phòng</a>
            <a href="schedule?action=list" class="nav-link">Thời khóa biểu</a>
            <a href="device?action=list" class="nav-link">Quản lý Thiết bị</a>
            <a href="report?action=list" class="nav-link">Báo cáo</a>
        </c:if>
        <c:if test="${user.role == 'GV'}">
            <a href="booking?action=create" class="nav-link">Đặt phòng</a>
            <a href="schedule?action=list" class="nav-link">Thời khóa biểu</a>
            <a href="profile" class="nav-link">Hồ sơ cá nhân</a>
        </c:if>
        <c:if test="${user.role == 'SV'}">
            <a href="booking?action=create" class="nav-link">Đặt phòng</a>
            <a href="booking?action=list" class="nav-link">Xem yêu cầu</a>
            <a href="profile" class="nav-link">Hồ sơ cá nhân</a>
        </c:if>
        <a href="auth?action=changePassword" class="nav-link mt-4">Đổi mật khẩu</a>
        <a href="auth?action=logout" class="btn-logout mt-4 w-full text-center">Đăng xuất</a>
    </div>
    <div class="main-content">
        <div class="card">
            <h2 class="title">Quản lý Tài khoản</h2>
            <c:if test="${user.role == 'ADMIN'}">
                <div class="mb-5">
                    <a href="user?action=addForm" class="btn btn-success">Thêm tài khoản</a>
                </div>
            </c:if>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên đăng nhập</th>
                        <th>Họ và tên</th>
                        <th>Email</th>
                        <th>Quyền</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td>
                                <c:if test="${user.role == 'ADMIN'}">
                                    <span class="badge bg-secondary">Quản trị viên</span>
                                </c:if>
                                <c:if test="${user.role != 'ADMIN'}">
                                    <a href="user?action=editForm&id=${user.id}" class="btn btn-warning btn-sm">Sửa</a>
                                    <button type="button" class="btn btn-danger btn-sm" onclick="confirmDeleteUser(${user.id})">Xóa</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="footer">
        <p class="text-lg font-semibold" style="background: linear-gradient(90deg, #ffffff, #e0f2fe); -webkit-background-clip: text; color: transparent;">© 2025 CMC University</p>
        <p>
            <span class="text-md">Liên hệ: </span>
            <a href="mailto:support@cmc.edu.vn" class="text-md">support@cmc.edu.vn</a> | 
            <span class="text-md">Điện thoại: </span>
            <a href="tel:+84123456789" class="text-md">(84) 123 456 789</a>
        </p>
        <p>
            <a href="#" class="text-md">Chính sách Bảo mật</a> | 
            <a href="#" class="text-md">Điều khoản Sử dụng</a> | 
            <a href="#" class="text-md">Hỗ trợ</a>
        </p>
    </div>
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }
        function confirmDeleteUser(id) {
            Swal.fire({
                title: 'Xác nhận xóa',
                text: 'Bạn có muốn xóa tài khoản này không?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#ef4444',
                cancelButtonColor: '#6b7280',
                confirmButtonText: 'Xóa',
                cancelButtonText: 'Hủy'
            }).then((result) => {
                if (result.isConfirmed) {
                    const form = document.createElement('form');
                    form.method = 'post';
                    form.action = 'user';
                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'delete';
                    const idInput = document.createElement('input');
                    idInput.type = 'hidden';
                    idInput.name = 'id';
                    idInput.value = id;
                    form.appendChild(actionInput);
                    form.appendChild(idInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            });
        }
    </script>
</body>
</html>