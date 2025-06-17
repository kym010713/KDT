package com.kdt.project.buyer.controller;

import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kdt.project.buyer.dto.CartDTO;
import com.kdt.project.buyer.dto.ReviewDTO;
import com.kdt.project.buyer.entity.CategoryCode;
import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.buyer.entity.ProductOptionEntity;
import com.kdt.project.buyer.repository.ProductRepository;
import com.kdt.project.buyer.repository.ReviewRepository;
import com.kdt.project.buyer.service.BuyerService;
import com.kdt.project.order.dto.OrderSummaryDTO;
import com.kdt.project.order.entity.OrderDetailEntity;
import com.kdt.project.order.repository.OrderDetailRepository;
import com.kdt.project.order.repository.OrderRepository;
import com.kdt.project.order.service.OrderService;
import com.kdt.project.user.entity.UserEntity;
import com.kdt.project.user.repository.UserRepository;
import com.kdt.project.user.service.UserService;

import io.imagekit.sdk.ImageKit;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage")
public class BuyerController {

    private final OrderService orderService;
    private final BuyerService buyerService;
    private final ImageKit imageKit;
    
    // ImageKit URL을 상수로 정의
    private static final String IMAGEKIT_URL_ENDPOINT = "https://ik.imagekit.io/alzwu0day/clodi/";
    
    @Autowired
    OrderRepository orderRepository;
    
    @Autowired
    OrderDetailRepository detailRepository;
    


    @Autowired
    UserService userService;
    @Autowired
    UserRepository userRepository;

    public BuyerController(BuyerService buyerService, OrderService orderService, ImageKit imageKit) {
        this.buyerService = buyerService;
        this.orderService = orderService;
        this.imageKit = imageKit;
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
            
            // ✅ ImageKit URL을 Model에 추가
            model.addAttribute("imagekitUrl", IMAGEKIT_URL_ENDPOINT);
            
            return "buyer/productDetail";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "상품을 찾을 수 없습니다.");
            model.addAttribute("imagekitUrl", IMAGEKIT_URL_ENDPOINT); // 에러 시에도 추가
            return "buyer/main";
        }
    }
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

<<<<<<< HEAD
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
=======
	@Autowired
	UserService userService;
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	ProductRepository productRepository;
	
	
	public BuyerController(BuyerService buyerService, OrderService orderService, ImageKit imageKit) {
		this.buyerService = buyerService;
		this.orderService = orderService;
		this.imageKit = imageKit;
	}
