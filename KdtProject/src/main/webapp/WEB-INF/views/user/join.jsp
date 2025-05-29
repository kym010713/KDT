<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>회원가입</title>
</head>
<body>

<h2>회원가입</h2>

<c:if test="${not empty error}">
    <div style="color:red;">${error}</div>
</c:if>

<form action="${pageContext.request.contextPath}/join" method="post">
    <label for="id">아이디:</label><br>
    <input type="text" id="id" name="id" required /><br><br>

    <label for="passwd">비밀번호:</label><br>
    <input type="password" id="passwd" name="passwd" required /><br><br>

    <label for="name">이름:</label><br>
    <input type="text" id="name" name="name" required /><br><br>

    <label for="phoneNumber">전화번호:</label><br>
    <input type="text" id="phoneNumber" name="phoneNumber" required /><br><br>

    <label for="address">주소:</label><br>
    <input type="text" id="address" name="address" required /><br><br>

    <button type="submit">회원가입</button>
</form>

<p>이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/login">로그인</a></p>

</body>
</html>
