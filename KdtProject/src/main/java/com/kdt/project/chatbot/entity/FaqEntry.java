package com.kdt.project.chatbot.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "faq")
public class FaqEntry {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String keyword;

    @Lob
    @Column(nullable = false)
    private String answer;

    public FaqEntry() {}

    public FaqEntry(String keyword, String answer) {
        this.keyword = keyword;
        this.answer = answer;
    }

}
