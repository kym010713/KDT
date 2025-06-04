package com.kdt.project.seller.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdt.project.seller.entity.SellerRoleEntity;
import com.kdt.project.seller.repository.SellerRoleRepository;
import com.kdt.project.user.repository.UserRepository;

@Service
public class SellerRoleServiceImpl implements SellerRoleService {

    @Autowired
    private SellerRoleRepository sellerRoleRepository;
    
    @Autowired
    private UserRepository userRepository;

    @Override
    public void applySellerRole(SellerRoleEntity entity) throws IllegalArgumentException {
        boolean existsName = sellerRoleRepository.existsBySellerName(entity.getBrandName());
        boolean existsBusinessNumber = sellerRoleRepository.existsByBusinessNumber(entity.getBusinessNumber());

        if (existsName) {
            throw new IllegalArgumentException("이미 존재하는 회사명입니다.");
        }

        if (existsBusinessNumber) {
            throw new IllegalArgumentException("이미 존재하는 사업자 번호입니다.");
        }

        sellerRoleRepository.save(entity);
    }
    
    @Override
    public List<SellerRoleEntity> getAllApplications() {
        return sellerRoleRepository.findAll();
    }
    
    @Override
    @Transactional
    public void updateStatusToApproved(Long sellerRoleId) {
        SellerRoleEntity entity = sellerRoleRepository.findById(sellerRoleId).orElseThrow();
        entity.setStatus("Y");
        sellerRoleRepository.save(entity);

        // 승인된 판매자의 사용자 ROLE 업데이트
        userRepository.updateUserRoleToSeller(entity.getSellerId());
    }
    
    @Override
    public String getCompanyNameBySellerId(String sellerId) {
        Optional<SellerRoleEntity> sellerRole = sellerRoleRepository.findBySellerIdAndStatus(sellerId, "Y");
        return sellerRole.map(SellerRoleEntity::getBrandName).orElse(null);
    }
}