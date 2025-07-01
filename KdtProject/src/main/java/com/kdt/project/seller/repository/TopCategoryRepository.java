package com.kdt.project.seller.repository;

import com.kdt.project.seller.entity.TopCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TopCategoryRepository extends JpaRepository<TopCategory, String> {
}