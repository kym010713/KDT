package com.kdt.project.buyer.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kdt.project.buyer.entity.SizeEntity;

@Repository
public interface SizeRepository extends JpaRepository<SizeEntity, Long> {
}
