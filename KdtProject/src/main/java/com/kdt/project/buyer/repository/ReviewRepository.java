package com.kdt.project.buyer.repository;

import com.kdt.project.buyer.entity.ReviewEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReviewRepository extends JpaRepository<ReviewEntity, Long> {
    List<ReviewEntity> findByProduct_ProductId(String productId);
}
