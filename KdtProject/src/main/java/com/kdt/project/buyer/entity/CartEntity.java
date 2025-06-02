package com.kdt.project.buyer.entity;

import java.util.Date;

import com.kdt.project.user.entity.UserEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID", referencedColumnName = "ID")
    private UserEntity user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PRODUCT_NAME", referencedColumnName = "PRODUCT_NAME")
    private ProductEntity product;

    @PrePersist
    protected void onCreate() {
        if (cartDate == null) {
            cartDate = new Date(); // Oracle의 SYSDATE 대응
        }
    }
}
