package com.kdt.project.admin.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdt.project.admin.entity.AdminEntity;
import com.kdt.project.admin.repository.AdminRepository;

@Service
public class AdminServiceImpl implements AdminService{
	
    @Autowired
    private AdminRepository adminRepository;

	@Override
	public List<AdminEntity> findAllUsersExceptAdmin() {
		return adminRepository.findByRoleNot("ADMIN");
	}

	@Override
	public void deleteUserById(String id) {
		adminRepository.deleteById(id);
	}

	@Override
	public List<AdminEntity> findUsersByName(String keyword) {
	    return adminRepository.findByNameContainingAndRoleNot(keyword, "ADMIN");
	}
	
	@Override
	public void updateGrade(String id, String grade) {
	    Optional<AdminEntity> optional = adminRepository.findById(id);
	    if (optional.isPresent()) {
	        AdminEntity user = optional.get();
	        user.setGrade(grade);
	        adminRepository.save(user);
	    }
	}




}
