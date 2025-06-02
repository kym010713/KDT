package com.kdt.project.buyer.entity;

import java.math.BigDecimal;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "PRODUCT")
@Getter @Setter
public class ProductEntity {
    @Id
    @Column(name = "PRODUCT_ID")
    private String productId;

    @Column(name = "PRODUCT_NAME")
    private String productName;

    @Column(name = "COMPANY_NAME")
    private String companyName;

    @Column(name = "CATEGORY")
    private String category;

    @Column(name = "PRODUCT_PRICE")
    private BigDecimal productPrice;

    @Column(name = "PRODUCT_PHOTO")
    private String productPhoto;

    @Column(name = "PRODUCT_DETAIL")
    private String productDetail;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    private List<ProductOptionEntity> options;
}
