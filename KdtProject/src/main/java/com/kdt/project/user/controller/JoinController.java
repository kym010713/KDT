package com.kdt.project.user.controller;

import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.kdt.project.user.dto.UserDto;
import com.kdt.project.user.service.UserService;

import jakarta.validation.Valid;

@Controller
public class JoinController {

	@Autowired
	private UserService userService;

	@GetMapping("/join")
	public String JoinForm() {
		return "user/join";		// 회원가입폼으로 이동
	}


	// BindingResult의 필드별 에러를 Map<String, String> 으로 변환하는 헬퍼 메서드
	private Map<String, String> getErrors(BindingResult bindingResult) {
	    return bindingResult.getFieldErrors().stream()
	            .collect(Collectors.toMap(
	                    FieldError::getField,           // 에러 필드명 (예: "id", "email")
	                    FieldError::getDefaultMessage, // 에러 메시지 (예: "아이디를 입력해주세요.")
	                    (msg1, msg2) -> msg1            // 동일 필드 여러 에러 시 첫 번째 메시지 사용
	            ));
	}
	
	@PostMapping("/join")
	public String joinForm(@Valid UserDto userDto, BindingResult bindingResult, Model model) {
	    // 1. 기본 유효성 검사
	    if (bindingResult.hasErrors()) {
	    	// 에러가 있으면 에러 메시지 Map 생성해서 모델에 담음
	        model.addAttribute("errors", getErrors(bindingResult));
	        model.addAttribute("userDto", userDto);
	        return "user/join";
	    }

	    // 2. 중복 검사 (bindingResult에 에러 추가)
	    userService.isDuplicate(userDto, bindingResult);

	    // 3. 중복 검사 후 에러가 있으면 다시 뷰로
	    if (bindingResult.hasErrors()) {
	        model.addAttribute("errors", getErrors(bindingResult));
	        model.addAttribute("userDto", userDto);
	        return "user/join";
	    }

	    // 4. 회원가입 진행
	    userService.join(userDto);
	    return "redirect:/login";
	}

	

}
