package com.kdt.project.order.dto;

import java.math.BigDecimal;
import java.util.Date;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderSummaryDTO {

    private Long        orderGroup;
    private Date        orderDate;
    private String      address;
    private BigDecimal  totalPrice;      // ← BigDecimal 로!
    private String      deliveryState;   // ← String 로!
    

    /**  JPQL (5-파라미터) 생성자  */
    public OrderSummaryDTO(Long        orderGroup,
                           Date        orderDate,
                           String      address,
                           BigDecimal  totalPrice,
                           String      deliveryState) {

        this.orderGroup    = orderGroup;
        this.orderDate     = orderDate;
        this.address       = address;
        this.totalPrice    = totalPrice;
        this.deliveryState = deliveryState;
    }

    /** 필요하다면 다른 JPQL용 3-파라미터 생성자도 추가 */
    public OrderSummaryDTO(Long orderGroup,
                           Date orderDate,
                           String deliveryState) {
        this.orderGroup    = orderGroup;
        this.orderDate     = orderDate;
        this.deliveryState = deliveryState;
    }
}
