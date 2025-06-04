package com.kdt.project.seller.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Min;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductRegistrationDto {
    
    @NotBlank(message = "카테고리를 선택해주세요")
    private String category;
    
    @NotBlank(message = "상품명을 입력해주세요")
    private String productName;
    
    @NotBlank(message = "제조사를 입력해주세요")
    private String companyName;
    
    @NotBlank(message = "상품 설명을 입력해주세요")
    private String productDetail;
    
    @NotBlank(message = "상품 가격을 입력해주세요")
    private String productPrice;
    
    private String productPhoto;
    
    // 사이즈별 재고 관리를 위한 리스트
    private List<ProductOptionDto> productOptions;
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ProductOptionDto {
        private Long sizeId;
        private String sizeName;
        private Integer stock;
    }
}