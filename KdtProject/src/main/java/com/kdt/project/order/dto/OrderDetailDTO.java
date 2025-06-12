
package com.kdt.project.order.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class OrderDetailDTO {
    private Long orderGroup;
    private String productName;  // product.productName
    private int quantity;
}
