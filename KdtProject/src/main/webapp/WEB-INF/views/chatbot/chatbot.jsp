<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>챗봇 문의</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/chatbotAsk.css" />
</head>
<body>

    <div class="chat-container">
    	
	   
        <h2>챗봇에게 질문하세요!</h2>
        	
		 <form action="${pageContext.request.contextPath}/chatbot/clear" method="get" style="margin-bottom: 10px;">
		    <button type="submit" style="background-color:#f44336; color:white; border:none; padding:10px 20px; border-radius:5px; cursor:pointer;">
		        대화 초기화 (동기화)
		    </button>
	    </form>	
	    
        <div class="chat-window">
		    <c:forEach var="chat" items="${chatHistory}">
		        <div class="message user-message">${chat.keyword}</div>
		        <div class="message bot-message">${chat.answer}</div>
		    </c:forEach>
		</div>
		
		<script>
		    window.onload = function() {
		        const chatWindow = document.querySelector('.chat-window');
		        chatWindow.scrollTop = chatWindow.scrollHeight;
		    };
		</script>

        <form method="post" action="${pageContext.request.contextPath}/chatbot/ask">
            <input type="text" name="question" placeholder="문의 내용을 입력하세요" required autocomplete="off" />
            <button type="submit">전송</button>
        </form>
    </div>
</body>
</html>
