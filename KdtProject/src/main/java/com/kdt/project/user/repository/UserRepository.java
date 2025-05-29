package com.kdt.project.user.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kdt.project.user.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, String>{

	boolean existsById(String id);
	boolean existsByPhoneNumber(String phoneNumber);
	boolean existsByEmail(String email);
	
	Optional<UserEntity> findByEmail(String email);
}
