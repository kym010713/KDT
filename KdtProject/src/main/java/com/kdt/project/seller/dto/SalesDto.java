package com.kdt.project.seller.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SalesDto {
    
    private Long orderNumber;           // 주문번호
    private String userId;              // 구매자 ID
    private String productName;         // 상품명
    private String companyName;         // 제조사
    private String productPrice;        // 상품 가격
    private Date orderDate;             // 주문일
    private String orderAddress;        // 배송 주소
    private String deliveryState;       // 배송 상태
    private Date requestDate;           // 배송 요청일
    private Date completeDate;          // 배송 완료일
}