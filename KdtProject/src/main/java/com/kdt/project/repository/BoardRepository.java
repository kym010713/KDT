package com.kdt.project.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.kdt.project.entity.BoardEntity;

@Repository
public interface BoardRepository extends JpaRepository<BoardEntity, Integer> {
	@Modifying
	@Query("update BoardEntity b set b.readCount=b.readCount + 1 where id = :id")
	public void updateReadCount(@Param("id") int id);
	
	
	
}
