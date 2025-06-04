package com.kdt.project.seller.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "PRODUCT_OPTIONS")
@Data
@NoArgsConstructor
@AllArgsConstructor
@IdClass(ProductOptionsId.class)
public class ProductOptions {
    
    @Id
    @Column(name = "PRODUCT_ID")
    private String productId;
    
    @Id
    @Column(name = "SIZE_ID")
    private Long sizeId;
    
    @Column(name = "PRODUCT_STOCK", nullable = false)
    private Integer productStock;
    
   
    public String getProductId() {
        return productId;
    }
    
    public void setProductId(String productId) {
        this.productId = productId;
    }
    
    public Long getSizeId() {
        return sizeId;
    }
    
    public void setSizeId(Long sizeId) {
        this.sizeId = sizeId;
    }
    
    public Integer getProductStock() {
        return productStock;
    }
    
    public void setProductStock(Integer productStock) {
        this.productStock = productStock;
    }
}