>>>>>>> refs/heads/dev

        List<CartDTO> cartList = buyerService.getCartList(user.getId());
        model.addAttribute("cartList", cartList);
        
        
        // ✅ 장바구니에서도 ImageKit URL 추가 (상품 이미지 표시용)
        model.addAttribute("imagekitUrl", IMAGEKIT_URL_ENDPOINT);
        
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
    
    // ✅ 리뷰 작성 - 수정된 버전 (ImageKit 업로드 후 DB 저장)
 // ✅ 리뷰 작성 - 수정된 버전 (중복 업로드 제거)
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

        try {
            // ReviewDTO 생성
            ReviewDTO reviewDto = new ReviewDTO();
            reviewDto.setProductId(productId);
            reviewDto.setUserId(user.getId());
            reviewDto.setScore(score);
            reviewDto.setContent(content);
           
            
            // 서비스를 통해 리뷰 저장 (이미지 업로드 포함)
            buyerService.addReview(reviewDto, reviewImage);
            
            System.out.println("리뷰 등록 완료 - 상품ID: " + productId + ", 사용자ID: " + user.getId());
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "리뷰 등록 중 오류가 발생했습니다: " + e.getMessage());
        }

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
    
    @GetMapping("/address/UpdateForm")
    public String UpdateForm(HttpSession session, Model model) {
        UserEntity user = (UserEntity) session.getAttribute("loginUser");
        if (user == null) return "redirect:/login";

        model.addAttribute("user", user);  
        return "buyer/UpdateForm";        
    }
    
    
    @PostMapping("/address/updateUser")
    public String updateUser(
            @RequestParam("name")        String name,
            @RequestParam("email")        String email,
            @RequestParam("phoneNumber") String phoneNumber,
            @RequestParam("address")     String address,
            RedirectAttributes redirectAttributes,
            HttpSession session,
            Model model) {

        UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";
        
     // 이메일 중복 검사 (현재 로그인 사용자의 이메일은 예외)
     if (!loginUser.getEmail().equals(email) && userService.existsByEmail(email)) {
         redirectAttributes.addFlashAttribute("error", "이미 사용 중인 이메일입니다.");
         return "redirect:/mypage/address/UpdateForm";
     }
     
     if (!loginUser.getPhoneNumber().equals(phoneNumber) && userService.existsByPhoneNumber(phoneNumber)) {
         redirectAttributes.addFlashAttribute("error", "이미 사용 중인 전화번호입니다.");
         return "redirect:/mypage/address/UpdateForm";
     }

        // 엔티티 값 갱신
        loginUser.setName(name);
        loginUser.setEmail(email);
        loginUser.setPhoneNumber(phoneNumber);
        loginUser.setAddress(address);

        userRepository.save(loginUser);
        session.setAttribute("loginUser", loginUser);

        return "redirect:/";
    }
    
    @GetMapping("/order/list")
    public String orderList(HttpSession session, Model model) {

        UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login";

        /* 1) 헤더 : 최신순 JPQL 로 한 방 조회 */
        List<OrderSummaryDTO> headList =
                orderService.getOrderList(loginUser.getId());   // ← 이미 DESC 정렬

        /* 2) 상세 : 사용자별 전체 → 한 방 조회 후 groupingBy( LinkedHashMap ) */
        List<OrderDetailEntity> detailList =
        		detailRepository.findByUserId(loginUser.getId());

        Map<Long, List<OrderDetailEntity>> detailMap =
                detailList.stream()
                          .collect(Collectors.groupingBy(
                                  OrderDetailEntity::getOrderGroup,
                                  LinkedHashMap::new,          // ★ 삽입순서 유지
                                  Collectors.toList()));

        /* 3) 화면 전달 */
        model.addAttribute("headList",  headList);
        model.addAttribute("detailMap", detailMap);
        model.addAttribute("imagekitUrl", IMAGEKIT_URL_ENDPOINT);
        return "buyer/orderList";
    }

    

   

