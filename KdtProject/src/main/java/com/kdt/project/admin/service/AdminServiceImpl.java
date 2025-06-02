package com.kdt.project.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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


}
