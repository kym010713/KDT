package com.kdt.project.admin.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kdt.project.admin.entity.AdminEntity;
import com.kdt.project.admin.service.AdminService;
import com.kdt.project.seller.entity.SellerRoleEntity;
import com.kdt.project.seller.service.SellerRoleService;
import com.kdt.project.user.entity.UserEntity;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("admin/*")
public class AdminController {
	
	@Autowired
	private AdminService adminService;
	
    @Autowired
    private SellerRoleService sellerRoleService;

	
	
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
	
	
	@RequestMapping("applyList")
	public String viewApplyList(HttpSession session, Model model, HttpServletResponse response) throws IOException {
	    UserEntity loginUser = (UserEntity) session.getAttribute("loginUser");


	    if (loginUser == null || !"ADMIN".equals(loginUser.getRole())) {
	        response.setContentType("text/html;charset=UTF-8");
	        response.getWriter().println("<script>alert('관리자만 접근 가능한 페이지입니다.'); location.href='/';</script>");
	        return null;
	    }

	    List<SellerRoleEntity> applyList = sellerRoleService.getAllApplications();
	    model.addAttribute("applyList", applyList);

	    return "admin/applyList";
	}

	@RequestMapping(value = "approveSeller", method = RequestMethod.POST)
	@ResponseBody
	public String approveSeller(@RequestParam("sellerRoleId") Long sellerRoleId) {
	    sellerRoleService.updateStatusToApproved(sellerRoleId);  // status = 'Y'
	    return "OK";
	}
	
	@RequestMapping(value = "rejectSeller", method = RequestMethod.POST)
	@ResponseBody
	public String rejectSeller(@RequestParam("sellerRoleId") Long sellerRoleId) {
	    sellerRoleService.updateStatusToRejected(sellerRoleId);   // status = 'N'
	    return "OK";
	}
	
	@RequestMapping(value = "deleteApplication", method = RequestMethod.POST)
	@ResponseBody
	public String deleteApplication(@RequestParam("sellerRoleId") Long sellerRoleId) {
	    sellerRoleService.deleteApplication(sellerRoleId);
	    return "OK";
	}
	
	
	@PostMapping("updateUser")
	public String updateUser(
	        @RequestParam("id")    String id,
	        @RequestParam("email") String email,
	        @RequestParam(value = "passwd", required = false) String passwd,
	        RedirectAttributes ra) {

	    try {
	        adminService.updateUser(id, email, passwd);   // ← 아까 만든 서비스
	        ra.addFlashAttribute("alertMsg", "수정 완료!");
	    } catch (IllegalStateException e) {               // 이메일 중복
	        ra.addFlashAttribute("alertMsg", e.getMessage());
	    }
	    return "redirect:/admin/userList";
	}




}
