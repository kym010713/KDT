<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>회원가입</title>
</head>
<body>

<h2>회원가입</h2>

<form action="${pageContext.request.contextPath}/join" method="post">
    <label for="id">아이디:</label><br>
    <input type="text" id="id" name="id" value="${userDto.id}" /><br>
    <c:if test="${not empty errors['id']}">
        <span style="color:red;">${errors['id']}</span><br>
    </c:if><br>

    <label for="passwd">비밀번호:</label><br>
    <input type="password" id="passwd" name="passwd" /><br>
    <c:if test="${not empty errors['passwd']}">
        <span style="color:red;">${errors['passwd']}</span><br>
    </c:if><br>

    <label for="name">이름:</label><br>
    <input type="text" id="name" name="name" value="${userDto.name}" /><br>
    <c:if test="${not empty errors['name']}">
        <span style="color:red;">${errors['name']}</span><br>
    </c:if><br>

    <label for="email">이메일:</label><br>
    <input type="email" id="email" name="email" value="${userDto.email}" /><br>
    <c:if test="${not empty errors['email']}">
        <span style="color:red;">${errors['email']}</span><br>
    </c:if><br>

    <label for="phoneNumber">전화번호:</label><br>
    <input type="text" id="phoneNumber" name="phoneNumber" value="${userDto.phoneNumber}" /><br>
    <c:if test="${not empty errors['phoneNumber']}">
        <span style="color:red;">${errors['phoneNumber']}</span><br>
    </c:if><br>

    <label for="address">주소:</label><br>
    <input type="text" id="address" name="address" value="${userDto.address}" /><br>
    <c:if test="${not empty errors['address']}">
        <span style="color:red;">${errors['address']}</span><br>
    </c:if><br>

    <button type="submit">회원가입</button>
</form>

<p>이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/login">로그인</a></p>

</body>
</html>
