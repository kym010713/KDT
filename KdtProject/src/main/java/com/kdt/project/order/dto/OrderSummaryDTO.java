package com.kdt.project.order.dto;

import java.time.*; 
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderSummaryDTO {

    private Long          orderGroup;
    private LocalDateTime orderDate;
    private String        address;
    private BigDecimal    totalPrice;
    private String        deliveryState;

    /* ───────────── 3-파라미터 (쿼리 그대로) ───────────── */
    public OrderSummaryDTO(Long orderGroup,
                           LocalDateTime orderDate,
                           String deliveryState) {
        this.orderGroup    = orderGroup;
        this.orderDate     = orderDate;
        this.deliveryState = deliveryState;
    }

    public OrderSummaryDTO(Long orderGroup,
                           java.util.Date orderDate,     // ← Timestamp 대응
                           String deliveryState) {
        this(orderGroup,
             orderDate == null ? null
                               : LocalDateTime.ofInstant(orderDate.toInstant(),
                                                         ZoneId.systemDefault()),
             deliveryState);
    }

    /* ───────────── 5-파라미터 (집계 쿼리) ───────────── */
    public OrderSummaryDTO(Long orderGroup,
                           LocalDateTime orderDate,
                           String address,
                           BigDecimal totalPrice,
                           String deliveryState) {
        this.orderGroup    = orderGroup;
        this.orderDate     = orderDate;
        this.address       = address;
        this.totalPrice    = totalPrice;
        this.deliveryState = deliveryState;
    }

    public OrderSummaryDTO(Long orderGroup,
                           java.util.Date orderDate,
                           String address,
                           BigDecimal totalPrice,
                           String deliveryState) {
        this(orderGroup,
             orderDate == null ? null
                               : LocalDateTime.ofInstant(orderDate.toInstant(),
                                                         ZoneId.systemDefault()),
             address,
             totalPrice,
             deliveryState);
    }
    
    
    public String getFormattedOrderDate() {
        return orderDate == null
               ? ""
               : orderDate.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

}
