package com.kdt.project.buyer.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartDTO {
    private Long cartId;
    private String productId;
    private String productName;
    private String productPhoto;
    private int cartCount;
    private String productSize;
}
