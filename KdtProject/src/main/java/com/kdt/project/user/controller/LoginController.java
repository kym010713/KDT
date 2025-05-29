package com.kdt.project.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kdt.project.user.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

	@Autowired
	private UserService userService;

	@GetMapping("/login")
	public String loginForm() {
		return "user/login";
	}

	@PostMapping("/login")
	public String loginForm(@RequestParam("id") String id,
							@RequestParam("passwd") String passwd,
							HttpSession session,
							Model model) {
		String loginResult = userService.login(id,passwd,session);

		if(!"로그인 성공".equals(loginResult)) {
			model.addAttribute("error", loginResult);
			return "user/login"; // 로그인 실패시 다시 로그인 페이지
		}

		return "redirect:/"; // 메인페이지 이동
	}
}
