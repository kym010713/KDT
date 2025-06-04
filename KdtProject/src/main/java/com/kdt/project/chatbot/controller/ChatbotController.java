package com.kdt.project.chatbot.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.kdt.project.chatbot.dto.FaqDto;
import com.kdt.project.chatbot.service.ChatbotService;

import jakarta.servlet.http.HttpSession;

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
    public String ask(@RequestParam("question") String question, Model model, HttpSession session) {
    	
        String answer = chatbotService.getAnswer(question);

        // 세션에 저장된 대화 리스트 가져오기 (없으면 새로 생성)
        List<FaqDto> chatHistory = (List<FaqDto>) session.getAttribute("chatHistory");
        if (chatHistory == null) {
            chatHistory = new ArrayList<>();
        }

        // 새 질문과 답변을 FaqDto 객체로 만들어 리스트에 추가
        FaqDto newEntry = new FaqDto();
        newEntry.setKeyword(question);  // 질문을 keyword 필드에 저장
        newEntry.setAnswer(answer);     // 답변을 answer 필드에 저장
        chatHistory.add(newEntry);

        // 다시 세션에 저장
        session.setAttribute("chatHistory", chatHistory);

        // 모델에도 대화 리스트 전달
        model.addAttribute("chatHistory", chatHistory);

        return "chatbot/chatbot";
    }
    
    @GetMapping("/clear")
    public String clearChatHistory(HttpSession session) {
        session.removeAttribute("chatHistory");
        return "redirect:/chatbot/faq"; // 챗봇 기본 페이지로 리다이렉트
    }
}
