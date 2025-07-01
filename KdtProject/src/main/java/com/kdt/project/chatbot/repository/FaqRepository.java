package com.kdt.project.chatbot.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.kdt.project.chatbot.entity.FaqEntry;

public interface FaqRepository extends JpaRepository<FaqEntry, Long> {}
