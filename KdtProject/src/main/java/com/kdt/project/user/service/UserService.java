package com.kdt.project.user.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.kdt.project.user.dto.UserDto;
import com.kdt.project.user.entity.UserEntity;
import com.kdt.project.user.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Service
public class UserService {


	@Autowired
	private UserRepository userRepository;
	
	 public boolean isDuplicate(UserDto dto, BindingResult bindingResult) {
	        boolean hasError = false;
	        // existsById - DB에 있는 id 중복검
	        if (userRepository.existsById(dto.getId())) {
	            bindingResult.rejectValue("id", "duplicate", "이미 존재하는 아이디입니다."); //rejectValue - 오류 등록 메서
	            hasError = true;
	        }

	        if (userRepository.existsByEmail(dto.getEmail())) {
	            bindingResult.rejectValue("email", "duplicate", "이미 존재하는 이메일입니다.");// duplicate - 중복 오류를 나타내기 위해 쓰는 오류 코드
	            hasError = true;
	        }
	        
	        if (userRepository.existsByPhoneNumber(dto.getPhoneNumber())) {
	            bindingResult.rejectValue("phoneNumber", "duplicate", "이미 존재하는 번입니다.");
	            hasError = true;
	        }

	        return hasError;
	    }

	public UserEntity join(UserDto dto) {	// 회원가입
		UserEntity user = new UserEntity();
		user.setId(dto.getId());
		user.setPasswd(dto.getPasswd());
		user.setEmail(dto.getEmail());
		user.setName(dto.getName());
		user.setPhoneNumber(dto.getPhoneNumber());
		user.setRole("BUYER");
		user.setAddress(dto.getAddress());
		user.setCreatedAt(dto.getCreatedAt());
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
	
	public String findId(String email) {
		Optional<UserEntity> optionalUser = userRepository.findByEmail(email);
		return optionalUser.map(UserEntity::getId).orElse(null);
	}
}
