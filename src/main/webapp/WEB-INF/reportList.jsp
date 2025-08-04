<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Báo cáo</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.tailwindcss.com/3.3.3/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1e40af;
            --secondary-color: #60a5fa;
            --accent-color: #93c5fd;
            --schedule-color: #10b981;
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
            margin-bottom: 2rem;
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
        .subtitle {
            color: var(--primary-color);
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }
        .btn-secondary {
            background: linear-gradient(45deg, #6b7280, #9ca3af);
            border: none;
            color: white;
            padding: 0.85rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .btn-secondary:hover {
            background: linear-gradient(45deg, #4b5563, #6b7280);
            transform: scale(1.03);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .btn-secondary::after {
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
        .btn-secondary:hover::after {
            width: 300px;
            height: 300px;
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
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-4px);
        }
        #overviewChart {
            max-width: 400px; /* Giảm chiều rộng tối đa */
            margin: 1rem auto;
            height: 200px; /* Giảm chiều cao cố định */
            max-height: 200px; /* Giới hạn chiều cao tối đa */
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
            .stat-card {
                padding: 1rem;
            }
            #overviewChart {
                max-width: 100%;
                height: 180px; /* Giảm chiều cao trên màn hình nhỏ */
                max-height: 180px;
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
            <h2 class="title">Báo cáo Hệ thống</h2>
            <div class="row">
                <div class="col-md-3 col-sm-6 mb-4">
                    <div class="stat-card">
                        <h5 class="text-center text-[#1e40af] font-semibold">Tổng số người dùng</h5>
                        <p class="text-center text-2xl font-bold">${userCount}</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-4">
                    <div class="stat-card">
                        <h5 class="text-center text-[#1e40af] font-semibold">Tổng số phòng học</h5>
                        <p class="text-center text-2xl font-bold">${roomCount}</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-4">
                    <div class="stat-card">
                        <h5 class="text-center text-[#1e40af] font-semibold">Tổng số thiết bị</h5>
                        <p class="text-center text-2xl font-bold">${deviceCount}</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-4">
                    <div class="stat-card">
                        <h5 class="text-center text-[#1e40af] font-semibold">Tổng số thời khóa biểu</h5>
                        <p class="text-center text-2xl font-bold">${scheduleCount}</p>
                    </div>
                </div>
            </div>
            <div class="card">
                <h4 class="subtitle">Biểu đồ Tổng quan</h4>
                <canvas id="overviewChart"></canvas>
            </div>
            <div class="mt-5 text-center">
                <a href="dashboard" class="btn btn-secondary">Quay lại</a>
            </div>
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
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-success">${sessionScope.message}</div>
        <c:remove var="message" scope="session"/>
    </c:if>
    <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-danger">${sessionScope.error}</div>
        <c:remove var="error" scope="session"/>
    </c:if>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }

        // Initialize Chart.js bar chart with controlled size
        const ctx = document.getElementById('overviewChart').getContext('2d');
        const userCount = ${userCount != null ? userCount : 0};
        const roomCount = ${roomCount != null ? roomCount : 0};
        const deviceCount = ${deviceCount != null ? deviceCount : 0};
        const scheduleCount = ${scheduleCount != null ? scheduleCount : 0};

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Người dùng', 'Phòng học', 'Thiết bị', 'Thời khóa biểu'],
                datasets: [{
                    label: 'Số lượng',
                    data: [userCount, roomCount, deviceCount, scheduleCount],
                    backgroundColor: [
                        'rgba(30, 64, 175, 0.8)',
                        'rgba(96, 165, 250, 0.8)',
                        'rgba(147, 197, 253, 0.8)',
                        'rgba(16, 185, 129, 0.8)'
                    ],
                    borderColor: [
                        'rgba(30, 64, 175, 1)',
                        'rgba(96, 165, 250, 1)',
                        'rgba(147, 197, 253, 1)',
                        'rgba(16, 185, 129, 1)'
                    ],
                    borderWidth: 1,
                    barThickness: 25, // Giảm độ dày cột
                    borderRadius: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false, // Tắt để kiểm soát kích thước
                aspectRatio: 1.5, // Tỷ lệ khung hình cố định để tránh dãn dài
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Số lượng',
                            font: { size: 12 }
                        },
                        ticks: {
                            font: { size: 10 }
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Danh mục',
                            font: { size: 12 }
                        },
                        ticks: {
                            font: { size: 10 }
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleFont: { size: 12 },
                        bodyFont: { size: 10 }
                    }
                },
                animation: {
                    duration: 800,
                    easing: 'easeOutQuad'
                },
                barPercentage: 0.5, // Giảm chiều rộng cột
                categoryPercentage: 0.8 // Điều chỉnh khoảng cách giữa cột
            }
        });
    </script>
</body>
</html>