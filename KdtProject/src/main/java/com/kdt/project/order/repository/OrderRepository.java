package com.kdt.project.order.repository;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.kdt.project.order.dto.OrderSummaryDTO;
import com.kdt.project.order.entity.OrderEntity;

@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Long> {
   @Query("""
         SELECT new com.kdt.project.order.dto.OrderSummaryDTO(
                  o.orderGroup,
                  o.orderDate,
                  COALESCE(CAST(del.deliveryState AS string), 'REQUESTED')  
         )
         FROM   OrderEntity o
         LEFT JOIN o.delivery del
         WHERE  o.userId = :userId
         ORDER  BY o.orderDate DESC
         """)
         List<OrderSummaryDTO> findOrderSummaries(@Param("userId") String userId);




    List<OrderEntity> findByUserId(String userId);
    
    @Query("""
           SELECT new com.kdt.project.order.dto.OrderSummaryDTO(
                  o.orderGroup,
                  CAST(o.orderDate AS timestamp),
                  CAST(COALESCE(del.deliveryState, 'REQUESTED') AS string)
           )
           FROM  OrderEntity o
           LEFT JOIN Delivery del               
                  ON del.orderNumber = o.orderGroup 
           WHERE o.userId = :userId
             AND o.orderDate BETWEEN :start AND :end
           ORDER BY o.orderDate DESC
       """)
       List<OrderSummaryDTO> findSummaryByUserIdAndPeriod(
               @Param("userId") String userId,
               @Param("start")  Date   start,
               @Param("end")    Date   end);






}
