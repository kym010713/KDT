package com.kdt.project.config;

import org.springframework.web.servlet.HandlerInterceptor;

import com.kdt.project.user.entity.UserEntity;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// 관리자 페이지 접근할 때 일반 사용자는 막는 클래스
public class AdminInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        Object user = session.getAttribute("loginUser");

        if (user == null || !"ADMIN".equals(((UserEntity) user).getRole())) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>alert('관리자만 접근 가능한 페이지입니다.'); location.href='/';</script>");
            return false;
        }
        return true;
    }
}