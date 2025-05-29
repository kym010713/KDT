package com.kdt.project.buyer.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "PRODUCT")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductEntity {
    
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
