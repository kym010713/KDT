<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>챗봇 문의</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/chatbot/chatbotAsk.css" />
</head>
<body>
    <div class="chat-container">
        <div class="chat-header">
            <h2>챗봇에게 질문하세요!</h2>
            <form action="${pageContext.request.contextPath}/chatbot/clear" method="get" style="margin: 0;">
                <button type="submit" class="clear-chat">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M3 6h18"></path>
                        <path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"></path>
                        <path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"></path>
                    </svg>
                    대화 내용 지우기
                </button>
            </form>
        </div>
        
        <div class="chat-window">
            <c:forEach var="chat" items="${chatHistory}">
                <div class="message user-message">${chat.keyword}</div>
                <div class="message bot-message">${chat.answer}</div>
            </c:forEach>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/chatbot/ask">
            <input type="text" name="question" id="questionInput" placeholder="문의 내용을 입력하세요" required autocomplete="off" />
            <button type="submit">전송</button>
        </form>

        <div class="example-questions">
            <h3>💡 이런 질문을 해보세요</h3>
            <div class="question-list">
                <span class="question-item">회원가입은 어떻게 하나요?</span>
                <span class="question-item">아이디를 잊어버렸어요</span>
                <span class="question-item">비밀번호 변경하고 싶어요</span>
                <span class="question-item">로그인이 안돼요</span>
                <span class="question-item">회원탈퇴는 어떻게 하나요?</span>
            </div>
        </div>
    </div>

    <script>
        window.onload = function() {
            const chatWindow = document.querySelector('.chat-window');
            chatWindow.scrollTop = chatWindow.scrollHeight;

            // 예시 질문 클릭 이벤트
            document.querySelectorAll('.question-item').forEach(item => {
                item.addEventListener('click', function() {
                    document.getElementById('questionInput').value = this.textContent;
                });
            });
        };
    </script>
</body>
</html>
