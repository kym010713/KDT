package com.kdt.project.order.repository;

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
			          MAX(o.orderDate),     
			          MAX(o.orderAddress),
			          SUM(d.quantity * p.productPrice))
			     FROM OrderEntity  o
			     JOIN OrderDetailEntity d ON d.orderGroup = o.orderGroup
			     JOIN ProductEntity p     ON p.productId   = d.productId
			    WHERE o.userId = :userId
			 GROUP BY o.orderGroup
			 ORDER BY MAX(o.orderDate) DESC       
			""")
			List<OrderSummaryDTO> findOrderSummaries(@Param("userId") String userId);



	
    List<OrderEntity> findByUserId(String userId);


}
