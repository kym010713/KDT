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
	
	public boolean containsIgnoreWhitespace(String source, String target) {
	    if (source == null || target == null) return false;
	    String sourceNoSpace = source.replaceAll("\\s+", "");
	    String targetNoSpace = target.replaceAll("\\s+", "");
	    return sourceNoSpace.contains(targetNoSpace);
	}

    public String getAnswer(String userInput) {
        List<FaqEntry> faqList = faqRepository.findAll();
        int no = 1;
        for (FaqEntry entry : faqList) {
        	if (containsIgnoreWhitespace(userInput, entry.getKeyword())) {
                return entry.getAnswer();
            }
        }

        return "죄송합니다. 질문을 이해하지 못했습니다.";
    }
}
