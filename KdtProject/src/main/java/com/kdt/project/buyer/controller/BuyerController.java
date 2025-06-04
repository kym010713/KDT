package com.kdt.project.buyer.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kdt.project.buyer.dto.CartDTO;
import com.kdt.project.buyer.dto.ReviewDTO;
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
        try {
            ProductEntity product = buyerService.getProductById(productId);
            List<ProductOptionEntity> options = buyerService.getProductOptionsByProductId(productId);
            List<ReviewDTO> reviews = buyerService.getReviewsByProductId(productId);
            
            System.out.println("Product: " + product); // 디버깅
            System.out.println("Options size: " + options.size()); // 디버깅
            
            model.addAttribute("product", product);
            model.addAttribute("options", options);
            model.addAttribute("reviews", reviews);
            
            return "buyer/productDetail";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "상품을 찾을 수 없습니다.");
            return "buyer/main"; // 
        }
    }

    /**
     * 🔽 장바구니에 상품 추가
     */
    @PostMapping("/cart/add")
    public String addToCart(@RequestParam("productId") String productId,
                            @RequestParam("productSize") String productSize,
                            @RequestParam("count") int count,
                            HttpSession session,
                            Model model) {
        UserEntity user = (UserEntity) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            buyerService.addToCart(user.getId(), productId, productSize, count);
            return "redirect:/mypage/cart";  // 장바구니 페이지로 이동
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            // 기존 상세 페이지 URL 유지
            return "redirect:/mypage/product/detail?id=" + productId;
        }
    }


    /**
     * 🔽 장바구니 목록 조회
     */
    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {
        UserEntity user = (UserEntity) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }

        List<CartDTO> cartList = buyerService.getCartList(user.getId());
        model.addAttribute("cartList", cartList);
        return "buyer/cartList";
    }

    /**
     * 🔽 장바구니에서 항목 삭제
     */
    @PostMapping("/cart/delete")
    public String deleteCartItem(@RequestParam("cartId") Long cartId,
                                 HttpSession session) {
        UserEntity user = (UserEntity) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }

        buyerService.removeFromCart(cartId);
        return "redirect:/mypage/cart";
    }
    
    //리뷰 작성
    @PostMapping("/product/review")
    public String addReview(@RequestParam("productId") String productId,
                            @RequestParam("score") int score,
                            @RequestParam("content") String content,
                            @RequestParam(value = "reviewImage", required = false) MultipartFile reviewImage,
                            HttpSession session,
                            Model model) {
        UserEntity user = (UserEntity) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }

        // 1. 파일 저장
        String reviewImageUrl = null;
        if (reviewImage != null && !reviewImage.isEmpty()) {
            try {
                String originalFilename = reviewImage.getOriginalFilename();
                String uploadDir = "C:\\Users\\023\\git\\KDT\\KdtProject\\src\\main\\webapp\\resources\\upload\\review"; // ex: "C:/upload/review/"
                String savedPath = uploadDir + originalFilename;

                reviewImage.transferTo(new java.io.File(savedPath));

                reviewImageUrl = originalFilename; // 또는 경로 포함 저장
            } catch (Exception e) {
                e.printStackTrace();
                model.addAttribute("error", "이미지 업로드 실패");
                return "redirect:/mypage/product/detail?id=" + productId;
            }
        }


        
        // 2. DTO 세팅
        ReviewDTO review = new ReviewDTO();
        review.setProductId(productId);
        review.setUserId(user.getId());
        review.setScore(score);
        review.setContent(content);
        review.setReviewImageUrl(reviewImageUrl);

        buyerService.addReview(review);

        return "redirect:/mypage/product/detail?id=" + productId;
    }
    

    
    
}
