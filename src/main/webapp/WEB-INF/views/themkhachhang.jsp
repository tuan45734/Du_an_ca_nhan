<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thêm Khách Hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="menu.jsp"/>
<div class="container mt-4">
    <h1 class="text-center mb-4">Thêm Khách Hàng</h1>
    <form class="mb-5">
        <div class="mb-3">
            <label for="hoTen" class="form-label">Họ Tên</label>
            <input type="text" class="form-control" id="hoTen" name="ho_ten" placeholder="Nhập họ tên" required>
        </div>
        <div class="mb-3">
            <label for="diaChi" class="form-label">Địa Chỉ</label>
            <input type="text" class="form-control" id="diaChi" name="dia_chi" placeholder="Nhập địa chỉ" required>
        </div>
        <div class="mb-3">
            <label for="sdt" class="form-label">Số Điện Thoại</label>
            <input type="text" class="form-control" id="sdt" name="sdt" placeholder="Nhập số điện thoại" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Trạng Thái</label>
            <div>
                <input type="radio" id="khachMoi" name="trang_thai" value="khach_moi">
                <label for="khachMoi">Khách Mới</label>
            </div>
            <div>
                <input type="radio" id="khachCu" name="trang_thai" value="khach_cu">
                <label for="khachCu">Khách Cũ</label>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Thêm</button>
    </form>

    <h2 class="text-center mb-4">Danh Sách Khách Hàng</h2>
    <table class="table table-bordered table-striped">
        <thead class="table-primary">
        <tr>
            <th>STT</th>
            <th>Họ Tên</th>
            <th>Địa Chỉ</th>
            <th>Trạng Thái</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${listKH}" var="lkh" varStatus="s">
            <tr>
                <td>${s.count}</td>
                <td>${lkh.ho_ten}</td>
                <td>${lkh.dia_chi}</td>
                <td>${lkh.trang_thai}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
