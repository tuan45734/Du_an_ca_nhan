package com.example.asm2.repository;

import com.example.asm2.model.HoaDon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


import java.time.LocalDate;
import java.util.List;

public interface HoaDonRepository extends JpaRepository<HoaDon, Integer> {

    @Query(value = "SELECT * FROM hoa_don WHERE trang_thai = 'cho thanh toan'", nativeQuery = true)
    List<HoaDon> getList();
    @Query(value = "SELECT \n" +
            "   h.id,k.ho_ten,h.trang_thai,h.ngay_tao,h.ngay_sua,h.dia_chi,h.so_dien_thoai,\n" +
            "    SUM(d.so_luong_mua * d.gia_ban) AS total_amount\n" +
            "FROM \n" +
            "    hoa_don h\n" +
            "JOIN \n" +
            "    hdct d ON h.id = d.id_hoa_don\n" +
            "\tjoin khach_hang k on k.id=h.id_khach_hang\n" +
            "WHERE h.trang_thai = 'Da thanh toan'\n" +
            "GROUP BY h.id,k.ho_ten,h.trang_thai,h.ngay_tao,h.ngay_sua,h.dia_chi,h.so_dien_thoai\n", nativeQuery = true)
    List<IHoaDon> getLDTT();
    @Query(value = "SELECT \n" +
            "   h.id,k.ho_ten,h.trang_thai,h.ngay_tao,h.ngay_sua,h.dia_chi,h.so_dien_thoai,\n" +
            "    SUM(d.so_luong_mua * d.gia_ban) AS total_amount\n" +
            "FROM \n" +
            "    hoa_don h\n" +
            "JOIN \n" +
            "    hdct d ON h.id = d.id_hoa_don\n" +
            "\tjoin khach_hang k on k.id=h.id_khach_hang\n" +
            "WHERE h.ngay_tao BETWEEN :ngayBD AND :ngayKT\n" +
            "GROUP BY h.id,k.ho_ten,h.trang_thai,h.ngay_tao,h.ngay_sua,h.dia_chi,h.so_dien_thoai\n", nativeQuery = true)
    List<IHoaDon> getTNgay(LocalDate ngayBD, LocalDate ngayKT);
    @Query(value = "SELECT \n" +
            "   h.id,k.ho_ten,h.trang_thai,h.ngay_tao,h.ngay_sua,h.dia_chi,h.so_dien_thoai,\n" +
            "    SUM(d.so_luong_mua * d.gia_ban) AS total_amount\n" +
            "FROM \n" +
            "    hoa_don h\n" +
            "JOIN \n" +
            "    hdct d ON h.id = d.id_hoa_don\n" +
            "\tjoin khach_hang k on k.id=h.id_khach_hang\n" +
            "GROUP BY h.id,k.ho_ten,h.trang_thai,h.ngay_tao,h.ngay_sua,h.dia_chi,h.so_dien_thoai\n",
            nativeQuery = true)
    List<IHoaDon> findInvoiceSummaries();
}
