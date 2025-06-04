<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/find-password.css" />
</head>
<body>
    <div class="form-container">
        <h2>비밀번호 찾기</h2>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="success-message">${message}</div>
        </c:if>

        <form method="post" action="/find-password/send-code" id="findPasswordForm">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" required />
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required />
            </div>

            <button type="submit">인증번호 요청</button>
        </form>

        <form method="post" action="/find-password/verify-code" class="verification-form" id="verificationForm">
            <div class="form-group">
                <label for="code">인증번호</label>
                <input type="text" id="code" name="code" required />
                <input type="hidden" name="id" value="${id}" />
                <input type="hidden" name="email" value="${email}" />
            </div>
            <button type="submit">인증번호 확인</button>
        </form>
        
         <div class="links">
            <a href="${pageContext.request.contextPath}/find-id">아이디 찾기</a>
            <a href="${pageContext.request.contextPath}/login">로그인</a>
       </div>
        
    </div>
    
    <script>
        // 인증번호 요청 성공 시 인증번호 입력 폼 표시
        if ('${message}' && '${message}'.includes('전송되었습니다')) {
            document.getElementById('verificationForm').classList.add('show');
        }
    </script>
</body>
</html>