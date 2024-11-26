<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    body {
        font-family: Arial, sans-serif;
    }

    .navbar {
        background-color: #333;
        overflow: hidden;
    }

    .navbar a {
        float: left;
        display: block;
        color: white;
        text-align: center;
        padding: 14px 20px;
        text-decoration: none;
        font-size: 17px;
    }

    .navbar a:hover {
        background-color: #ddd;
        color: black;
    }

    .navbar a.active {
        background-color: #04AA6D;
        color: white;
    }
</style>

<div class="navbar">
    <a href="/asm2/ban-hang" class="active">Bán hàng</a>
    <a href="/asm2/hoa-don">QL Hoa Don</a>
    <a href="/asm2/danh-muc">Thêm danh mục</a>
    <a href="/asm2/khach-hang">Thêm khách hàng</a>

    <a href="/asm2/san-pham">Thêm sản phẩm</a>

</div>
