package com.kdt.project.user.controller;

import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kdt.project.user.service.EmailService;
import com.kdt.project.user.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/join")
public class EmailVerificationController {

    private Map<String, String> verificationCodes = new ConcurrentHashMap<>();

    @Autowired
    private EmailService emailService;
    @Autowired
    private UserService userService;

    @PostMapping("/send-code")
    @ResponseBody
    public String sendCode(@RequestParam("email") String email) {
        // 이메일 중복 체크 - userService를 통해 검사
        if (userService.existsByEmail(email)) {
            return "duplicate";  // 이미 회원가입된 이메일임을 알려줌
        }

        String code = String.format("%06d", new Random().nextInt(1000000));
        verificationCodes.put(email, code);
        emailService.sendEmail(email, "회원가입 인증번호", "인증번호: " + code);
        return "success";
    }

    // 인증번호 검증
    @PostMapping("/verify-code")
    @ResponseBody
    public String verifyCode(@RequestParam("email") String email, @RequestParam("code") String code, HttpSession session) {
        String savedCode = verificationCodes.get(email);
        if (savedCode != null && savedCode.equals(code)) {
            verificationCodes.remove(email);
            session.setAttribute("emailVerified", email);
            return "verified";
        }else { 
        	return "fail";
        }
        
    }
}
