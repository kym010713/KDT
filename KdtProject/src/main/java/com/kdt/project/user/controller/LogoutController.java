package com.kdt.project.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class LogoutController {
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate();  // 세션 초기화 
	    return "redirect:/login";  // 로그아웃 후 로그인 페이지로 이동
	}
}
