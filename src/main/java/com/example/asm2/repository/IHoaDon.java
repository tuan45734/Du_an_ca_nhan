package com.example.asm2.repository;

import com.example.asm2.model.KhachHang;
import java.time.LocalDate;

public interface IHoaDon {
    Integer getId();

    String getHoTen(); // Added parentheses to define it as a method

    String getTrangThai(); // Changed the method name to follow Java conventions

    LocalDate getNgayTao(); // Changed the method name to follow Java conventions

    LocalDate getNgaySua(); // Changed the method name to follow Java conventions

    String getDiaChi(); // Changed the method name to follow Java conventions

    String getSoDienThoai(); // Changed the method name to follow Java conventions

    Double getTotalAmount(); // Changed return type to Double and renamed method for convention
}
