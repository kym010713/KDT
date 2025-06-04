package com.kdt.project.buyer.repository;

import com.kdt.project.buyer.entity.ProductEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<ProductEntity, String> {
}
