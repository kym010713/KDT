package com.kdt.project.buyer.controller;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kdt.project.buyer.dto.KakaoApproveResponse;
import com.kdt.project.buyer.dto.KakaoReadyResponse;
import com.kdt.project.buyer.entity.CartEntity;
import com.kdt.project.buyer.repository.CartRepository;
import com.kdt.project.buyer.service.KakaoPayService;
import com.kdt.project.order.entity.OrderEntity;
import com.kdt.project.order.repository.OrderRepository;
import com.kdt.project.order.service.OrderService;
import com.kdt.project.user.entity.UserEntity;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage/order/kakao")
public class KakaoPayController {

    private final KakaoPayService kakaoPayService;
    private final OrderService   orderService;
    private final CartRepository  cartRepository;
    private final OrderRepository orderRepository;

    // 1. 결제 준비
    @PostMapping("/ready")
    public String kakaoPayReady(@RequestParam("totalPrice") int totalPrice,
    		 					@RequestParam(value="orderAddress", required=false) String orderAddress,
                                 HttpSession session) {

        if (orderAddress == null) {
            // 기본 주소 사용
            orderAddress = ((UserEntity)session.getAttribute("loginUser")).getAddress();
        }
        
        KakaoReadyResponse res = kakaoPayService.ready(totalPrice);
        session.setAttribute("tid", res.getTid());
        session.setAttribute("orderAddress", orderAddress);  // ★ 배송지 세션 보관
        return "redirect:" + res.getNextRedirectPcUrl();
    }



    // 2. 결제 승인 (성공)
    @Transactional
    @GetMapping("/approve")
    public String kakaoPayApprove(@RequestParam("pg_token") String pgToken,
                                  HttpSession session,
                                  Model model) {

        /* 1. 카카오 결제 승인 */
        String tid = (String) session.getAttribute("tid");
        KakaoApproveResponse approve = kakaoPayService.approve(tid, pgToken);

        /* 2. 로그인 사용자 · 배송지 */
        UserEntity loginUser  = (UserEntity) session.getAttribute("loginUser");
        String      address  = (String) session.getAttribute("orderAddress");

        /* 3. 장바구니에서 상품 ID 리스트 추출 */
        List<CartEntity> cartList   = cartRepository.findByUser(loginUser);
        List<String> productIds     = cartList.stream()
                                              .map(c -> c.getProduct().getProductId())
                                              .toList();
        orderService.saveOrder(loginUser.getId(), cartList, address);

        /* 4. ORDERS 테이블에 저장  (CSV 한 줄 저장 방식)  */
        // 4-1) 주문번호 생성
        long orderNumber = System.currentTimeMillis(); 

        // 4-2) CSV 문자열로 합치기  "P01,P02,P03"
        String joinedIds = String.join(",", productIds);


        /* 5. 장바구니 비우기 */
        cartRepository.deleteByUser(loginUser);
        session.removeAttribute("tid");
        session.removeAttribute("orderAddress");

        /* 6. 성공 페이지 */
        model.addAttribute("approve", approve);
        return "buyer/orderSuccess";
    }


    // 3. 결제 취소
    @GetMapping("/cancel")
    public String kakaoPayCancel() {
        return "buyer/order/cancel"; // 이 JSP도 필요
    }

    // 4. 결제 실패
    @GetMapping("/fail")
    public String kakaoPayFail() {
        return "buyer/order/fail"; // 이 JSP도 필요
    }
}