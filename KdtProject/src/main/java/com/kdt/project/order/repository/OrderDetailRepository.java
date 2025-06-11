package com.kdt.project.order.repository;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kdt.project.order.entity.OrderDetailEntity;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetailEntity, Long> {
	
    List<OrderDetailEntity> findByOrderGroup(Long orderGroup);

}
