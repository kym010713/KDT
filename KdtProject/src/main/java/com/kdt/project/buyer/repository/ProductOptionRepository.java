package com.kdt.project.buyer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kdt.project.buyer.entity.ProductOptionEntity;
import com.kdt.project.buyer.entity.ProductOptionId;

@Repository
public interface ProductOptionRepository extends JpaRepository<ProductOptionEntity, ProductOptionId> {
    List<ProductOptionEntity> findByProduct_ProductId(String productId);
}
