<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>홈</title>
</head>
<body>

<h2>환영합니다, ${userName} 님!</h2>

<form action="${pageContext.request.contextPath}/logout" method="get">
    <button type="submit">로그아웃</button>
</form>

</body>
</html>
