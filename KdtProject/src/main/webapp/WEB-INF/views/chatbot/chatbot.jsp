<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
    <title>챗봇 문의</title>
</head>
<body>
    <h2>챗봇에게 질문하세요!</h2>

    <form method="post" action="${pageContext.request.contextPath}/chatbot/ask">
        <input type="text" name="question" placeholder="문의 내용을 입력하세요" value="${question}" required />
        <button type="submit">질문하기</button>
    </form>

    <c:if test="${not empty answer}">
        <h3>답변:</h3>
        <p>${answer}</p>
    </c:if>
</body>
</html>
