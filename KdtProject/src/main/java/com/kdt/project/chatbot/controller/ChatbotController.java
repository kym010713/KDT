package com.kdt.project.chatbot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.kdt.project.chatbot.service.ChatbotService;

@Controller
@RequestMapping("/chatbot")
public class ChatbotController {

    private final ChatbotService chatbotService;

    public ChatbotController(ChatbotService chatbotService) {
        this.chatbotService = chatbotService;
    }

    // 챗봇 메인 페이지 (JSP로 질문 입력폼)
    @GetMapping("/faq")
    public String index() {
        return "chatbot/chatbot";
    }

    // 질문 받는 POST 요청
    @PostMapping("/ask")
    public String ask(@RequestParam("question") String question, Model model) {
        String answer = chatbotService.getAnswer(question);
        model.addAttribute("question", question);
        model.addAttribute("answer", answer);
        return "chatbot/chatbot";
    }
}
