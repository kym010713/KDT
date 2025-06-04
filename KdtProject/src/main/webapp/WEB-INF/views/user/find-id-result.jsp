<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>아이디 찾기 결과</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background-color: #f0f2f5;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 40px 20px;
            margin: 0;
        }

        .result-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            margin: 20px auto;
            text-align: center;
        }

        h2 {
            color: #1a237e;
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
        }

        .result-message {
            margin: 20px 0;
            padding: 20px;
            background-color: #e8f5e9;
            border-radius: 5px;
            color: #2e7d32;
        }

        .result-message strong {
            display: block;
            font-size: 20px;
            margin-top: 10px;
            color: #1a237e;
        }

        .error-message {
            color: #d32f2f;
            background-color: #fde7e7;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .login-link {
            display: inline-block;
            padding: 12px 24px;
            background-color: #1a237e;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-top: 20px;
        }

        .login-link:hover {
            background-color: #283593;
        }
    </style>
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