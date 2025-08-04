<%@ page contentType="text/html;charset=UTF-8" language="java" %>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
   <!DOCTYPE html>
   <html>
   <head>
       <title>Giới thiệu Hệ thống - CMC University</title>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
       <link href="${pageContext.request.contextPath}/css/tailwind.min.css" rel="stylesheet">
       <style>
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
           }
           .sidebar {
               width: 250px;
               background: rgba(255, 255, 255, 0.1);
               border-right: 1px solid rgba(255, 255, 255, 0.2);
               padding: 2rem 1rem;
               height: 100vh;
               position: fixed;
               box-shadow: 4px 0 16px rgba(0, 0, 0, 0.1);
               backdrop-filter: blur(8px);
               -webkit-backdrop-filter: blur(8px);
               transition: transform 0.3s ease;
           }
           .sidebar:hover {
               transform: translateX(-5px);
           }
           .main-content {
               margin-left: 250px;
               padding: 2rem;
               width: calc(100% - 250px);
               min-height: 100vh;
           }
           .card {
               background: rgba(255, 255, 255, 0.1);
               border-radius: 20px;
               padding: 2.5rem;
               box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
               backdrop-filter: blur(12px);
               -webkit-backdrop-filter: blur(12px);
               border: 1px solid rgba(255, 255, 255, 0.2);
               transition: transform 0.3s ease;
           }
           .card:hover {
               transform: translateY(-5px);
           }
           .title {
               color: #1e40af;
               font-size: 2.75rem;
               font-weight: 800;
               text-align: center;
               margin-bottom: 1.5rem;
               letter-spacing: 1px;
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
               font-size: 1.1rem;
               line-height: 1.6;
               margin-bottom: 2.5rem;
               text-align: center;
           }
           .nav-link {
               background: rgba(255, 255, 255, 0.15);
               border-radius: 10px;
               padding: 0.75rem 1rem;
               margin-bottom: 0.5rem;
               color: #3b82f6;
               font-weight: 600;
               font-size: 1.1rem;
               text-decoration: none;
               display: block;
               transition: all 0.3s ease;
           }
           .nav-link:hover {
               background: rgba(255, 255, 255, 0.25);
               color: #2563eb;
               transform: scale(1.02);
           }
           .btn-custom {
               background: linear-gradient(45deg, #3b82f6, #60a5fa);
               border: none;
               color: white;
               padding: 0.85rem 2rem;
               border-radius: 10px;
               font-weight: 600;
               font-size: 1.1rem;
               transition: all 0.3s ease;
               display: inline-block;
               text-align: center;
           }
           .btn-custom:hover {
               background: linear-gradient(45deg, #2563eb, #3b82f6);
               transform: scale(1.02);
           }
           .btn-logout {
               background: linear-gradient(45deg, #ef4444, #f87171);
               border: none;
               color: white;
               padding: 0.85rem 2rem;
               border-radius: 10px;
               font-weight: 600;
               font-size: 1.1rem;
               transition: all 0.3s ease;
           }
           .btn-logout:hover {
               background: linear-gradient(45deg, #dc2626, #ef4444);
               transform: scale(1.02);
           }
           .logo {
               display: block;
               margin: 0 auto 1.5rem;
               max-width: 180px;
               filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
           }
           @media (max-width: 1024px) {
               .sidebar {
                   width: 200px;
               }
               .main-content {
                   margin-left: 200px;
                   width: calc(100% - 200px);
               }
           }
           @media (max-width: 768px) {
               .sidebar {
                   width: 100%;
                   height: auto;
                   position: relative;
                   padding: 1.5rem;
               }
               .main-content {
                   margin-left: 0;
                   width: 100%;
                   padding: 1.5rem;
               }
               .nav-link {
                   display: inline-block;
                   margin: 0.5rem;
                   width: calc(50% - 0.5rem);
               }
               .card {
                   padding: 1.5rem;
               }
               .title {
                   font-size: 2rem;
               }
               .subtitle {
                   font-size: 1rem;
               }
           }
       </style>
   </head>
   <body>
       <c:if test="${empty user}">
           <c:redirect url="/jsp/login.jsp"/>
       </c:if>
       <div class="sidebar">
           <img src="${pageContext.request.contextPath}/images/cmc-university-logo.png" alt="CMC University Logo" class="logo mb-4">
           <h3 class="text-lg font-semibold text-gray-800 mb-3">Menu</h3>
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
               <a href="booking?action=list" class="nav-link">Xem yêu cầu</a>
               <a href="schedule?action=list" class="nav-link">Thời khóa biểu</a>
           </c:if>
           <c:if test="${user.role == 'SV'}">
               <a href="booking?action=create" class="nav-link">Đặt phòng</a>
               <a href="booking?action=list" class="nav-link">Xem yêu cầu</a>
           </c:if>
           <a href="auth?action=changePassword" class="nav-link mt-4">Đổi mật khẩu</a>
           <a href="auth?action=logout" class="btn-logout mt-4 w-full text-center">Đăng xuất</a>
       </div>
       <div class="main-content">
           <div class="card">
               <h2 class="title">Chào mừng đến Hệ thống Quản lý Phòng học</h2>
               <h3 class="subtitle">Chào, ${user.fullName} (${user.role})!</h3>
               <p class="text">
                   Hệ thống Quản lý Phòng học của CMC University là nền tảng hiện đại được thiết kế để hỗ trợ quản lý hiệu quả các tài nguyên học tập. 
                   Dựa trên vai trò của bạn, bạn có thể truy cập các chức năng như quản lý tài khoản, phòng học, đặt phòng, thời khóa biểu, thiết bị, và báo cáo. 
                   Vui lòng sử dụng menu bên trái để bắt đầu khám phá và quản lý hệ thống.
               </p>
           </div>
       </div>
   </body>
   </html>