package com.kdt.project.order.repository;

import com.kdt.project.order.entity.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface OrderEntityRepository extends JpaRepository<OrderEntity, Long> {
    
    // ORDER_GROUP으로 주문 조회
    Optional<OrderEntity> findByOrderGroup(Long orderGroup);
    
    // ORDER_ID로 조회
    Optional<OrderEntity> findByOrderId(Long orderId);
}