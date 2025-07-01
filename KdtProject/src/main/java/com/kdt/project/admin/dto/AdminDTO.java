package com.kdt.project.admin.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class AdminDTO {
	private String id;
	private String passwd;
	private String email;
	private String name;
	private String phoneNumber;
	private String role;
	private String address;
	private LocalDateTime createdAt;
	private String grade;
}
