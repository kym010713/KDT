package com.kdt.project.seller.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Min;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

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
    
    @NotBlank(message = "상품 사이즈를 입력해주세요")
    private String productSize;
    
    @NotNull(message = "상품 수량을 입력해주세요")
    @Min(value = 1, message = "상품 수량은 1개 이상이어야 합니다")
    private Integer productCount;
    
    private String productPhoto;
}