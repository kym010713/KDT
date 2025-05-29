package com.kdt.project.user.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdt.project.user.dto.UserDto;
import com.kdt.project.user.entity.UserEntity;
import com.kdt.project.user.repository.UserRepositoy;

import jakarta.servlet.http.HttpSession;

@Service
public class UserService {

	
	@Autowired
	private UserRepositoy userRepository;
	
	public UserEntity join(UserDto dto) {	// 회원가입
		UserEntity user = new UserEntity();
		user.setId(dto.getId());
		user.setPasswd(dto.getPasswd());
		user.setEmail(dto.getEmail());
		user.setName(dto.getName());
		user.setPhoneNumber(dto.getPhoneNumber());
		user.setRole("BUYER");
		user.setAddress(dto.getAddress());
		return userRepository.save(user);
	}
	
	public String login(String id, String passwd, HttpSession session) {
	    Optional<UserEntity> optionalUser = userRepository.findById(id);

	    if (optionalUser.isEmpty()) {
	        return "존재하지 않는 아이디입니다.";
	    }

	    UserEntity user = optionalUser.get();
	    if (!user.getPasswd().equals(passwd)) {
	        return "비밀번호가 일치하지 않습니다.";
	    }

	    // 로그인 성공 시 세션에 저장
	    session.setAttribute("loginUser", user);
	    return "로그인 성공";
	}	
}
