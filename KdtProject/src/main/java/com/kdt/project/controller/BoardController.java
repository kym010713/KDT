package com.kdt.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kdt.project.dto.BoardDTO;
import com.kdt.project.service.BoardService;

@Controller
@RequestMapping("board/*")
public class BoardController {
	
	@Autowired
	BoardService service;
	
	@RequestMapping("main")
	public String main() {
		
		return "board/main";
	}
	
	@RequestMapping("writeForm")
	public String writeForm(Model model) {
		
		model.addAttribute("boardDTO", new BoardDTO());
		return "board/writeForm";
	}
	
	@RequestMapping("writePro")
	public String writePro(BoardDTO dto, Model model) {
		int result = service.write(dto);
		
		model.addAttribute("result", result);
		return "board/writePro";
	}
	

}
