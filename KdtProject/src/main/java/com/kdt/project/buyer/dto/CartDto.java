package com.kdt.project.buyer.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartDto {
    private Long cartId;
    private String productId;
    private String productName;
    private String productPhoto;
    private int cartCount;
    private String productSize;
}
