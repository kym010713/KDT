package com.kdt.project.user.dto;

import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserDto {

	private String id;
	private String passwd;
	private String email;
	private String name;
	private String phoneNumber;
	private String role;
	private String address;
	private LocalDateTime createdAt;
}
