package com.kdt.project.seller.repository;

import com.kdt.project.seller.entity.Delivery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface DeliveryRepository extends JpaRepository<Delivery, Long> {
    
    // 주문번호로 배송 정보 조회
    Optional<Delivery> findByOrderNumber(Long orderNumber);
}