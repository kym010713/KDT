<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>비밀번호 재설정</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/reset-password.css" />
</head>
<body>
    <div class="form-container">
        <h2>비밀번호 재설정</h2>

        <form method="post" action="/reset-password">
            <input type="hidden" name="id" value="${id}" />
            <input type="hidden" name="email" value="${email}" />
            
            <div class="form-group">
                <label for="newPassword">새 비밀번호</label>
                <input type="password" id="newPassword" name="newPassword" required />
            </div>

            <button type="submit">비밀번호 변경</button>
        </form>
    </div>
</body>
</html>