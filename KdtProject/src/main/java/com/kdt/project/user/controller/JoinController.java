package com.kdt.project.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.kdt.project.user.dto.UserDto;
import com.kdt.project.user.service.UserService;

@Controller
public class JoinController {

	@Autowired
	private UserService userService;
	
	@GetMapping("/join")
	public String JoinForm() {
		return "user/join";		// 회원가입폼으로 이동 
	}
	
	@PostMapping("/join")
	public String joinForm(UserDto dto) {
		userService.join(dto);
		return "redirect:/user/login";
	}
		

}
