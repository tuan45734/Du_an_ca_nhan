<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Thêm sản phẩm</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="menu.jsp"/>

<div class="container mt-5">
    <h1 class="text-center text-primary mb-4">Thêm Sản Phẩm</h1>

    <!-- Form Thêm sản phẩm -->
    <form>
        <div class="form-group">
            <label for="ma_san_pham">Mã Sản Phẩm</label>
            <input type="text" id="ma_san_pham" name="ma_san_pham" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="ten_san_pham">Tên Sản Phẩm</label>
            <input type="text" id="ten_san_pham" name="ten_san_pham" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Trạng Thái</label><br>
            <div class="form-check form-check-inline">
                <input type="radio" id="con_hang" name="trang_thai" class="form-check-input">
                <label for="con_hang" class="form-check-label">Còn hàng</label>
            </div>
            <div class="form-check form-check-inline">
                <input type="radio" id="het_hang" name="trang_thai" class="form-check-input">
                <label for="het_hang" class="form-check-label">Hết hàng</label>
            </div>
        </div>
        <div class="form-group">
            <label for="danh_muc">Danh Mục</label>
            <select id="danh_muc" name="danh_muc" class="form-control">
                <c:forEach items="${listDM}" var="ldm">
                    <option value="${ldm.id}">${ldm.ten_danh_muc}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="mau_sac">Màu Sắc</label>
            <select id="mau_sac" name="mau_sac" class="form-control">
                <c:forEach items="${listMS}" var="lms">
                    <option value="${lms.id}">${lms.ten_mau}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="size">Size</label>
            <select id="size" name="size" class="form-control">
                <c:forEach items="${listS}" var="ls">
                    <option value="${ls.id}">${ls.ten_size}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="gia_ban">Giá Bán</label>
            <input type="text" id="gia_ban" name="gia_ban" class="form-control">
        </div>
        <div class="form-group">
            <label for="so_luong_ton">Số Lượng Tồn</label>
            <input type="text" id="so_luong_ton" name="so_luong_ton" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary">Thêm</button>
    </form>

    <!-- Bảng danh sách sản phẩm -->
    <h2 class="text-center text-success mt-5">Danh Sách Sản Phẩm</h2>
    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
        <tr>
            <th>STT</th>
            <th>Mã SP</th>
            <th>Tên SP</th>
            <th>Màu Sắc</th>
            <th>Size</th>
            <th>Giá SP</th>
            <th>Số lượng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${listCTSP}" var="lctsp" varStatus="s">
            <tr>
                <td>${s.count}</td>
                <td>${lctsp.san_pham.ma_san_pham}</td>
                <td>${lctsp.san_pham.ten_san_pham}</td>
                <td>${lctsp.mau_sac.ten_mau}</td>
                <td>${lctsp.size.ten_size}</td>
                <td>${lctsp.gia_ban}</td>
                <td>${lctsp.so_luong_ton}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
