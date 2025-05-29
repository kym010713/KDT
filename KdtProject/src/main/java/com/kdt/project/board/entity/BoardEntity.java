package com.kdt.project.board.entity;

import java.time.LocalDateTime;
import java.util.Date;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.kdt.project.board.dto.BoardDTO;

import jakarta.annotation.Generated;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name="board")
public class BoardEntity {
	@Column(name = "board_id")
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "board_gen")
	@SequenceGenerator(name="board_gen", sequenceName="board_seq", allocationSize=1, initialValue=1)
	private int id;
	
	@Column(name = "board_writer", nullable = false)
	private String writer;
	
	@Column(name = "board_title", nullable = false)
	private String title;
	
	@Column(name = "board_content", nullable = false)
	private String content;
	
	@Column(name = "board_count", nullable = false)
	private int readCount = 0;
	
	@Column(name = "created_at", updatable = false)	
	@CreationTimestamp			
	private LocalDateTime writeTime;
	
	@Column(name = "updated_at")
	private LocalDateTime updatedAt;
	
	public static BoardEntity toSaveEntity(BoardDTO dto) {
		BoardEntity entity = new BoardEntity();
		entity.setWriter(dto.getBoardWriter());
		entity.setTitle(dto.getBoardTitle());
		entity.setContent(dto.getBoardContent());
		return entity;
	}
	
	public static BoardDTO toBoardDTO(BoardEntity entity) {
		BoardDTO dto = new BoardDTO();
		dto.setBoardId(entity.getId());
		dto.setBoardWriter(entity.getWriter());
		dto.setBoardTitle(entity.getTitle());
		dto.setBoardContent(entity.getContent());
		dto.setBoardCount(entity.getReadCount());
		dto.setCreatedAt(entity.getWriteTime());
		dto.setUpdatedAt(entity.getUpdatedAt());
		return dto;
	}
	
	
}
