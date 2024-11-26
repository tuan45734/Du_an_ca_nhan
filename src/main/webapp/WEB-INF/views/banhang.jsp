<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bán hàng</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f0f0f0;
        }

        .container {
            margin-top: 20px;
        }

        .scrollable-table {
            max-height: 250px;
            overflow-y: auto;
        }

        table {
            width: 100%;
            text-align: center;
        }

        .table-section {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

<!-- Include menu -->
<jsp:include page="menu.jsp"/>

<div class="container">
    <h1 class="text-center mb-4">Bán hàng</h1>

    <div class="row">
        <!-- Sản phẩm và Giỏ hàng -->
        <div class="col-md-8">
            <div class="table-section">
                <!-- Bảng sản phẩm -->
                <div class="card">
                    <div class="card-header">
                        <h2 class="h4">Sản phẩm</h2>
                    </div>
                    <div class="card-body scrollable-table">
                        <table class="table table-bordered">
                            <thead class="table-primary">
                            <tr>
                                <th>STT</th>
                                <th>Mã SP</th>
                                <th>Tên SP</th>
                                <th>Màu Sắc</th>
                                <th>Size</th>
                                <th>Giá SP</th>
                                <th>Số lượng</th>
                                <th>Chọn</th>
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
                                    <td>
                                        <c:if test="${not empty sessionScope.hoaDon.id}">
                                            <button class="btn btn-success btn-sm" data-toggle="modal"
                                                    data-target="#chonSanPhamModal"
                                                    onclick="openChonSanPhamModal(${lctsp.id}, '${sessionScope.hoaDon.id}', ${lctsp.so_luong_ton})">
                                                Chọn
                                            </button>
                                        </c:if>
                                        <c:if test="${empty sessionScope.hoaDon.id}">
                                            <button class="btn btn-secondary btn-sm" disabled>Chọn</button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="table-section">
                <!-- Bảng giỏ hàng -->
                <div class="card">
                    <div class="card-header">
                        <h2 class="h4">Giỏ hàng</h2>
                    </div>
                    <div class="card-body scrollable-table">
                        <table class="table table-bordered">
                            <thead class="table-warning">
                            <tr>
                                <th>STT</th>
                                <th>Mã SP</th>
                                <th>Tên SP</th>
                                <th>Giá SP</th>
                                <th>Số lượng mua</th>
                                <th>Tổng tiền</th>
                                <th>Xóa</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listHDCT}" var="lhdct" varStatus="s">
                                <tr>
                                    <td>${s.count}</td>
                                    <td>${lhdct.ctsp.san_pham.ma_san_pham}</td>
                                    <td>${lhdct.ctsp.san_pham.ten_san_pham}</td>
                                    <td>${lhdct.gia_ban}</td>
                                    <td>${lhdct.so_luong_mua}</td>
                                    <td>${lhdct.tong_tien}</td>
                                    <td>
                                        <button class="btn btn-success btn-sm" data-toggle="modal"
                                                data-target="#chonSanPhamModal2"
                                                onclick="openChonSanPhamModal2(${lhdct.id}, '${sessionScope.hoaDon.id}', ${lhdct.ctsp.so_luong_ton},${lhdct.so_luong_mua})">
                                            Chọn
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hóa đơn và Thanh toán -->
        <div class="col-md-4">
            <div class="table-section">
                <!-- Bảng hóa đơn -->
                <div class="card">
                    <div class="card-header">
                        <h2 class="h4">Hóa đơn</h2>
                    </div>
                    <div class="card-body scrollable-table">
                        <table class="table table-bordered">
                            <thead class="table-info">
                            <tr>
                                <th>STT</th>
                                <th>Mã HD</th>
                                <th>Tên khách</th>
                                <th>Ngày tạo</th>
                                <th>Trạng thái</th>
                                <th>Chi tiết</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listHD}" var="lhd" varStatus="s">
                                <tr>
                                    <td>${s.count}</td>
                                    <td>${lhd.id}</td>
                                    <td>${lhd.khach_hang.ho_ten}</td>
                                    <td>${lhd.ngay_tao}</td>
                                    <td>${lhd.trang_thai}</td>
                                    <td>
                                        <a href="/asm2/ban-hang/xem-hoa-don/${lhd.id}"
                                           class="btn btn-primary btn-sm">Xem</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <a href="/asm2/ban-hang/tao-hoa-don?soDT=${sessionScope.hoaDon.khach_hang.sdt}"
                       class="btn btn-primary mt-3">Tạo hóa đơn mới</a>
                </div>
            </div>

            <!-- Thông tin thanh toán -->
            <div class="card">
                <div class="card-header">
                    <h2 class="h4">Thanh toán</h2>
                </div>
                <div class="card-body">
                    <c:if test="${not empty message}">
                        <div class="alert alert-danger">${message}</div>
                    </c:if>
                    <!-- Tìm kiếm khách hàng -->
                    <form action="/asm2/ban-hang/tim-khach-hang" method="GET" class="mb-3">
                        <div class="mb-3">
                            <label for="soDT" class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" id="soDT" name="soDT"
                                   value="${sessionScope.hoaDon.khach_hang.sdt}">
                        </div>
                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                    </form>

                    <!-- Form thanh toán -->
                    <form action="/asm2/ban-hang/thanh-toan" method="POST">
                        <div class="mb-3">
                            <label for="tenKH" class="form-label">Tên khách hàng</label>
                            <input type="text" class="form-control" id="tenKH" name="tenKH"
                                   value="${sessionScope.hoaDon.khach_hang.ho_ten}" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="id" class="form-label">id hoa don</label>
                            <input type="text" class="form-control" id="id" name="id" readonly
                                   value="${sessionScope.hoaDon.id}">
                        </div>
                        <div class="mb-3">
                            <label for="tongTien" class="form-label">Tổng tiền</label>
                            <input type="text" class="form-control" id="tongTien" name="tongTien" readonly
                                   value="${sessionScope.tongTien}">
                        </div>
                        <input type="hidden" name="idHD" value="${sessionScope.hoaDon.id}">
                        <c:if test="${sessionScope.hoaDon.id != null && sessionScope.tongTien > 0}">
                            <button type="submit" class="btn btn-success" onclick="ok()">Thanh toán</button>
                        </c:if>
                        <c:if test="${sessionScope.hoaDon.id == null || sessionScope.tongTien <= 0}">
                            <button type="button" class="btn btn-secondary" disabled>Thanh toán</button>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal chọn sản phẩm -->
    <div class="modal fade" id="chonSanPhamModal" tabindex="-1" aria-labelledby="chonSanPhamModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="chonSanPhamModalLabel">Chọn sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="chonSanPhamForm" action="/asm2/ban-hang/them-vao-gio" method="POST">
                    <div class="modal-body">
                        <input type="hidden" id="lctspId" name="lctspId" value="">
                        <input type="hidden" id="hoaDonId" name="hoaDonId" value="">
                        <div class="mb-3">
                            <label for="soLuong" class="form-label">Số lượng</label>
                            <input type="number" class="form-control" id="soLuong" name="soLuong" min="1" value="1">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal chọn sản phẩm cho giỏ hàng -->
    <div class="modal fade" id="chonSanPhamModal2" tabindex="-1" aria-labelledby="chonSanPhamModal2Label" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="chonSanPhamModal2Label">Chọn sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="chonSanPhamForm2" action="/asm2/ban-hang/sua-gio-hang" method="POST">
                    <div class="modal-body">
                        <input type="hidden" id="lhdctId" name="lhdctId" value="">
                        <input type="hidden" id="hoaDonId2" name="hoaDonId2" value="">
                        <div class="mb-3">
                            <label for="soLuong2" class="form-label">Số lượng</label>
                            <input type="number" class="form-control" id="soLuong2" name="soLuong2" min="0" value="0">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function ok(){
        alert("thanh toan thanh cong")
    }
    function openChonSanPhamModal(lctspId, hoaDonId, soLuongTon) {
        const modal = new bootstrap.Modal(document.getElementById('chonSanPhamModal'));
        document.getElementById('lctspId').value = lctspId;
        document.getElementById('hoaDonId').value = hoaDonId;
        document.getElementById('soLuong').setAttribute("max", soLuongTon);
        modal.show();
    }

    function openChonSanPhamModal2(lhdctId, hoaDonId, soLuongTon,soLuongMua) {
        const modal2 = new bootstrap.Modal(document.getElementById('chonSanPhamModal2'));
        document.getElementById('lhdctId').value = lhdctId;
        document.getElementById('hoaDonId2').value = hoaDonId;
        document.getElementById('soLuong2').setAttribute("max", soLuongTon+soLuongMua);
        modal2.show();
    }
</script>

</body>
</html>
