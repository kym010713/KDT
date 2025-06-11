package com.kdt.project.order.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.util.Date;

@Entity
@Table(name = "ORDERS")
@Data
public class OrderEntity {

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
