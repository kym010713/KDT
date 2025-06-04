package com.kdt.project.admin.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kdt.project.admin.entity.AdminEntity;
import com.kdt.project.user.entity.UserEntity;

@Repository
public interface AdminRepository extends JpaRepository<AdminEntity, String> {
    List<AdminEntity> findByRoleNot(String role);		//유저 리스트 불러오기
    List<AdminEntity> findByNameContainingAndRoleNot(String name, String role);

}