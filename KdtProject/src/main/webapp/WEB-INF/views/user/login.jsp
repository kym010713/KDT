<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>로그인</title>
</head>
<body>

<h2>로그인</h2>
<!-- 로그인시 아이디 비번 확인 에러 메시지 -->
<c:if test="${not empty error}">
    <div style="color:red;">${error}</div>
</c:if>

<!-- 비밀번호 찾고 수정완료시 메세지 -->
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>

<c:if test="${not empty error}">
    <script>
        alert("${error}");
    </script>
</c:if>	

<form action="${pageContext.request.contextPath}/login" method="post">
    <label for="id">아이디:</label><br>
    <input type="text" id="id" name="id" required /><br><br>

    <label for="passwd">비밀번호:</label><br>
    <input type="password" id="passwd" name="passwd" required /><br><br>

    <button type="submit">로그인</button>
</form>
<a href="${pageContext.request.contextPath}/find-id">아이디 찾기</a>
<a href="${pageContext.request.contextPath}/find-password">비밀번호 찾기</a>
<p>계정이 없으신가요? <a href="${pageContext.request.contextPath}/join">회원가입</a></p>

</body>
</html>
