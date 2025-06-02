package com.kdt.project.buyer.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kdt.project.buyer.entity.CartEntity;
import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.buyer.entity.ProductOptionEntity;
import com.kdt.project.buyer.service.BuyerService;
import com.kdt.project.user.entity.UserEntity;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage")
public class BuyerController {

    private final BuyerService buyerService;

    public BuyerController(BuyerService buyerService) {
        this.buyerService = buyerService;
    }

    @GetMapping("")
    public String myPage(HttpSession session, Model model) {
        UserEntity user = (UserEntity) session.getAttribute("loginUser");

        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("user", user);
        return "buyer/myPage";
    }

    /**
     * 상품 상세 보기 (상품 정보 + 옵션 정보 포함)
     */
    @GetMapping("/product/detail")
    public String productDetail(@RequestParam("id") String productId, Model model) {
        ProductEntity product = buyerService.getProductById(productId);
        List<ProductOptionEntity> options = buyerService.getProductOptionsByProductId(productId);

        model.addAttribute("product", product);
        model.addAttribute("options", options);
        return "buyer/productDetail";
    }

    /**
     * 장바구니에 상품 추가
     */
//    @PostMapping("/cart/add")
//    public String addToCart(@RequestParam("productId") String productId,
//                            @RequestParam("sizeId") Long sizeId,
//                            @RequestParam("count") int count,
//                            HttpSession session) {
//
//        UserEntity user = (UserEntity) session.getAttribute("loginUser");
//        if (user == null) return "redirect:/login";
//
//        buyerService.addToCart(user.getId(), productId, sizeId, count);
//        return "redirect:/mypage/cart";
//    }
//
//    /**
//     * 장바구니 조회
//     */
//    @GetMapping("/cart")
//    public String viewCart(Model model, HttpSession session) {
//        UserEntity user = (UserEntity) session.getAttribute("loginUser");
//        if (user == null) return "redirect:/login";
//
//        List<CartEntity> cartList = buyerService.getCartItems(user.getId());
//        model.addAttribute("cartList", cartList);
//        return "buyer/cart"; // cart.jsp
//    }
}
