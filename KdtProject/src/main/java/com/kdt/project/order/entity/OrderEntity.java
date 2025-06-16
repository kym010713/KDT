package com.kdt.project.order.entity;

import java.util.Date;

import com.kdt.project.seller.entity.Delivery;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "ORDERS")
@Data
public class OrderEntity {
	
	 @OneToOne(mappedBy = "order", fetch = FetchType.LAZY)
	 private Delivery delivery;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ORDER_ID")
    private Long orderId;          // 새 PK

    @Column(name = "ORDER_GROUP")
    private Long orderGroup;       // 주문 묶음 번호

    @Column(name = "USER_ID")
    private String userId;

    @Column(name = "ORDER_DATE")
    private Date orderDate;

    @Column(name = "ORDER_CREATED")
    private String orderCreated;

    @Column(name = "ORDER_ADDRESS")
    private String orderAddress;
}
