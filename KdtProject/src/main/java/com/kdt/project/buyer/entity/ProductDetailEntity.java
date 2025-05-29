package com.kdt.project.buyer.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "PRODUCT_DETAIL")
@Getter @Setter
public class ProductDetailEntity {

    @Id
    @Column(name = "PRODUCT_ID")
    private String productId;

    @Column(name = "PRODUCT_NAME")
    private String productName;

    @Column(name = "PRODUCT_COUNT")
    private int productCount;

    @Column(name = "PRODUCT_DETAIL")
    private String productDetail;

    @Column(name = "PRODUCT_PRICE")
    private String productPrice;

    @Column(name = "PRODUCT_SIZE")
    private String productSize;

    @Column(name = "PRODUCT_PHOTO")
    private String productPhoto;
}
