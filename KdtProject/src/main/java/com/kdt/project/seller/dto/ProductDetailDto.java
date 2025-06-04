package com.kdt.project.seller.dto;

import com.kdt.project.seller.entity.Product;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDetailDto {
    private Product product;
    private String sizeName;
    private Integer stock;
    private Long sizeId;
    private boolean isFirstSizeRow; // 상품의 첫 번째 사이즈 행인지 여부
    private int sizeCount; // 해당 상품의 총 사이즈 수
}