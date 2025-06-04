package com.kdt.project.chatbot.dto;

import lombok.Data;

@Data
public class FaqDto {
	private Long id;
    private String keyword;
    private String answer;

}
