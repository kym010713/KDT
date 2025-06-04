<!-- alert/seller-approval-required.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>판매자 승인 대기</title>
</head>
<body>
    <script>
        alert('판매자 승인이 완료되지 않았습니다. 관리자 승인을 기다려주세요.');
        location.href = '/seller/apply';
    </script>
</body>
</html>