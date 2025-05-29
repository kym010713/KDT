package com.kdt.project.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kdt.project.user.service.UserService;

@Controller
public class FindIdController {
	
	@Autowired
	UserService userService;
	
	@GetMapping("/find-id")
	public String findIdForm() {
	    return "user/find-id";  // 아이디 찾기 폼 JSP
	}

	@PostMapping("/find-id")
	public String findIdSubmit(@RequestParam("email") String email, Model model) {
	    String id = userService.findId(email);

	    if(id == null) {
	        model.addAttribute("error", "등록된 이메일이 없습니다.");
	    } else {
	        model.addAttribute("findid", id);
	    }
	    return "user/find-id-result";  // 결과 페이지
	}
}
