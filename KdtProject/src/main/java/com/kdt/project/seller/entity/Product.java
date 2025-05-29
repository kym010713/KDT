package com.kdt.project.seller.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "PRODUCT")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
    
    @Id
    @Column(name = "PRODUCT_ID")
    private String productId;
    
    @Column(name = "CATEGORY")
    private String category;
    
    @Column(name = "PRODUCT_NAME", nullable = false)
    private String productName;
    
    @Column(name = "COMPANY_NAME", nullable = false)
    private String companyName;
    
    @Column(name = "PRODUCT_PHOTO")
    private String productPhoto;
}