package com.kdt.project.buyer.service;

import com.kdt.project.buyer.dto.KakaoApproveResponse;
import com.kdt.project.buyer.dto.KakaoReadyResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
@RequiredArgsConstructor
public class KakaoPayService {

    @Value("${kakaopay.cid}")
    private String cid;

    @Value("${kakaopay.admin-key}")
    private String adminKey; 

    @Value("${kakaopay.approval-url}")
    private String approvalUrl;

    @Value("${kakaopay.cancel-url}")
    private String cancelUrl;

    @Value("${kakaopay.fail-url}")
    private String failUrl;

    private final RestTemplate restTemplate = new RestTemplate();

    // 결제 준비 요청
    public KakaoReadyResponse ready(int totalAmount) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.set("Authorization", "KakaoAK " + adminKey);  // ✅ 수정됨

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("cid", cid);
        params.add("partner_order_id", "ORDER_1234");
        params.add("partner_user_id", "USER_5678");
        params.add("item_name", "장바구니 상품");
        params.add("quantity", "1");
        params.add("total_amount", String.valueOf(totalAmount));
        params.add("tax_free_amount", "0");

        params.add("approval_url", approvalUrl);
        params.add("cancel_url", cancelUrl);
        params.add("fail_url", failUrl);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

        ResponseEntity<KakaoReadyResponse> response = restTemplate.postForEntity(
                "https://kapi.kakao.com/v1/payment/ready",  // ✅ 수정됨
                request,
                KakaoReadyResponse.class
        );

        return response.getBody();
    }

    // 결제 승인 요청
    public KakaoApproveResponse approve(String tid, String pgToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.set("Authorization", "KakaoAK " + adminKey);  // ✅ 수정됨

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("cid", cid);
        params.add("tid", tid);
        params.add("partner_order_id", "ORDER_1234");
        params.add("partner_user_id", "USER_5678");
        params.add("pg_token", pgToken);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

        ResponseEntity<KakaoApproveResponse> response = restTemplate.postForEntity(
                "https://kapi.kakao.com/v1/payment/approve",  // ✅ 수정됨
                request,
                KakaoApproveResponse.class
        );

        return response.getBody();
    }
}
