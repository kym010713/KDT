<!-- alert/seller-auth-required.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>판매자 인증 필요</title>
</head>
<body>
    <script>
        alert('판매자 권한이 필요합니다. 판매자 인증을 진행해주세요.');
        location.href = '/seller/apply';
    </script>
</body>
</html>