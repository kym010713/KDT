// SizesRepository.java
package com.kdt.project.seller.repository;

import com.kdt.project.seller.entity.Sizes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SizesRepository extends JpaRepository<Sizes, Long> {
    Optional<Sizes> findBySizeName(String sizeName);
}