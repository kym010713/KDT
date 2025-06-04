package com.kdt.project.buyer.entity;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "PRODUCT_OPTIONS")
@Getter @Setter
public class ProductOptionEntity {

    @EmbeddedId
    private ProductOptionId id;

    @MapsId("productId")  // 복합키 ProductOptionId 안의 필드 이름과 일치시킴
    @ManyToOne
    @JoinColumn(name = "PRODUCT_ID")
    private ProductEntity product;

    @MapsId("sizeId")
    @ManyToOne
    @JoinColumn(name = "SIZE_ID")
    private SizeEntity size;

    @Column(name = "PRODUCT_STOCK")
    private int stock;
}

