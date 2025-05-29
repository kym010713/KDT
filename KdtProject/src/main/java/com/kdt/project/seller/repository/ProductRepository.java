package com.kdt.project.seller.repository;

import com.kdt.project.seller.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, String> {
    boolean existsByProductName(String productName);
    List<Product> findByCategory(String category);  
}