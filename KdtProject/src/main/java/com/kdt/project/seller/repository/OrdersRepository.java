package com.kdt.project.seller.repository;

import com.kdt.project.seller.entity.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface OrdersRepository extends JpaRepository<Orders, Long> {
    
    // 전체 주문 내역 조회 (주문일 기준 내림차순)
    List<Orders> findAllByOrderByOrderDateDesc();
    
    // ORDER_GROUP으로 주문 조회 (ORDER_DETAIL과 연결할 때 사용)
    Optional<Orders> findByOrderGroup(Long orderGroup);
    
    // 사용자 ID로 주문 조회
    List<Orders> findByUserIdOrderByOrderDateDesc(String userId);
    
    // 특정 월의 주문 내역 조회
    @Query("SELECT o FROM Orders o WHERE YEAR(o.orderDate) = :year AND MONTH(o.orderDate) = :month ORDER BY o.orderDate DESC")
    List<Orders> findByYearAndMonth(@Param("year") int year, @Param("month") int month);
    
    // ORDER_ID로 조회
    Optional<Orders> findByOrderId(Long orderId);
}