// SizesRepository.java
package com.kdt.project.seller.repository;

import com.kdt.project.seller.entity.Sizes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SizesRepository extends JpaRepository<Sizes, Long> {
    
    // 사이즈 이름으로 조회하는 메서드 추가
    Optional<Sizes> findBySizeName(String sizeName);
}