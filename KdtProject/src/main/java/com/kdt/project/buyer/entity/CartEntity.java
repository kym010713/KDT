package com.kdt.project.buyer.entity;

import java.util.Date;

import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.user.entity.UserEntity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "CART", schema = "TEAM03")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "cart_seq_gen")
    @SequenceGenerator(name = "cart_seq_gen", sequenceName = "CART_SEQ", allocationSize = 1)
    @Column(name = "CART_ID")
    private Long cartId;

    @Column(name = "CART_COUNT", nullable = false)
    private int cartCount;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "CART_DATE")
    private Date cartDate;

    @Column(name = "PRODUCT_SIZE", length = 100)
    private String productSize;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", referencedColumnName = "ID")
    private UserEntity user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PRODUCT_ID", referencedColumnName = "PRODUCT_ID")
    private ProductEntity product;

    @PrePersist
    protected void onCreate() {
        if (cartDate == null) {
            cartDate = new Date(); // Oracle의 SYSDATE 대응
        }
    }
}
