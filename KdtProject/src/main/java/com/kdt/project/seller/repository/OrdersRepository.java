package com.kdt.project.seller.repository;

import com.kdt.project.seller.entity.Orders;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrdersRepository extends JpaRepository<Orders, Long> {
    
    // 전체 주문 내역 조회 (주문일 기준 내림차순)
    List<Orders> findAllByOrderByOrderDateDesc();
    
    // 특정 회사의 상품 주문 내역 조회 
    @Query("SELECT o FROM Orders o JOIN Product p ON o.productId = p.productId WHERE p.companyName = :companyName ORDER BY o.orderDate DESC")
    List<Orders> findByCompanyNameOrderByOrderDateDesc(@Param("companyName") String companyName);
    
    // 특정 월의 주문 내역 조회
    @Query("SELECT o FROM Orders o WHERE YEAR(o.orderDate) = :year AND MONTH(o.orderDate) = :month ORDER BY o.orderDate DESC")
    List<Orders> findByYearAndMonth(@Param("year") int year, @Param("month") int month);
}