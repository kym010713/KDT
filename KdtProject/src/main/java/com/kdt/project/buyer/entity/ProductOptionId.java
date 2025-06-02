package com.kdt.project.buyer.entity;

import java.io.Serializable;

import jakarta.persistence.Embeddable;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@Embeddable
@Getter @Setter
@EqualsAndHashCode
public class ProductOptionId implements Serializable {

    private String productId;  // Long -> String 변경
    private Long sizeId;

    public ProductOptionId() {}

    public ProductOptionId(String productId, Long sizeId) {
        this.productId = productId;
        this.sizeId = sizeId;
    }
}
