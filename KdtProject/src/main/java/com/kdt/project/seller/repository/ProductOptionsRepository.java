package com.kdt.project.seller.repository;

import com.kdt.project.seller.entity.ProductOptions;
import com.kdt.project.seller.entity.ProductOptionsId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface ProductOptionsRepository extends JpaRepository<ProductOptions, ProductOptionsId> {
    
    // 특정 상품의 모든 옵션 조회
    List<ProductOptions> findByProductId(String productId);
    
    // 특정 상품의 모든 옵션 삭제
    @Modifying
    @Transactional
    @Query("DELETE FROM ProductOptions po WHERE po.productId = :productId")
    void deleteByProductId(@Param("productId") String productId);
}