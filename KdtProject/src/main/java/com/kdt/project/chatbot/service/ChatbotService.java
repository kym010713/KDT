package com.kdt.project.chatbot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kdt.project.chatbot.entity.FaqEntry;
import com.kdt.project.chatbot.repository.FaqRepository;

import java.util.List;

@Service
public class ChatbotService {
	
	@Autowired
	FaqRepository faqRepository;

    public String getAnswer(String userInput) {
        List<FaqEntry> faqList = faqRepository.findAll();

        for (FaqEntry entry : faqList) {
            if (userInput.contains(entry.getKeyword())) {
                return entry.getAnswer();
            }
        }

        return "죄송합니다. 질문을 이해하지 못했습니다.";
    }
}
