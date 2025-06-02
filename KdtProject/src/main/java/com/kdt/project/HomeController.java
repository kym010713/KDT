package com.kdt.project;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.buyer.service.BuyerService;
import com.kdt.project.user.entity.UserEntity;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

    private final BuyerService buyerService;

    public HomeController(BuyerService buyerService) {
        this.buyerService = buyerService;
    }

    @GetMapping("/")
    public String home(HttpSession session, Model model) {
        UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login"; // 로그인 안 된 경우 로그인 페이지로 이동
        }

        model.addAttribute("userName", loginUser.getName());

        // 상품 리스트 전달
        List<ProductEntity> productList = buyerService.getAllProducts();
        model.addAttribute("products", productList);

        return "buyer/main"; // → buyer/main.jsp
    }
}

