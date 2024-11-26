package com.example.asm2.controller;

import com.example.asm2.model.*;
import com.example.asm2.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDate;
import java.sql.Date;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/asm2")
public class BanHangController {
    @Autowired
    SanPhamRepository sanPhamRepository;
    @Autowired
    ChiTietSanPhamRepository chiTietSanPhamRepository;
    @Autowired
    HoaDonChiTietRepository hoaDonChiTietRepository;
    @Autowired
    DanhMucRepository danhMucRepository;
    @Autowired
    HoaDonRepository hoaDonRepository;
    @Autowired
    KhachHangRepository khachHangRepository;
    @Autowired
    MauSacRepository mauSacRepository;
    @Autowired
    SizeRepository sizeRepository;
    private double tinhTongTien(List<IHoaDon> listHD) {
        double tongTien = 0;


        for (IHoaDon h : listHD) {
            tongTien +=h.getTotalAmount();

        }

        return tongTien;
    }

    private double tinhTongTienGioHang(Integer hoaDonId) {
        double tongTien = 0;
        List<HoaDonChiTiet> listHDCT = hoaDonChiTietRepository.getL(hoaDonId);

        for (HoaDonChiTiet h : listHDCT) {
            tongTien += h.getTong_tien();
        }

        return tongTien;
    }


    @GetMapping("/ban-hang")
    public String BanHang(Model model) {
        model.addAttribute("listCTSP", chiTietSanPhamRepository.findAll());
        model.addAttribute("listHD", hoaDonRepository.getList());
        return "banhang";
    }



    @GetMapping("/ban-hang/tao-hoa-don")
    public String TaoHoaDon(String soDT, HttpSession session) {
        Optional<KhachHang> khachHang = khachHangRepository.findBySdt(soDT);

        if (khachHang.isPresent()) {
            HoaDon hoaDon = new HoaDon(null, khachHang.get(), "Cho thanh toan", LocalDate.now(),LocalDate.now(), null, soDT);
            hoaDonRepository.save(hoaDon);


            session.setAttribute("hoaDon", hoaDon);


            session.setAttribute("tongTien", 0.0);
        } else {
            HoaDon hoaDon = new HoaDon(null, null, "Cho thanh toan", LocalDate.now(), LocalDate.now(), null, null);
            hoaDonRepository.save(hoaDon);


            session.setAttribute("hoaDon", hoaDon);


            session.setAttribute("tongTien", 0.0);
        }

        return "redirect:/asm2/ban-hang";
    }



    @GetMapping("/ban-hang/xem-hoa-don/{id}")
    public String XemHoaDon(@PathVariable("id") Integer id, Model model, HttpSession session) {
        Optional<HoaDon> optionalHoaDon = hoaDonRepository.findById(id);

        if (optionalHoaDon.isPresent()) {
            HoaDon hoaDon = optionalHoaDon.get();
            model.addAttribute("hoaDon", hoaDon);


            session.setAttribute("hoaDon", hoaDon);


            double tongTien = tinhTongTienGioHang(hoaDon.getId());
            session.setAttribute("tongTien", tongTien);
        } else {
            model.addAttribute("hoaDon", new HoaDon());
            session.setAttribute("tongTien", 0.0);
        }

        model.addAttribute("listCTSP", chiTietSanPhamRepository.findAll());
        model.addAttribute("listHDCT", hoaDonChiTietRepository.getL(id));
        model.addAttribute("listHD", hoaDonRepository.getList());

        return "banhang";
    }

