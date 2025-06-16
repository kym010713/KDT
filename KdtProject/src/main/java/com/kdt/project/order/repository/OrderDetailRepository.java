package com.kdt.project.order.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.kdt.project.order.dto.OrderDetailDTO;
import com.kdt.project.order.entity.OrderDetailEntity;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetailEntity, Long> {
	@Query("""
	        SELECT new com.kdt.project.order.dto.OrderDetailDTO(
	            d.orderGroup,
	            d.product.productName,
	            d.quantity
	        )
	        FROM OrderDetailEntity d
	        WHERE d.orderGroup = :orderGroup
	    """)
	    List<OrderDetailDTO> findDetailsByOrderGroup(@Param("orderGroup") Long orderGroup);
	
    List<OrderDetailEntity> findByOrderGroup(Long orderGroup);
    
    @Query("""
            SELECT d
              FROM OrderDetailEntity d
              JOIN OrderEntity   o ON o.orderGroup = d.orderGroup
             WHERE o.userId = :userId
             ORDER BY o.orderDate DESC, d.detailId
            """)
     List<OrderDetailEntity> findByUserId(@Param("userId") String userId);
    
    
    @Query("""
    		SELECT COUNT(d) > 0
    		FROM   OrderDetailEntity d
    		JOIN   OrderEntity  o ON o.orderGroup = d.orderGroup
    		WHERE  o.userId   = :userId
    		AND    d.productId = :productId
    		""")
    		public boolean existsPurchasedByUser(String userId, String productId);

}
