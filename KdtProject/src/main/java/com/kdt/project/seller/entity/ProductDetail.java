package com.kdt.project.seller.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "PRODUCT_DETAIL")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDetail {
    
    @Id
    @Column(name = "PRODUCT_NAME")
    private String productName;
    
    @Column(name = "PRODUCT_COUNT", nullable = false)
    private Integer productCount;
    
    @Column(name = "PRODUCT_DETAIL", nullable = false)
    private String productDetail;
    
    @Column(name = "PRODUCT_PRICE", nullable = false)
    private String productPrice;
    
    @Column(name = "PRODUCT_SIZE", nullable = false)
    private String productSize;
    
    @Column(name = "PRODUCT_PHOTO")
    private String productPhoto;
    
    @Column(name = "PRODUCT_ID", nullable = false)  
    private String productId;
    
}