<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <meta charset="UTF-8">
    <title>챗봇 문의</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 min-h-screen">

    <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

    <div class="max-w-3xl mx-auto mt-10 bg-white rounded-2xl shadow-lg p-6">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-bold text-gray-800">💬 챗봇에게 질문하세요</h2>
            <form action="${pageContext.request.contextPath}/chatbot/clear" method="get">
                <button type="submit" class="flex items-center gap-1 text-sm text-red-500 hover:underline">
                    🗑️ 대화 내용 지우기
                </button>
            </form>
        </div>

        <div class="chat-window h-96 overflow-y-auto space-y-2 border p-4 rounded-md bg-gray-100 text-sm">
            <c:forEach var="chat" items="${chatHistory}">
                <div class="bg-blue-100 p-2 rounded-md self-end text-right">
                    <span class="text-gray-800 font-medium">👤 나: </span>${chat.keyword}
                </div>
                <div class="bg-gray-200 p-2 rounded-md self-start">
                    <span class="text-green-600 font-medium">🤖 챗봇: </span>${chat.answer}
                </div>
            </c:forEach>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/chatbot/ask" class="mt-4 flex gap-2">
            <input type="text" name="question" id="questionInput" placeholder="문의 내용을 입력하세요" required
                   class="flex-1 border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
                   autocomplete="off" />
            <button type="submit"
                    class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 transition">전송</button>
        </form>

        <div class="mt-6">
            <h3 class="text-gray-700 font-semibold mb-2">💡 이런 질문을 해보세요</h3>
            <div class="flex flex-wrap gap-2">
                <span class="question-item cursor-pointer px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded-full text-sm">회원가입은 어떻게 하나요?</span>
                <span class="question-item cursor-pointer px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded-full text-sm">아이디를 잊어버렸어요</span>
                <span class="question-item cursor-pointer px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded-full text-sm">비밀번호 변경하고 싶어요</span>
                <span class="question-item cursor-pointer px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded-full text-sm">로그인이 안돼요</span>
                <span class="question-item cursor-pointer px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded-full text-sm">회원탈퇴는 어떻게 하나요?</span>
            </div>
        </div>
    </div>

    <script>
        window.onload = function () {
            const chatWindow = document.querySelector('.chat-window');
            chatWindow.scrollTop = chatWindow.scrollHeight;

            document.querySelectorAll('.question-item').forEach(item => {
                item.addEventListener('click', function () {
                    document.getElementById('questionInput').value = this.textContent;
                    document.getElementById('questionInput').focus();
                });
            });
        };
    </script>
</body>
</html>
