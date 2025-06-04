<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>챗봇 문의</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Pretendard Font -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <style>
        * {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
        }
        :root {
            --main-color: #1f2937;
            --chat-user-color: #e5e7eb;
            --chat-bot-color: var(--main-color);
        }
        body {
            background-color: #f8f9fa;
        }
        .chat-container {
            max-width: 800px;
            margin: 2rem auto;
        }
        .chat-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }
        .chat-window {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 1.5rem;
            height: 500px;
            overflow-y: auto;
            margin-bottom: 1.5rem;
            border: 1px solid #e5e7eb;
        }
        .message {
            margin-bottom: 1rem;
            padding: 1rem;
            border-radius: 10px;
            max-width: 80%;
            word-wrap: break-word;
        }
        .user-message {
            background-color: var(--chat-user-color);
            margin-left: auto;
            color: #1f2937;
        }
        .bot-message {
            background-color: var(--chat-bot-color);
            color: white;
            margin-right: auto;
        }
        .chat-input-form {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }
        .chat-input {
            flex-grow: 1;
            padding: 0.8rem 1.2rem;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.2s;
        }
        .chat-input:focus {
            outline: none;
            border-color: var(--main-color);
            box-shadow: 0 0 0 2px rgba(31, 41, 55, 0.1);
        }
        .btn-main {
            background-color: var(--main-color);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        .btn-main:hover {
            background-color: #374151;
            transform: translateY(-1px);
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .btn-danger:hover {
            background-color: #bb2d3b;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="chat-container">
            <div class="chat-card">
                <div class="text-center mb-4">
                    <h1 class="display-5 text-main fw-semibold mb-4">
                        <i class="fas fa-robot me-3"></i>챗봇 문의
                    </h1>
                    <form action="${pageContext.request.contextPath}/chatbot/clear" method="get" class="mb-4">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-sync-alt me-2"></i>대화 초기화
                        </button>
                    </form>
                </div>

                <div class="chat-window">
                    <c:forEach var="chat" items="${chatHistory}">
                        <div class="message user-message">${chat.keyword}</div>
                        <div class="message bot-message">${chat.answer}</div>
                    </c:forEach>
                </div>

                <form method="post" action="${pageContext.request.contextPath}/chatbot/ask" class="chat-input-form">
                    <input type="text" name="question" class="chat-input" placeholder="문의 내용을 입력하세요" required autocomplete="off" />
                    <button type="submit" class="btn btn-main">
                        <i class="fas fa-paper-plane"></i>
                        전송
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        window.onload = function() {
            const chatWindow = document.querySelector('.chat-window');
            chatWindow.scrollTop = chatWindow.scrollHeight;
        };
    </script>
</body>
</html>
