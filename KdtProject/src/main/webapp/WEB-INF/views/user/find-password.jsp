<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
<form method="post" action="/find-password/send-code">
    <label>아이디</label>
    <input type="text" name="id" required />

    <label>이메일</label>
    <input type="email" name="email" required />

    <button type="submit">인증번호 요청</button>
</form>

<form method="post" action="/find-password/verify-code">
    <label>인증번호</label>
    <input type="text" name="code" required />
    <input type="hidden" name="email" value="${email}" />
    <button type="submit">인증번호 확인</button>
</form>

</body>
</html>