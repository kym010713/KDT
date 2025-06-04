package com.kdt.project.seller.repository;

import com.kdt.project.seller.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductSellerRepository extends JpaRepository<Product, String> {
    boolean existsByProductName(String productName);
    
    // 카테고리별 상품 조회 메서드 추가
    List<Product> findByCategory(String category);
}