package com.kdt.project.dto;

import java.util.Date;

import lombok.Data;
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
	private Date createdAt;
	private Date updatedAt;
	
	

}
