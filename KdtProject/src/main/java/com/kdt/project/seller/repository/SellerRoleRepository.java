package com.kdt.project.seller.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kdt.project.seller.entity.SellerRoleEntity;

@Repository
public interface SellerRoleRepository extends JpaRepository<SellerRoleEntity, Long> {
    boolean existsByBusinessNumber(String businessNumber);
    boolean existsBySellerName(String sellerName);
    
    // 승인된 판매자의 회사명 조회
    Optional<SellerRoleEntity> findBySellerIdAndStatus(String sellerId, String status);
    
    @Modifying(clearAutomatically = true)
    @Transactional
    @Query("UPDATE SellerRoleEntity s SET s.status='N' WHERE s.sellerRoleId=:id")
    void updateStatusToRejected(@Param("id") Long id);
}
