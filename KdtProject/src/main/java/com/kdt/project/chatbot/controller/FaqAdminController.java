package com.kdt.project.chatbot.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kdt.project.chatbot.entity.FaqEntry;
import com.kdt.project.chatbot.repository.FaqRepository;

@Controller
@RequestMapping("/admin/faq")
public class FaqAdminController {

    @Autowired
    private FaqRepository faqRepository;

    // 리스트
    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("faqList", faqRepository.findAll());
        return "chatbot/faqList";
    }

    // 추가
    @PostMapping("/add")
    public String add(@ModelAttribute FaqEntry faq) {
        faqRepository.save(faq);
        return "redirect:/admin/faq/list";
    }

    // 수정
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable("id")Long id, @ModelAttribute FaqEntry faq,
    							RedirectAttributes redirectAttributes) {
        FaqEntry existing = faqRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("FAQ not found"));
        existing.setKeyword(faq.getKeyword());
        existing.setAnswer(faq.getAnswer());
        faqRepository.save(existing);
        redirectAttributes.addFlashAttribute("message", "수정 완료");
        return "redirect:/admin/faq/list";
    }

    // 삭제
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        faqRepository.deleteById(id);
        return "redirect:/admin/faq/list";
    }
}
