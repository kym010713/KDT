package com.kdt.project.seller.entity;

import java.io.Serializable;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductOptionsId implements Serializable {
    
    private String productId;
    private Long sizeId;
    
}