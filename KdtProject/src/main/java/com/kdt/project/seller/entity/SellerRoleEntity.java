package com.kdt.project.seller.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "SELLER_ROLE")
@Data
public class SellerRoleEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SELLER_ROLE_ID")
    private Long sellerRoleId; // 기본키: 식별자

    @Column(name = "SELLER_ID")
    private String sellerId; // USERS 테이블 참조

    @Column(name = "SELLER_NAME", nullable = false)
    private String sellerName;

    @Column(name = "SELLER_ADDRESS", nullable = false)
    private String sellerAddress;

    @Column(name = "SELLER_PHONE", nullable = false)
    private String sellerPhone;

    @Column(name = "BUSINESS_NUMBER", nullable = false, unique = true)
    private String businessNumber;

    @Column(name = "BRAND_NAME", nullable = false, unique = true)
    private String brandName;

    @Column(name = "STATUS")
    private String status = "N"; // 기본값은 미승인
}
