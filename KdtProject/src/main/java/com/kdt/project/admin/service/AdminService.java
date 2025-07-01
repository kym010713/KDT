package com.kdt.project.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kdt.project.admin.entity.AdminEntity;
import com.kdt.project.user.entity.UserEntity;

@Service
public interface AdminService {
    List<AdminEntity> findAllUsersExceptAdmin();
	public void deleteUserById(String id);
	List<AdminEntity> findUsersByName(String keyword);
	public void updateGrade(String id, String grade);
	public void updateUser(String id, String email, String passwd);
	


}
