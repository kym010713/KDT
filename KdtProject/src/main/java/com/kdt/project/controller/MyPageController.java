package com.kdt.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kdt.project.dto.MyPageDto;
import com.kdt.project.service.MyPageService;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    private final MyPageService myPageService;

    public MyPageController(MyPageService myPageService) {
        this.myPageService = myPageService;
    }


    @GetMapping
    public String getMyPage(@RequestParam("id") String id, Model model) {
        MyPageDto user = myPageService.getMyPage(id);
        model.addAttribute("user", user);
        return "buyer/myPage"; // /WEB-INF/views/myPage.jsp 렌더링
    }
}
