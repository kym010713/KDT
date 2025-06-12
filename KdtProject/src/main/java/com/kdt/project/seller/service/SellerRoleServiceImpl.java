package com.kdt.project.seller.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdt.project.seller.entity.SellerRoleEntity;
import com.kdt.project.seller.repository.SellerRoleRepository;
import com.kdt.project.user.repository.UserRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@RequiredArgsConstructor
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
    public void updateStatusToApproved(Long id) {
        SellerRoleEntity e = sellerRoleRepository.findById(id).orElseThrow();
        e.setStatus("Y");               // Dirty-checking
        userRepository.updateUserRoleToSeller(e.getSellerId());
        // save() 호출 불필요 – TX commit 시 flush
    }
    
    @Override
    public String getCompanyNameBySellerId(String sellerId) {
        Optional<SellerRoleEntity> sellerRole = sellerRoleRepository.findBySellerIdAndStatus(sellerId, "Y");
        return sellerRole.map(SellerRoleEntity::getBrandName).orElse(null);
    }
    
    
    @Override
    public void updateStatusToRejected(Long id) {
    	sellerRoleRepository.updateStatusToRejected(id);   // ← @Modifying query
    }
    
    @Override
    public void deleteApplication(Long sellerRoleId) {
        sellerRoleRepository.deleteById(sellerRoleId);
        
    }
}