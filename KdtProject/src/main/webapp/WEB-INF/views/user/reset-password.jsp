<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
</head>
<body>
<form method="post" action="/reset-password">
    <input type="hidden" name="id" value="${id}" />
    <label>새 비밀번호</label>
    <input type="password" name="newPassword" required />
    <button type="submit">비밀번호 변경</button>
</form>

</body>
</html>