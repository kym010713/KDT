<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${not empty findid}">
    <p>당신의 아이디는: <strong>${findid}</strong></p>
</c:if>
<c:if test="${not empty error}">
    <div style="color:red;">${error}</div>
</c:if>

</body>
</html>