<<<<<<< HEAD
=======
		return "buyer/orderForm";
	}

	@GetMapping("/address/form")
	public String addressForm(HttpSession session, Model model) {
		UserEntity user = (UserEntity) session.getAttribute("loginUser");
		if (user == null)
			return "redirect:/login";

		model.addAttribute("user", user);
		return "buyer/addressForm";
	}

	@PostMapping("/address/update")
	public String updateAddress(@RequestParam("name") String name, @RequestParam("phoneNumber") String phoneNumber,
			@RequestParam("address") String address,
			@RequestParam(value = "postalCode", required = false) String postalCode, HttpSession session) {

		UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");
		if (loginUser == null)
			return "redirect:/login";

		loginUser.setName(name);
		loginUser.setPhoneNumber(phoneNumber);
		loginUser.setAddress(address);

		userRepository.save(loginUser);
		session.setAttribute("loginUser", loginUser);

		return "redirect:/mypage/order/form";
	}

	@GetMapping("/address/UpdateForm")
	public String UpdateForm(HttpSession session, Model model) {
		UserEntity user = (UserEntity) session.getAttribute("loginUser");
		if (user == null)
			return "redirect:/login";

		model.addAttribute("user", user);
		return "buyer/UpdateForm";
	}

	@PostMapping("/address/updateUser")
	public String updateUser(@RequestParam("name") String name, @RequestParam("email") String email,
			@RequestParam("phoneNumber") String phoneNumber, @RequestParam("address") String address,
			RedirectAttributes redirectAttributes, HttpSession session, Model model) {

		UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");
		if (loginUser == null)
			return "redirect:/login";

		// 이메일 중복 검사 (현재 로그인 사용자의 이메일은 예외)
		if (!loginUser.getEmail().equals(email) && userService.existsByEmail(email)) {
			redirectAttributes.addFlashAttribute("error", "이미 사용 중인 이메일입니다.");
			return "redirect:/mypage/address/UpdateForm";
		}

		if (!loginUser.getPhoneNumber().equals(phoneNumber) && userService.existsByPhoneNumber(phoneNumber)) {
			redirectAttributes.addFlashAttribute("error", "이미 사용 중인 전화번호입니다.");
			return "redirect:/mypage/address/UpdateForm";
		}

		// 엔티티 값 갱신
		loginUser.setName(name);
		loginUser.setEmail(email);
		loginUser.setPhoneNumber(phoneNumber);
		loginUser.setAddress(address);

		userRepository.save(loginUser);
		session.setAttribute("loginUser", loginUser);

		return "redirect:/";
	}

	@PostMapping("/cart/add")
	public String addToCart(@RequestParam("productId") String productId,
			@RequestParam("productSize") String productSize, @RequestParam("count") int count, HttpSession session,
			Model model) {
		UserEntity user = (UserEntity) session.getAttribute("loginUser");
		if (user == null) {
			return "redirect:/login";
		}

		try {
			buyerService.addToCart(user.getId(), productId, productSize, count);
			return "redirect:/mypage/cart"; // 장바구니 페이지로 이동
		} catch (RuntimeException e) {
			model.addAttribute("error", e.getMessage());
			// 기존 상세 페이지 URL 유지
			return "redirect:/mypage/product/detail?id=" + productId;
		}
	}

	@GetMapping("/order/list")
	public String orderList(
			@RequestParam(name = "start", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate start,
			@RequestParam(name = "end", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate end,
			HttpSession session, Model model) {

		UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");
		if (loginUser == null)
			return "redirect:/login";

		// 기본값: 최근 3개월
		if (start == null || end == null) {
			end = LocalDate.now();
			start = end.minusMonths(3);
		}

		Date s = java.sql.Timestamp.valueOf(start.atStartOfDay());
		Date e = java.sql.Timestamp.valueOf(end.atTime(23, 59, 59));

		// 1) 주문 헤더 (요약)
		List<OrderSummaryDTO> headList = orderService.getOrderListByPeriod(loginUser.getId(), s, e);

		// 2) 상세는 전체 불러오기 (필터링은 헤더 기준으로 충분함)
		List<OrderDetailEntity> detailList = detailRepository.findByUserId(loginUser.getId());

		Map<Long, List<OrderDetailEntity>> detailMap = detailList.stream().collect(
				Collectors.groupingBy(OrderDetailEntity::getOrderGroup, LinkedHashMap::new, Collectors.toList()));

		model.addAttribute("headList", headList);
		model.addAttribute("detailMap", detailMap);
		model.addAttribute("imagekitUrl", IMAGEKIT_URL_ENDPOINT);
		return "buyer/orderList";
	}
	
	private static final Map<String, String> SLUG_TO_KOR = Map.of(
	        "top", "상의",
	        "bottom", "하의",
	        "outer", "아우터",
	        "shoes", "신발",
	        "accessory", "액세서리"
	    );
	
	
	@GetMapping("/category/{slug}")
	public String listByCategory(@PathVariable("slug") String slug, Model model) {

	    String korCategory = SLUG_TO_KOR.get(slug.toLowerCase());
	    if (korCategory == null) {        // 잘못된 슬러그 보호
	        return "redirect:/";          // or 404 page
	    }

	    List<ProductEntity> products = productRepository.findByCategory(korCategory);

	    // ★ JSP에서 쓸 수 있게 한글 카테고리명을 category 로 넣어준다
	    model.addAttribute("category", korCategory);
	    model.addAttribute("products", products);
	    model.addAttribute("imagekitUrl", IMAGEKIT_URL_ENDPOINT);
	    return "buyer/productList";
	}



}