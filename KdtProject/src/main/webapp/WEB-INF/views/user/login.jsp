<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>로그인</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
            align-items: center;
            min-height: 100vh;
        }

        .login-box {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        h2 {
            color: #1a237e;
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #1a237e;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #e8eaf6;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #3949ab;
            outline: none;
        }

        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #1a237e;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button[type="submit"]:hover {
            background-color: #283593;
        }

        .links {
            text-align: center;
            margin-top: 20px;
        }

        .links a {
            color: #3949ab;
            text-decoration: none;
            margin: 0 10px;
            font-size: 14px;
            transition: color 0.3s;
        }

        .links a:hover {
            color: #1a237e;
        }

        .signup-text {
            text-align: center;
            margin-top: 20px;
            color: #666;
            font-size: 14px;
        }

        .error-message {
            color: #d32f2f;
            background-color: #fde7e7;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>로그인</h2>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <c:if test="${not empty message}">
            <script>
                alert("${message}");
            </script>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" required>
            </div>

            <div class="form-group">
                <label for="passwd">비밀번호</label>
                <input type="password" id="passwd" name="passwd" required>
            </div>

            <button type="submit">로그인</button>
        </form>

        <div class="links">
            <a href="${pageContext.request.contextPath}/find-id">아이디 찾기</a>
            <a href="${pageContext.request.contextPath}/find-password">비밀번호 찾기</a>
        </div>

        <p class="signup-text">
            계정이 없으신가요? <a href="${pageContext.request.contextPath}/join">회원가입</a>
        </p>
    </div>
</body>
</html>