package com.kdt.project.seller.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kdt.project.seller.entity.SellerRoleEntity;

@Repository
public interface SellerRoleRepository extends JpaRepository<SellerRoleEntity, Long> {
    boolean existsByBusinessNumber(String businessNumber);
    boolean existsBySellerName(String sellerName);
}