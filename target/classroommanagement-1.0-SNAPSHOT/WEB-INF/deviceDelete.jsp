<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xóa Thiết Bị</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.tailwindcss.com/3.3.3/tailwind.min.css" rel="stylesheet">
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
        .btn-danger {
            background: linear-gradient(45deg, #ef4444, #f87171);
            border: none;
            transition: all 0.3s ease;
        }
        .btn-danger:hover {
            background: linear-gradient(45deg, #dc2626, #ef4444);
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
</head>
<body>
    <div class="container">
        <div class="card">
            <h2 class="mb-4 text-center text-2xl font-bold text-[#ff6f61]">Xóa Thiết Bị</h2>
            <h4 class="mb-3">Bạn có chắc chắn muốn xóa thiết bị này?</h4>
            <p><strong>Tên Thiết Bị:</strong> ${device.name}</p>
            <p><strong>Phòng:</strong> ${device.roomId}</p>
            <p><strong>Trạng Thái:</strong> ${device.status}</p>
            <p><strong>Ghi Chú:</strong> ${device.conditionNotes}</p>
            <form action="device" method="post">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" value="${device.id}">
                <div class="d-flex justify-content-between">
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmModal">Xóa</button>
                    <a href="device?action=list" class="btn btn-secondary">Hủy</a>
                </div>
            </form>
            <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmModalLabel">Xác Nhận Xóa</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Bạn có chắc chắn muốn xóa thiết bị này?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <form action="device" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${device.id}">
                                <button type="submit" class="btn btn-danger">Xóa</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>