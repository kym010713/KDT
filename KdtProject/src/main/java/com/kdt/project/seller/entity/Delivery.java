package com.kdt.project.seller.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.Date;

@Entity
@Table(name = "DELIVERY")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Delivery {
    
    @Id
    @Column(name = "DELIVERY_ID")
    private Long deliveryId;
    
    @Column(name = "ORDER_NUMBER")
    private Long orderNumber;
    
    @Column(name = "DELIVERY_STATE")
    private String deliveryState; // 'REQUESTED', 'IN_PROGRESS', 'COMPLETED'
    
    @Column(name = "REQUEST_DATE")
    @Temporal(TemporalType.DATE)
    private Date requestDate;
    
    @Column(name = "COMPLETE_DATE")
    @Temporal(TemporalType.DATE)
    private Date completeDate;
}