package com.kdt.project.buyer.controller;

import com.kdt.project.buyer.dto.KakaoApproveResponse;
import com.kdt.project.buyer.dto.KakaoReadyResponse;
import com.kdt.project.buyer.service.KakaoPayService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage/order/kakao")
public class KakaoPayController {

    private final KakaoPayService kakaoPayService;

    // 1. 결제 준비
    @PostMapping("/ready")
    public String kakaoPayReady(@RequestParam("totalPrice") int totalPrice, HttpSession session) {
        KakaoReadyResponse response = kakaoPayService.ready(totalPrice);

        // 결제 고유번호 tid 세션에 저장
        session.setAttribute("tid", response.getTid());

        // 카카오 결제창 URL로 리다이렉트
        return "redirect:" + response.getNextRedirectPcUrl();
    }

    // 2. 결제 승인 (성공)
    @GetMapping("/approve")
    public String kakaoPayApprove(@RequestParam("pg_token") String pgToken, HttpSession session, Model model) {
        String tid = (String) session.getAttribute("tid");
        if (tid == null) {
            // 예외 처리
            return "redirect:/error";
        }

        KakaoApproveResponse approve = kakaoPayService.approve(tid, pgToken);

        // 승인된 결제 정보 모델에 담기
        model.addAttribute("approve", approve);

        // 결제 완료 페이지로 이동
        return "buyer/orderSuccess";  // 이 JSP 만들어줘야 함
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