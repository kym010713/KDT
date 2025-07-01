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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ORDER_ID")
    private Long orderId;
    
    @Column(name = "USER_ID")
    private String userId;
    
    @Column(name = "ORDER_DATE")
    @Temporal(TemporalType.DATE)
    private Date orderDate;
    
    @Column(name = "ORDER_CREATED")
    private String orderCreated; 
    
    @Column(name = "ORDER_ADDRESS")
    private String orderAddress;
    
    @Column(name = "ORDER_GROUP")
    private Long orderGroup;
    
 
    public Long getOrderNumber() {
        return this.orderGroup; 
    }
}