package com.kdt.project.order.entity;

import com.kdt.project.buyer.entity.ProductEntity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "ORDER_DETAIL")
@Data
public class OrderDetailEntity {
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PRODUCT_ID", insertable = false, updatable = false)
	private ProductEntity product;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "DETAIL_ID")
    private Long detailId;

    @Column(name = "ORDER_GROUP")
    private Long orderGroup;      // FK → ORDERS.ORDER_GROUP

    @Column(name = "PRODUCT_ID")
    private String productId;

    @Column(name = "QUANTITY")
    private int quantity;

    @Column(name = "OPTION_VAL")
    private String optionVal;     // (사이즈·색상 등)
}
