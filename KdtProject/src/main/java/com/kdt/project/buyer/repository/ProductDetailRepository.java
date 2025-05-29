package com.kdt.project.buyer.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kdt.project.buyer.entity.ProductDetailEntity;

public interface ProductDetailRepository extends JpaRepository<ProductDetailEntity, String> {
    ProductDetailEntity findByProductId(String productId);
}
