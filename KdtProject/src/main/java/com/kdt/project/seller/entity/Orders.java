package com.kdt.project.seller.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.Date;

@Entity
@Table(name = "ORDERS")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Orders {
    
    @Id
    @Column(name = "ORDER_NUMBER")
    private Long orderNumber;
    
    @Column(name = "USER_ID")
    private String userId;
    
    @Column(name = "PRODUCT_ID")
    private String productId;
    
    @Column(name = "ORDER_DATE")
    @Temporal(TemporalType.DATE)
    private Date orderDate;
    
    @Column(name = "ORDER_CREATED")
    private String orderCreated; 
    
    @Column(name = "ORDER_ADDRESS")
    private String orderAddress;
}