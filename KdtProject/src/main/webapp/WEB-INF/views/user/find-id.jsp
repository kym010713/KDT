<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>아이디 찾기</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/find-id.css" />
</head>
<body>
    <div class="form-container">
        <h2>아이디 찾기</h2>
        
        <p class="description">
            가입 시 등록한 이메일을 입력하시면<br>
            아이디를 찾아드립니다.
        </p>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/find-id" method="post">
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required placeholder="example@email.com" />
            </div>
            <button type="submit">아이디 찾기</button>
        </form>

        <div class="links">
            <a href="${pageContext.request.contextPath}/find-password">비밀번호 찾기</a>
            <a href="${pageContext.request.contextPath}/login">로그인</a>
        </div>
    </div>
</body>
</html>