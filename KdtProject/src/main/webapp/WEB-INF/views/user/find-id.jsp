<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>아이디 찾기</title>
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

        .form-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            margin: 20px auto;
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

        input[type="email"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #e8eaf6;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        input[type="email"]:focus {
            border-color: #3949ab;
            outline: none;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #1a237e;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        button:hover {
            background-color: #283593;
        }

        .error-message {
            color: #d32f2f;
            background-color: #fde7e7;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        .links {
            text-align: center;
            margin-top: 20px;
        }

        .links a {
            color: #3949ab;
            text-decoration: none;
            transition: color 0.3s;
            margin: 0 10px;
        }

        .links a:hover {
            color: #1a237e;
        }

        .description {
            text-align: center;
            color: #666;
            margin-bottom: 20px;
            font-size: 14px;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>아이디 찾기</h2>
        
        <p class="description">
            가입 시 등록한 이메일을 입력하시면<br>
            아이디를 찾아드립니다.
        </p>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/find-id" method="post">
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required placeholder="example@email.com" />
            </div>
            <button type="submit">아이디 찾기</button>
        </form>

        <div class="links">
            <a href="${pageContext.request.contextPath}/find-password">비밀번호 찾기</a>
            <a href="${pageContext.request.contextPath}/login">로그인</a>
        </div>
    </div>
</body>
</html>