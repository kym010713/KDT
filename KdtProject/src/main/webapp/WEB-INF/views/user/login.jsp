<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>로그인</title>
</head>
<body>

<h2>로그인</h2>

<c:if test="${not empty error}">
    <div style="color:red;">${error}</div>
</c:if>

<form action="${pageContext.request.contextPath}/login" method="post">
    <label for="id">아이디:</label><br>
    <input type="text" id="id" name="id" required /><br><br>

    <label for="passwd">비밀번호:</label><br>
    <input type="password" id="passwd" name="passwd" required /><br><br>

    <button type="submit">로그인</button>
</form>
<p><a href="${pageContext.request.contextPath}/find-id">아이디 찾기</a></p>
<p>계정이 없으신가요? <a href="${pageContext.request.contextPath}/join">회원가입</a></p>

</body>
</html>
