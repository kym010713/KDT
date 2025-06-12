package com.kdt.project.admin.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kdt.project.admin.entity.AdminEntity;
import com.kdt.project.admin.repository.AdminRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
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

	
	@Transactional
	@Override
	public void updateUser(String id, String email, String passwd) {

	    // ① 중복 이메일 검사
	    if (adminRepository.existsByEmailAndIdNot(email, id)) {
	        throw new IllegalStateException("이미 사용 중인 이메일입니다.");
	    }

	    // ② 실제 업데이트
	    AdminEntity user = adminRepository.findById(id)
	                                      .orElseThrow();
	    user.setEmail(email.trim());

	    if (passwd != null && !passwd.isBlank()) {
	        user.setPasswd(passwd);          // 평문 그대로
	    }
	    /* dirty-checking 으로 자동 UPDATE */
	}


}
