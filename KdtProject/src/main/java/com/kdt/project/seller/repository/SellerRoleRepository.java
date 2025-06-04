package com.kdt.project.seller.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.kdt.project.seller.entity.SellerRoleEntity;
import java.util.Optional;

@Repository
public interface SellerRoleRepository extends JpaRepository<SellerRoleEntity, Long> {
    boolean existsByBusinessNumber(String businessNumber);
    boolean existsBySellerName(String sellerName);
    
    // 승인된 판매자의 회사명 조회
    Optional<SellerRoleEntity> findBySellerIdAndStatus(String sellerId, String status);
}
