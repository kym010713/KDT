package com.kdt.project.admin.entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="users")
public class AdminEntity {
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

	@Column(name = "created_at")
	private LocalDateTime createdAt;
	
	
    public String getFormattedCreatedAt() {
        if (createdAt == null) return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return createdAt.format(formatter);
    }
}

