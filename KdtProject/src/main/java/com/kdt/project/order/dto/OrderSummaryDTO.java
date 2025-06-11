package com.kdt.project.order.dto;
import java.math.BigDecimal;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class OrderSummaryDTO {
    private Long   orderGroup;   // 주문번호
    private Date   orderDate;    // 주문일
    private String address;      // 배송지
    private BigDecimal      totalPrice;   // 주문 총액
}