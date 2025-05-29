package com.kdt.project.buyer.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kdt.project.user.entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, String> {
    Optional<UserEntity> findByEmail(String email); // 필요시 이메일로 조회
}