    @PostMapping("/ban-hang/them-vao-gio")
    public String ThemVaoGio(@RequestParam("lctspId") Integer id,
                             @RequestParam("soLuong") Integer soLuongMua,
                             HttpSession session, Model model) {
        Optional<ChiTietSanPham> optionalCTSP = chiTietSanPhamRepository.findById(id);
        if (optionalCTSP.isPresent()) {
            ChiTietSanPham chiTietSanPham = optionalCTSP.get();


            HoaDon hoaDon = (HoaDon) session.getAttribute("hoaDon");


            if (hoaDon != null && chiTietSanPham.getSo_luong_ton() >= soLuongMua) {

                chiTietSanPham.setSo_luong_ton(chiTietSanPham.getSo_luong_ton() - soLuongMua);
                chiTietSanPhamRepository.save(chiTietSanPham);

                boolean existsInCart = false;


                for (HoaDonChiTiet h : hoaDonChiTietRepository.findAll()) {
                    if (h.getCtsp().getId().equals(chiTietSanPham.getId()) && h.getHoa_don().getId().equals(hoaDon.getId())) {
                        h.setSo_luong_mua(h.getSo_luong_mua() + soLuongMua);
                        h.setTong_tien(h.getSo_luong_mua() * h.getGia_ban());
                        hoaDonChiTietRepository.save(h);
                        existsInCart = true;
                        break;
                    }
                }


                if (!existsInCart) {
                    HoaDonChiTiet hoaDonChiTiet = new HoaDonChiTiet(null, hoaDon, chiTietSanPham, soLuongMua, chiTietSanPham.getGia_ban(), soLuongMua * chiTietSanPham.getGia_ban(), null, LocalDate.now(), LocalDate.now());
                    hoaDonChiTietRepository.save(hoaDonChiTiet);
                }


                double tongTien = tinhTongTienGioHang(hoaDon.getId());
                session.setAttribute("tongTien", tongTien);
                session.setAttribute("listHDCT", hoaDonChiTietRepository.getL(hoaDon.getId()));
            }
        }

        return "redirect:/asm2/ban-hang";
    }

    @PostMapping("/ban-hang/sua-gio-hang")
    public String CapNhatSoLuong(@RequestParam("lhdctId") Integer lhdctId,
                                 @RequestParam("soLuong2") Integer soLuong,
                                 HttpSession session) {
        Optional<HoaDonChiTiet> optionalHDCT = hoaDonChiTietRepository.findById(lhdctId);

        if (optionalHDCT.isPresent()) {
            HoaDonChiTiet hoaDonChiTiet = optionalHDCT.get();
            ChiTietSanPham chiTietSanPham = hoaDonChiTiet.getCtsp();


            int soLuongTonMoi = chiTietSanPham.getSo_luong_ton() + hoaDonChiTiet.getSo_luong_mua() - soLuong;

            if (soLuong == 0) {

                hoaDonChiTietRepository.delete(hoaDonChiTiet);
                chiTietSanPham.setSo_luong_ton(chiTietSanPham.getSo_luong_ton() + hoaDonChiTiet.getSo_luong_mua());
            } else if (soLuong > 0 && soLuong <= (hoaDonChiTiet.getSo_luong_mua() + chiTietSanPham.getSo_luong_ton())) {

                hoaDonChiTiet.setSo_luong_mua(soLuong);
                hoaDonChiTiet.setTong_tien(soLuong * hoaDonChiTiet.getGia_ban());
                chiTietSanPham.setSo_luong_ton(soLuongTonMoi);

                hoaDonChiTietRepository.save(hoaDonChiTiet);


            }
            chiTietSanPhamRepository.save(chiTietSanPham);
            HoaDon hoaDon = (HoaDon) session.getAttribute("hoaDon");
            session.setAttribute("listHDCT", hoaDonChiTietRepository.getL(hoaDon.getId()));


            double tongTien = tinhTongTienGioHang(hoaDon.getId());
            session.setAttribute("tongTien", tongTien);
        }

        return "redirect:/asm2/ban-hang";
    }


    @GetMapping("/ban-hang/tim-khach-hang")
    public String TimKhachHang(@RequestParam("soDT") String soDT, Model model, HttpSession session) {
        Optional<KhachHang> khachHang = khachHangRepository.findBySdt(soDT);
        HoaDon hoaDon = (HoaDon) new HoaDon();

        if (khachHang.isPresent()) {


            hoaDon.setKhach_hang(khachHang.get());
            session.setAttribute("hoaDon", hoaDon);
            session.removeAttribute("tongTien");
        } else {

            session.setAttribute("hoaDon", new HoaDon());
            model.addAttribute("message", "Không tìm thấy khách hàng với số điện thoại này.");
        }


        model.addAttribute("listCTSP", chiTietSanPhamRepository.findAll());
        model.addAttribute("listHDCT", hoaDonChiTietRepository.getL(hoaDon.getId()));
        model.addAttribute("listHD", hoaDonRepository.getList());

        return "banhang";
    }

