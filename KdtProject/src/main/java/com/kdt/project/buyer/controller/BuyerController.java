package com.kdt.project.buyer.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;
import java.util.Map;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kdt.project.buyer.dto.CartDTO;
import com.kdt.project.buyer.dto.ReviewDTO;
import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.buyer.entity.ProductOptionEntity;
import com.kdt.project.buyer.service.BuyerService;
import com.kdt.project.user.entity.UserEntity;
import com.kdt.project.user.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage")
public class BuyerController {

    private final BuyerService buyerService;
    
    @Autowired
    UserRepository userRepository;

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
    public String deleteCartItem(@RequestParam("cartId") Long cartId) {
        buyerService.deleteCartItem(cartId);
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

        String reviewImageUrl = null;
        if (reviewImage != null && !reviewImage.isEmpty()) {
            // 서버에 저장 (예: /resources/upload/review/)
            String uploadDir = session.getServletContext().getRealPath("/resources/upload/review/");
            String originalFilename = reviewImage.getOriginalFilename();
            String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
            String savedFileName = UUID.randomUUID().toString() + ext;

            File dest = new File(uploadDir, savedFileName);
            try {
                reviewImage.transferTo(dest);
                reviewImageUrl = savedFileName;
            } catch (Exception e) {
                e.printStackTrace();
                model.addAttribute("error", "이미지 업로드 실패");
                return "redirect:/mypage/product/detail?id=" + productId;
            }
        }

        ReviewDTO reviewDto = new ReviewDTO();
        reviewDto.setProductId(productId);
        reviewDto.setUserId(user.getId());
        reviewDto.setScore(score);
        reviewDto.setContent(content);
        reviewDto.setReviewImageUrl(reviewImageUrl);

        buyerService.addReview(reviewDto);

        return "redirect:/mypage/product/detail?id=" + productId;
    }
    //리뷰 삭제
    @PostMapping("/product/review/delete")
    public String deleteReview(@RequestParam("reviewId") Long reviewId,
                               @RequestParam("productId") String productId,
                               HttpSession session) {

        UserEntity user = (UserEntity) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            buyerService.deleteReview(reviewId);
        } catch (RuntimeException e) {
            e.printStackTrace();
            // 삭제 실패 시에도 상품 상세 페이지로 이동
        }

        return "redirect:/mypage/product/detail?id=" + productId;
    }
    
    
 // ✅ 리뷰 수정 - 컨트롤러
    @PostMapping("/product/review/update")
    public String updateReview(@ModelAttribute ReviewDTO reviewDto,
                              @RequestParam(value = "reviewImage", required = false) MultipartFile reviewImage,
                              @RequestParam("productId") String productId,
                              HttpSession session) {
        
        UserEntity user = (UserEntity) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }
        
        try {
            // 서비스 메서드 호출 (이미지 처리는 서비스에서 담당)
            buyerService.updateReview(reviewDto, reviewImage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/mypage/product/detail?id=" + productId;
    }

    @PostMapping("/cart/update")
    @ResponseBody
    public Map<String, Object> updateCart(@RequestBody CartDTO cartDto) {
        Map<String, Object> result = new HashMap<>();
        try {
            buyerService.updateCartQuantity(cartDto.getCartId(), cartDto.getCartCount());
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }
    
    
    @GetMapping("/order/form")
    public String orderForm(HttpSession session, Model model) {

        UserEntity user = (UserEntity) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        List<CartDTO> cartList = buyerService.getCartList(user.getId());

        model.addAttribute("cartList", cartList);

        int grandTotal = cartList.stream()
                .mapToInt(c -> c.getCartCount() * c.getProductPrice())
                .sum();
        model.addAttribute("grandTotal", grandTotal);

        return "buyer/orderForm";
    }

    
    @GetMapping("/address/form")
    public String addressForm(HttpSession session, Model model) {
        UserEntity user = (UserEntity) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        model.addAttribute("user", user);  
        return "buyer/addressForm";        
    }
    
    
    @PostMapping("/address/update")
    public String updateAddress(
            @RequestParam("name")        String name,
            @RequestParam("phoneNumber") String phoneNumber,
            @RequestParam("address")     String address,
            @RequestParam(value = "postalCode", required = false) String postalCode,
            HttpSession session) {

        UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        // 엔티티 값 갱신
        loginUser.setName(name);
        loginUser.setPhoneNumber(phoneNumber);
        loginUser.setAddress(address);
        // loginUser.setPostalCode(postalCode);

        userRepository.save(loginUser);
        session.setAttribute("loginUser", loginUser);

        return "redirect:/mypage/order/form";
    }
    





}