<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>로그인</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/login.css" />
</head>
<body>
    <div class="login-box">
        <h2>로그인</h2>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <c:if test="${not empty message}">
            <script>
                alert("${message}");
            </script>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" required>
            </div>

            <div class="form-group">
                <label for="passwd">비밀번호</label>
                <input type="password" id="passwd" name="passwd" required>
            </div>

            <button type="submit">로그인</button>
        </form>

        <div class="links">
            <a href="${pageContext.request.contextPath}/find-id">아이디 찾기</a>
            <a href="${pageContext.request.contextPath}/find-password">비밀번호 찾기</a>
        </div>

        <p class="signup-text">
            계정이 없으신가요? <a href="${pageContext.request.contextPath}/join">회원가입</a>
        </p>
    </div>
</body>
</html>