    @PostMapping("/ban-hang/thanh-toan")
    public String ThanhToan(@RequestParam("id") Integer hoaDonId, HttpSession session, Model model) {

        Optional<HoaDon> optionalHoaDon = hoaDonRepository.findById(hoaDonId);

        if (optionalHoaDon.isPresent()) {
            HoaDon hoaDon = optionalHoaDon.get();


            Double tongTien = (Double) session.getAttribute("tongTien");
            if (hoaDon.getId() == null || tongTien == null || tongTien == 0) {
                model.addAttribute("message", "Không thể thanh toán vì hóa đơn hoặc tổng tiền không hợp lệ.");
                return "redirect:/asm2/ban-hang";
            }


            hoaDon.setTrang_thai("Da thanh toan");


            hoaDon.setNgay_sua(LocalDate.now());


            hoaDonRepository.save(hoaDon);


            session.removeAttribute("hoaDon");
            session.removeAttribute("tongTien");
            session.removeAttribute("listHDCT");

            model.addAttribute("message", "Thanh toán thành công!");
        } else {
            model.addAttribute("message", "Không tìm thấy hóa đơn.");
        }

        return "redirect:/asm2/ban-hang";
    }

    @GetMapping("/danh-muc")
    public String DanhMuc(Model model) {
        model.addAttribute("listDM", danhMucRepository.findAll());
        return "themdanhmuc";
    }

    @GetMapping("/khach-hang")
    public String KhachHang(Model model) {
        model.addAttribute("listKH",khachHangRepository.findAll());
        return "themkhachhang";
    }

    @GetMapping("/mau-sac")
    public String MauSac() {
        return "themmausac";
    }

    @GetMapping("/san-pham")
    public String SanPham(Model model) {
        model.addAttribute("listCTSP", chiTietSanPhamRepository.findAll());
model.addAttribute("listDM",danhMucRepository.findAll());
model.addAttribute("listMS",mauSacRepository.findAll());
        model.addAttribute("listS",sizeRepository.findAll());

        return "themsanpham";
    }
@PostMapping("/san-pham")
public String ThemSanPham (){


        return"redirect:/asm2/san-pham";
}
    @GetMapping("/kich-thuoc")
    public String Size() {
        return "themsize";
    }

    @PostMapping("/them-danh-muc")
    public String ThemDanhMuc(DanhMuc danhMuc) {
        danhMuc.setNgay_sua(LocalDate.now());
        danhMuc.setNgay_tao(LocalDate.now());
        danhMucRepository.save(danhMuc);
        return "redirect:/asm2/danh-muc";
    }

    @GetMapping("/hoa-don")
    public String getHoaDon(Model model) {
        model.addAttribute("listHD", hoaDonRepository.findInvoiceSummaries());
        model.addAttribute("listHDCT", hoaDonChiTietRepository.getL(null));
     model.addAttribute("T", tinhTongTien(hoaDonRepository.findInvoiceSummaries()));
        return "hoadon";
    }

    @GetMapping("/hoa-don/xem-hoa-don/{id}")
    public String viewHoaDonDetails(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("listHD", hoaDonRepository.findInvoiceSummaries());
        model.addAttribute("listHDCT", hoaDonChiTietRepository.getL(id));
        model.addAttribute("T", tinhTongTien(hoaDonRepository.findInvoiceSummaries()));
       model.addAttribute("TT", tinhTongTienGioHang(id));
        return "hoadon";
    }

    @GetMapping("/hoa-don/tim")
    public String searchHoaDon(
            @RequestParam("ngayBD") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate ngayBD,
            @RequestParam("ngayKT") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate ngayKT,
            Model model
    ) {
        List<IHoaDon> listHD = hoaDonRepository.getTNgay(ngayBD, ngayKT);
        model.addAttribute("listHD", listHD);
        model.addAttribute("listHDCT", hoaDonChiTietRepository.getL(null));
        model.addAttribute("T", tinhTongTien(listHD));
        return "hoadon";
    }

    @GetMapping("/hoa-don/da-thanh-toan")
    public String getPaidInvoices(Model model) {
        model.addAttribute("listHD", hoaDonRepository.getLDTT());
        model.addAttribute("listHDCT", hoaDonChiTietRepository.getL(null));
        model.addAttribute("T", tinhTongTien(hoaDonRepository.getLDTT()));
        return "hoadon";
    }

    @GetMapping("/hoa-don/tat-ca")
    public String getAllInvoices(Model model) {
        model.addAttribute("listHD", hoaDonRepository.findInvoiceSummaries());
        model.addAttribute("listHDCT", hoaDonChiTietRepository.getL(null));
        model.addAttribute("T", tinhTongTien( hoaDonRepository.findInvoiceSummaries()));
        return "hoadon";
    }

}
