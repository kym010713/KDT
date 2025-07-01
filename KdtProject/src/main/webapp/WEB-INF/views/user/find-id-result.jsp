<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>아이디 찾기 결과</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/find-id-result.css" />
</head>
<body>
    <div class="result-container">
        <h2>아이디 찾기 결과</h2>
        
        <c:if test="${not empty findid}">
            <div class="result-message">
                찾으신 아이디는
                <strong>${findid}</strong>
                입니다
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/login" class="login-link">로그인하기</a>
    </div>
</body>
</html>