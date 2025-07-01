package com.kdt.project.admin.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.kdt.project.admin.entity.AdminEntity;

@Repository
public interface AdminRepository extends JpaRepository<AdminEntity, String> {
    List<AdminEntity> findByRoleNot(String role);		//유저 리스트 불러오기
    List<AdminEntity> findByNameContainingAndRoleNot(String name, String role);
    
    //구매자 등급 변경
    @Modifying
    @Query("UPDATE AdminEntity u SET u.grade = :grade WHERE u.id = :id")
    void updateUserGrade(@Param("id") String id, @Param("grade") String grade);

    boolean existsByEmailAndIdNot(String email, String id);
}