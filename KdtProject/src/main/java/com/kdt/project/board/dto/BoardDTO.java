package com.kdt.project.board.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardDTO {
	private int boardId;
	private String boardWriter;
	private String boardTitle;
	private String boardContent;
	private int boardCount;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
	
	public String getFormattedDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        if (updatedAt != null) {
            return updatedAt.format(formatter);
        } else if (createdAt != null) {
            return createdAt.format(formatter);
        }
        return "";
    }
	
	

}
