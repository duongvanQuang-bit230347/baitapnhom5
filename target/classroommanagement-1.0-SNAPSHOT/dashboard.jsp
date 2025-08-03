<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bảng điều khiển - CMC University</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
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
            flex-grow: 1;
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
            margin-bottom: 1.5rem;
            letter-spacing: -0.025em;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }
        .subtitle {
            color: #374151;
            font-size: 1.25rem;
            font-weight: 600;
            text-align: center;
            margin-bottom: 2rem;
        }
        .text {
            color: #374151;
            font-size: 1.05rem;
            line-height: 1.75;
            margin-bottom: 2rem;
            text-align: justify;
        }
        .section {
            margin-bottom: 2.5rem;
            animation: fadeIn 0.5s ease-out;
        }
        .section-image {
            max-width: 100%;
            height: auto;
            border-radius: 12px;
            margin-top: 1rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .section-image:hover {
            transform: scale(1.02);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
        }
        .stat-card {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            margin: 0.5rem;
            transition: all 0.3s ease;
        }
        .stat-card:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.03);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .btn-custom {
            background: linear-gradient(45deg, var(--secondary-color), var(--accent-color));
            border: none;
            color: white;
            padding: 0.85rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: inline-block;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .btn-custom:hover {
            background: linear-gradient(45deg, #2563eb, var(--secondary-color));
            transform: scale(1.03);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .btn-custom::after {
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
        .btn-custom:hover::after {
            width: 300px;
            height: 300px;
        }
        .btn-logout {
            background: linear-gradient(45deg, #ef4444, #f87171);
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
        .btn-logout:hover {
            background: linear-gradient(45deg, #dc2626, #ef4444);
            transform: scale(1.03);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .btn-logout::after {
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
        .btn-logout:hover::after {
            width: 300px;
            height: 300px;
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
            .subtitle {
                font-size: 1.1rem;
            }
            .text {
                font-size: 0.95rem;
            }
            .logo {
                max-width: 110px;
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
        <img src="${pageContext.request.contextPath}/images/cmc-university-logo.png" alt="CMC University Logo" class="logo mb-4">
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
            <h2 class="title">Chào mừng đến hệ thống quản lý phòng học</h2>
            <h3 class="subtitle">Chào, ${user.fullName} (${user.role})</h3>
            <div class="section">
                <h4 class="text-lg font-semibold text-gray-700 mb-2">Tầm Nhìn Hệ Thống</h4>
                <p class="text">
                    Hệ thống Quản lý Phòng học của CMC University được thiết kế với tầm nhìn dài hạn nhằm xây dựng một môi trường học tập thông minh và hiện đại, nơi mọi tài nguyên học tập được tối ưu hóa một cách hiệu quả nhất. Chúng tôi hướng tới việc loại bỏ hoàn toàn các vấn đề như xung đột lịch trình, lãng phí không gian, và thiếu hụt thông tin, mang đến cho bạn một trải nghiệm học tập mượt mà và chuyên nghiệp. Hãy tưởng tượng một ngày không còn những lo lắng về việc tìm phòng học phù hợp hay kiểm tra lịch trình – tất cả đều được tự động hóa nhờ vào công nghệ tiên tiến mà hệ thống này mang lại. Đây không chỉ là một công cụ quản lý, mà còn là cầu nối giúp kết nối giữa sinh viên, giáo viên, và ban quản lý để cùng nhau xây dựng một cộng đồng học thuật vững mạnh.
                </p>
                <img src="${pageContext.request.contextPath}/images/123w.jpg" alt="Tầm nhìn hệ thống" class="section-image">
            </div>
            <div class="section">
                <h4 class="text-lg font-semibold text-gray-700 mb-2">Lợi Ích Cho Bạn</h4>
                <p class="text">
                    Với vai trò của bạn trong hệ thống, bạn sẽ nhận được vô số lợi ích vượt trội mà hệ thống này mang lại. Đối với quản trị viên, việc quản lý phòng học trở nên dễ dàng hơn bao giờ hết với giao diện trực quan và các công cụ phân tích chi tiết. Giáo viên có thể linh hoạt đặt phòng theo thời gian thực, đảm bảo không bỏ lỡ bất kỳ buổi học nào, trong khi sinh viên được tự do lựa chọn không gian học tập phù hợp với nhu cầu cá nhân. Ngoài ra, hệ thống cung cấp báo cáo chi tiết về tình trạng sử dụng phòng học và thiết bị, giúp bạn tiết kiệm thời gian và đưa ra quyết định sáng suốt. Tận dụng công cụ này ngay hôm nay để nâng cao hiệu quả công việc, tối ưu hóa lịch trình, và trải nghiệm một môi trường học tập hoàn toàn mới mẻ!
                </p>
                <img src="${pageContext.request.contextPath}/images/123w.jpg" alt="Lợi ích" class="section-image">
            </div>
            <div class="section">
                <h4 class="text-lg font-semibold text-gray-700 mb-2">Tính Năng Nổi Bật</h4>
                <p class="text">
                    Hệ thống Quản lý Phòng học của chúng tôi tự hào sở hữu hàng loạt tính năng vượt trội để đáp ứng mọi nhu cầu của bạn. Đặt phòng theo thời gian thực cho phép bạn nhanh chóng chọn phòng học phù hợp mà không cần chờ đợi phê duyệt thủ công. Chức năng theo dõi thiết bị giúp bạn kiểm tra tình trạng và lịch sử bảo trì của các thiết bị trong phòng, đảm bảo mọi thứ luôn sẵn sàng sử dụng. Ngoài ra, với công cụ phân tích dữ liệu học tập, bạn có thể xem xét xu hướng sử dụng phòng học qua thời gian, từ đó đưa ra các chiến lược quản lý hiệu quả hơn. Mọi tính năng đều được thiết kế với mục tiêu hỗ trợ bạn đạt được thành công tối đa trong vai trò của mình, từ quản lý đến giảng dạy và học tập.
                </p>
                <img src="${pageContext.request.contextPath}/images/123w.jpg" alt="Tính năng nổi bật" class="section-image">
            </div>
            <div class="section">
                <h4 class="text-lg font-semibold text-gray-700 mb-2">Thông báo Quan trọng</h4>
                <ul class="text-left text-gray-600">
                    <li class="mb-2">⏰ Lịch bảo trì phòng 101 vào 14:00 ngày 10/07/2025.</li>
                    <li class="mb-2">📢 Đăng ký phòng học cho kỳ mới bắt đầu từ 12/07/2025.</li>
                    <li class="mb-2">⚠️ Vui lòng kiểm tra lịch sử đặt phòng trước khi tạo yêu cầu mới.</li>
                </ul>
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
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('active');
        }
    </script>
</body>
</html>