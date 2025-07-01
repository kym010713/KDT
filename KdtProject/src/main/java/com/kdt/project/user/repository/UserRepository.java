package com.kdt.project.user.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.kdt.project.user.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, String>{

	boolean existsById(String id);
	boolean existsByPhoneNumber(String phoneNumber);
	boolean existsByEmail(String email);
	
	Optional<UserEntity> findByEmail(String email);
	
	//입점 완료 됐을 때 유저 테이블의 role 데이터를 seller로 바꾸는 쿼리
    @Modifying
    @Query("UPDATE UserEntity u SET u.role = 'SELLER' WHERE u.id = :id")
    void updateUserRoleToSeller(@Param("id") String id);
}
