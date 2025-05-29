package com.kdt.project.user.dto;

import lombok.Data;

@Data
public class UserDto {

	private String id;
	private String passwd;
	private String email;
	private String name;
	private String phoneNumber;
	private String role;
	private String address;
}
