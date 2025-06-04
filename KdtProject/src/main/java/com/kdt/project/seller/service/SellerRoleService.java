package com.kdt.project.seller.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.kdt.project.seller.entity.SellerRoleEntity;

@Service
public interface SellerRoleService {
    public void applySellerRole(SellerRoleEntity entity) throws IllegalArgumentException;
    List<SellerRoleEntity> getAllApplications();
    
    @Transactional
    public void updateStatusToApproved(Long sellerRoleId);
    
    // 승인된 판매자의 회사명 조회
    public String getCompanyNameBySellerId(String sellerId);
}