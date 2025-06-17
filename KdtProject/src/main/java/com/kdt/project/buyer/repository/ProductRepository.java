package com.kdt.project.buyer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kdt.project.buyer.entity.ProductEntity;

public interface ProductRepository extends JpaRepository<ProductEntity, String> {
	
    List<ProductEntity> findByCategory(String category);
	
}
