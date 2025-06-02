package com.kdt.project.buyer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kdt.project.buyer.entity.CartEntity;
public interface CartRepository extends JpaRepository<CartEntity, Long> {
	List<CartEntity> findByUser_Id(String userId);
}
