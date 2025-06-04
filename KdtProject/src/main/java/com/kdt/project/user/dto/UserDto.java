package com.kdt.project.user.dto;

import java.time.LocalDateTime;
import java.util.Date;

import com.kdt.project.buyer.entity.ProductEntity;
import com.kdt.project.user.entity.UserEntity;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {
	@NotBlank(message = "아이디를 입력하세요.")
	private String id;
	@NotBlank(message = "비밀번호를 입력하세요.")
	private String passwd;
	@NotBlank(message = "이메일를 입력하세요.")
	private String email;
	@NotBlank(message = "이름을 입력하세요.")
	private String name;
	@NotBlank(message = "휴대폰번호를 입력하세요.")
	private String phoneNumber;
	
	private String role;
	@NotBlank(message = "주소를 입력하세요.")
	private String address;
	private String grade;
	
	private LocalDateTime createdAt;
}
