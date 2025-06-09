package com.kdt.project.user.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="users")
public class UserEntity {
	@Id
	private String id;

	@Column(name = "password")
	private String passwd;

	private String email;

	private String name;

	@Column(name = "phone_number")
	private String phoneNumber;

	private String role;

	private String address;
	private String grade;
	@Column(name = "created_at")
	private LocalDateTime createdAt;
	
	@PrePersist
	public void onCreate() {
	    this.createdAt = LocalDateTime.now();
	}
}
