package com.kdt.project.user.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kdt.project.user.entity.UserEntity;

public interface UserRepositoy extends JpaRepository<UserEntity, String>{
	
//	   // 사용자 정의 메서드 추가 가능
//    Optional<UserEntity> findByIdAndPasswd(String id, String passwd);
//
//    Optional<UserEntity> findByPhoneNumber(String phoneNumber);
//
//    boolean existsById(String id);
}
