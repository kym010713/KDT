package com.kdt.project.buyer.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.kdt.project.order.entity.OrderDetailEntity;
import com.kdt.project.order.entity.OrderEntity;
import com.kdt.project.order.repository.OrderDetailRepository;
import com.kdt.project.order.repository.OrderRepository;
import com.kdt.project.order.service.OrderService;
import com.kdt.project.user.entity.UserEntity;
import com.kdt.project.user.repository.UserRepository;

import io.imagekit.sdk.ImageKit;
import io.imagekit.sdk.models.FileCreateRequest;
import io.imagekit.sdk.models.results.Result;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage")
public class BuyerController {

    private final OrderService orderService;
    private final BuyerService buyerService;
    private final ImageKit imageKit;
    
    @Autowired
    OrderRepository orderRepository;
    
    @Autowired
    OrderDetailRepository detailRepository;
    
    @Autowired
    UserRepository userRepository;

    public BuyerController(BuyerService buyerService, OrderService orderService, ImageKit imageKit) {
        this.buyerService = buyerService;
        this.orderService = orderService;
        this.imageKit = imageKit;
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
            return "buyer/main";
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
    
    // 리뷰 작성 - ImageKit 사용
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
            try {
                // ImageKit에 업로드
                reviewImageUrl = uploadImageToImageKit(reviewImage, "review");
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
    
    // 리뷰 삭제
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
        }

        return "redirect:/mypage/product/detail?id=" + productId;
    }
    
    // ✅ 리뷰 수정 - ImageKit 사용
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

        loginUser.setName(name);
        loginUser.setPhoneNumber(phoneNumber);
        loginUser.setAddress(address);

        userRepository.save(loginUser);
        session.setAttribute("loginUser", loginUser);

        return "redirect:/mypage/order/form";
    }
    
    @GetMapping("/order/list")
    public String orderList(HttpSession session, Model model) {
        UserEntity user = (UserEntity) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        List<OrderEntity> heads = orderRepository.findByUserId(user.getId());
        Map<Long, List<OrderDetailEntity>> detailMap = new HashMap<>();
        for (OrderEntity h : heads) {
            List<OrderDetailEntity> details =
                    detailRepository.findByOrderGroup(h.getOrderGroup());
            detailMap.put(h.getOrderGroup(), details);
        }

        model.addAttribute("headList", heads);
        model.addAttribute("detailMap", detailMap);
        return "buyer/orderList";
    }
    
    // ImageKit에 이미지 업로드하는 헬퍼 메서드
    private String uploadImageToImageKit(MultipartFile file, String folder) throws IOException {
        try {
            String originalFilename = file.getOriginalFilename();
            String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
            String fileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString() + ext;
            
            FileCreateRequest fileCreateRequest = new FileCreateRequest(
                file.getBytes(), 
                fileName
            );
            fileCreateRequest.setFolder("/" + folder + "/");
            
            Result result = imageKit.upload(fileCreateRequest);
            
            System.out.println("ImageKit 업로드 성공: " + result.getUrl());
            
            // DB에는 파일명만 저장 (기존 로직과 일치)
            return fileName;
            
        } catch (Exception e) {
            System.err.println("ImageKit 업로드 실패: " + e.getMessage());
            e.printStackTrace();
            throw new IOException("ImageKit 업로드 실패", e);
        }
    }
}