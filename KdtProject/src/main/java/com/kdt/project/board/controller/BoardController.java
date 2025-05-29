package com.kdt.project.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kdt.project.board.dto.BoardDTO;
import com.kdt.project.board.service.BoardService;
import com.kdt.project.user.entity.UserEntity;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
	public String writeForm(HttpSession session, Model model) {
	    UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");

	    if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
	        return "redirect:/login";
	    }

	    model.addAttribute("boardDTO", new BoardDTO());
	    return "board/writeForm";
	}

	
	@RequestMapping("writePro")
	public String writePro(BoardDTO dto, HttpSession session, Model model) {
	    UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");

	    if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
	        return "redirect:/login";
	    }

	    dto.setBoardWriter("관리자");
	    int result = service.write(dto);

	    model.addAttribute("result", result);
	    return "board/writePro";
	}

	
	@RequestMapping("list")
	public String list(BoardDTO dto, Model model,
			@RequestParam(name = "page", defaultValue="0") int page,
			@RequestParam(name = "size", defaultValue="5") int size ) {
		
		Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "id"));
		
		Page<BoardDTO> boardList = service.writeList(pageable);
		
		int currentPage = boardList.getNumber();
		
		int totalPage = boardList.getTotalPages();
		
		int blockSize = 10;
		
		int startPage = (currentPage / blockSize) * 10;
		int endPage = Math.max(0, Math.min(startPage + blockSize - 1, totalPage - 1));
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPage", totalPage);
		
		model.addAttribute("boardList", boardList);
		return "board/list";
	}
	
	
	@RequestMapping("listDetail")
	public String listDetail(@RequestParam("id") int id,
	                         @RequestParam("page") int page,
	                         HttpServletRequest request,
	                         HttpServletResponse response,
	                         Model model) {

	    boolean isViewed = false;
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("viewed_" + id)) {
	                isViewed = true;
	                break;
	            }
	        }
	    }

	    if (!isViewed) {
	        service.readCountUpdate(id);
	        Cookie cookie = new Cookie("viewed_" + id, "true");
	        cookie.setMaxAge(60 * 60 * 6);
	        cookie.setPath("/");
	        response.addCookie(cookie);
	    }

	    BoardDTO dto = service.writeDetail(id);
	    model.addAttribute("dto", dto);
	    model.addAttribute("page", page);

	    return "board/listDetail";
	}
	
	
	@RequestMapping("update")
	public String updateForm(@RequestParam("id") int id, @RequestParam("page") int page,
	                         HttpSession session, Model model) {
	    UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");

	    if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
	        return "redirect:/login";
	    }

	    BoardDTO dto = service.boardUpdate(id);
	    model.addAttribute("dto", dto);
	    model.addAttribute("page", page);
	    return "board/updateForm";
	}

	
	
	@RequestMapping("updatePro")
	public String updatePro(BoardDTO dto, @RequestParam("page") int page,
	                        HttpSession session, Model model) {
	    UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");

	    if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
	        return "redirect:/login";
	    }

	    int result = service.boardUpdatePro(dto);
	    model.addAttribute("result", result);
	    model.addAttribute("dto", dto);
	    model.addAttribute("page", page);
	    return "board/updatePro";
	}

	
	
	@RequestMapping("delete")
	public String delete(@RequestParam("id") int id, HttpSession session) {
	    UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");

	    if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
	        return "redirect:/login";
	    }

	    service.delete(id);
	    return "redirect:/board/list";
	}

	
	

}
