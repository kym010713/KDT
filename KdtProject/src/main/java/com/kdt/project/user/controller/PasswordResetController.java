package com.kdt.project.user.controller;

import java.util.Map;
import java.util.Optional;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kdt.project.user.entity.UserEntity;
import com.kdt.project.user.repository.UserRepository;
import com.kdt.project.user.service.EmailService;

@Controller
public class PasswordResetController {

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private EmailService emailService;
    
    private Map<String, String> verificationCodes = new ConcurrentHashMap<>();
    
    @GetMapping("/find-password")
    public String showFindPasswordForm() {
        return "user/find-password";  // 비밀번호 찾기 입력 폼 JSP 이름
    }

    @GetMapping("/reset-password")
    public String showResetPasswordForm(@RequestParam("email") String email, Model model) {
        model.addAttribute("email", email);
        return "user/reset-password";  // 비밀번호 재설정 폼 JSP 이름
    }

    // STEP 1 - 인증번호 발송
    @PostMapping("/find-password/send-code")
    public String sendCode(@RequestParam("id") String id,
                           @RequestParam("email") String email,
                           Model model) {
        Optional<UserEntity> optionalUser = userRepository.findById(id);

        if (optionalUser.isEmpty() || !optionalUser.get().getEmail().equals(email)) {
            model.addAttribute("error", "아이디와 이메일이 일치하지 않습니다.");
            return "user/find-password";
        }

        // 인증번호 생성 & 저장
        String code = String.format("%04d", new Random().nextInt(10000));
        verificationCodes.put(email, code);

        // 이메일 전송
        emailService.sendEmail(email, "비밀번호 재설정 인증번호", "인증번호: " + code);
        model.addAttribute("email", email);
        model.addAttribute("id", id);
        model.addAttribute("message", "인증번호가 전송되었습니다.");
        return "user/find-password";
    }

    // STEP 2 - 인증번호 확인
    @PostMapping("/find-password/verify-code")
    public String verifyCode(@RequestParam("id") String id,
    						 @RequestParam("email") String email,
                             @RequestParam("code") String code,
                             Model model) {
        String savedCode = verificationCodes.get(email);

        if (savedCode != null && savedCode.equals(code)) {
            verificationCodes.remove(email); // 일회용
            model.addAttribute("id", id);
            model.addAttribute("email", email);
            return "user/reset-password";
        }

        model.addAttribute("error", "인증번호가 일치하지 않습니다.");
        return "user/find-password";
    }

    // STEP 3 - 비밀번호 변경
    @PostMapping("/reset-password")
    public String resetPassword(@RequestParam("id") String id,
    							@RequestParam("email") String email,
                                @RequestParam("newPassword") String newPassword,
                                RedirectAttributes redirectAttributes) {
        System.out.println("id: " + id); // null인지 확인
        System.out.println("email: " + email); // null인지 확인
        System.out.println("newPassword: " + newPassword);

        Optional<UserEntity> optionalUser = userRepository.findById(id);

        if (optionalUser.isEmpty()) {
        	redirectAttributes.addFlashAttribute("error", "존재하지 않는 사용자입니다.");
            return "user/find-password";
        }

        UserEntity user = optionalUser.get();
        user.setPasswd(newPassword); // 암호화 없이 저장
        userRepository.save(user);

        redirectAttributes.addFlashAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
        return "redirect:/login";
    }
}
