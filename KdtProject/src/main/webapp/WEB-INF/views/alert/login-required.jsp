<!-- alert/login-required.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인 필요</title>
</head>
<body>
    <script>
        alert('로그인이 필요한 서비스입니다.');
        location.href = '/login';
    </script>
</body>
</html>