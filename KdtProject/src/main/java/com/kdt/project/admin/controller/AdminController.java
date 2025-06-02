package com.kdt.project.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kdt.project.admin.entity.AdminEntity;
import com.kdt.project.admin.service.AdminService;
import com.kdt.project.user.entity.UserEntity;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("admin/*")
public class AdminController {
	
	@Autowired
	private AdminService adminService;

	
	
	@RequestMapping("main")
	public String main(HttpSession session) {
	    Object loginUser = session.getAttribute("loginUser");
	    

	    if (loginUser == null || !"ADMIN".equals(((UserEntity) loginUser).getRole())) {
	        return "redirect:/";
	    }

	    return "admin/main";
	}

	
	@RequestMapping("userList")
	public String userList(@RequestParam(value = "keyword", required = false) String keyword,
	                       Model model) {
	    List<AdminEntity> userList;
	    if (keyword != null && !keyword.trim().isEmpty()) {
	        userList = adminService.findUsersByName(keyword.trim());
	    } else {
	        userList = adminService.findAllUsersExceptAdmin();
	    }
	    model.addAttribute("userList", userList);
	    return "admin/userList";
	}
	
	@RequestMapping(value = "updateGrade", method = RequestMethod.POST)
	public String updateGrade(@RequestParam("id") String id,
	                          @RequestParam("grade") String grade,
	                          HttpSession session) {
	    adminService.updateGrade(id, grade);
	    session.setAttribute("alertMsg", "등급 변경이 완료되었습니다.");
	    return "redirect:/admin/userList";
	}



	@RequestMapping(value = "deleteUser", method = RequestMethod.POST)
	public String deleteUser(@RequestParam("id") String id) {
	    adminService.deleteUserById(id);
	    return "redirect:/admin/userList";
	}


}
