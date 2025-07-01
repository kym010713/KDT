package com.kdt.project.seller.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kdt.project.seller.entity.SellerRoleEntity;
import com.kdt.project.seller.service.SellerRoleService;
import com.kdt.project.user.entity.UserEntity;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("seller/*")
public class SellerRoleController {

    @Autowired
    private SellerRoleService sellerRoleService;

    @RequestMapping(value = "apply", method = RequestMethod.GET)
    public String showApplyForm(HttpSession session, HttpServletResponse response) throws IOException {
        UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");
        if (loginUser == null) {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('로그인 후 이용 가능한 서비스입니다.'); location.href='/';</script>");
            return null;
        }

        return "seller/applyForm"; // JSP 경로로 이동
    }




    @RequestMapping(value = "apply", method = RequestMethod.POST)
    public String applySeller(HttpServletRequest request,
                              HttpSession session,
                              Model model) {
        String sellerId = request.getParameter("sellerId");
        String sellerName = request.getParameter("sellerName");
        String brandName = request.getParameter("brandName");
        String sellerAddress = request.getParameter("sellerAddress");
        String sellerPhone = request.getParameter("sellerPhone");
        String businessNumber = request.getParameter("businessNumber");

        try {
            SellerRoleEntity entity = new SellerRoleEntity();
            entity.setSellerId(sellerId);
            entity.setSellerName(sellerName);
            entity.setBrandName(brandName);
            entity.setSellerAddress(sellerAddress);
            entity.setSellerPhone(sellerPhone);
            entity.setBusinessNumber(businessNumber);
            entity.setStatus("N");

            sellerRoleService.applySellerRole(entity);
            model.addAttribute("seller", entity);
            return "seller/applyFormPro";

        } catch (Exception e) {
            model.addAttribute("error", "입점 신청에 실패했습니다. " + e.getMessage());
            return "seller/applyForm";
        }
    }
}
