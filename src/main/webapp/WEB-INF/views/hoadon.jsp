<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý hóa đơn</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- Include menu -->
<jsp:include page="menu.jsp"/>

<div class="container mt-4">
    <h2 class="text-center mb-4">Tìm Hóa Đơn Trong Khoảng Ngày</h2>

    <!-- Form to search for invoices by date range -->
    <form action="/asm2/hoa-don/tim" method="get" class="row g-3">
        <div class="col-md-6">
            <label for="ngayBD" class="form-label">Ngày bắt đầu</label>
            <input type="date" class="form-control" id="ngayBD" name="ngayBD" required>
        </div>
        <div class="col-md-6">
            <label for="ngayKT" class="form-label">Ngày kết thúc</label>
            <input type="date" class="form-control" id="ngayKT" name="ngayKT" required>
        </div>
        <div class="col-12 text-center">
            <button type="submit" class="btn btn-primary">Tìm</button>
        </div>
    </form>

<p>tong tien :<input type="text" value="${T}" readonly></p>
    <!-- Navigation links -->
    <div class="mt-4">
        <a href="/asm2/hoa-don/da-thanh-toan" class="btn btn-success">Đã Thanh Toán</a>
        <a href="/asm2/hoa-don/tat-ca" class="btn btn-secondary">Tất Cả</a>
    </div>

    <!-- Table to display invoices -->
    <h3 class="mt-5">Danh Sách Hóa Đơn</h3>
    <table class="table table-bordered table-hover mt-3">
        <thead class="table-dark">
        <tr>
            <th>STT</th>
            <th>ID</th>
            <th>Tên khách hàng</th>
            <th>Trạng thái</th>
            <th>Ngày tạo</th>
            <th>Ngày sửa</th>
            <th>Địa chỉ</th>

            <th>Số điện thoại</th>
            <th>tong tien</th>
            <th>Chọn</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${listHD}" varStatus="s" var="lhd">
            <tr>
                <td>${s.index + 1}</td> <!-- Changed to display a count starting from 1 -->
                <td>${lhd.id}</td>
                <td>${lhd.hoTen}</td> <!-- Assuming 'ten' is a property of KhachHang -->
                <td>${lhd.trangThai}</td>
                <td>${lhd.ngayTao}</td>
                <td>${lhd.ngaySua}</td>
                <td>${lhd.diaChi}</td>
                <td>${lhd.soDienThoai}</td>
                <td>${lhd.totalAmount}</td>
                <td><a href="/asm2/hoa-don/xem-hoa-don/${lhd.id}" class="btn btn-info btn-sm">Chọn</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- Table to display invoice details -->
    <h3 class="mt-5">Chi Tiết Hóa Đơn</h3>
    <p>Tong tien HD chon:<input type="text" value="${TT}" readonly></p>
    <table class="table table-bordered table-hover mt-3">
        <thead class="table-dark">
        <tr>
            <th>STT</th>
            <th>ID</th>
            <th>ID hóa đơn</th>
            <th>Tên sản phẩm</th>
            <th>Số lượng mua</th>
            <th>Giá bán</th>
            <th>Tổng tiền</th>
            <th>Trạng thái</th>
            <th>Ngày tạo</th>
            <th>Ngày sửa</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${listHDCT}" var="lhdct" varStatus="s">
            <tr>
                <td>${s.count}</td>
                <td>${lhdct.id}</td>
                <td>${lhdct.hoa_don.id}</td>
                <td>${lhdct.ctsp.san_pham.ten_san_pham}</td>
                <td>${lhdct.so_luong_mua}</td>
                <td>${lhdct.gia_ban}</td>
                <td>${lhdct.tong_tien}</td>
                <td>${lhdct.trang_thai}</td>
                <td>${lhdct.ngay_tao}</td>
                <td>${lhdct.ngay_sua}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
