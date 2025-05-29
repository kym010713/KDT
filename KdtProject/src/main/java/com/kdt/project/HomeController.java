package com.kdt.project;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.kdt.project.user.entity.UserEntity;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(HttpSession session, Model model) {
        UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login"; // 로그인 안 된 경우 로그인 페이지로 이동
        }

        model.addAttribute("userName", loginUser.getName());
        return "main"; // home.jsp를 보여줌
    }
}
