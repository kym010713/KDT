package com.kdt.project.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kdt.project.entity.User;

public interface UserRepository extends JpaRepository<User, String> {
    Optional<User> findByEmail(String email); // 필요시 이메일로 조회
}
