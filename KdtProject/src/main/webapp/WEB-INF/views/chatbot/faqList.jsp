<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FAQ 관리</title>
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/chatbot/chatbotList.css" />
</head>
<body>
    <div class="container">
        <h2>FAQ 목록</h2>

        <table>
            <tr>
                <th>키워드</th>
                <th>답변</th>
                <th>관리</th>
            </tr>

            <c:forEach var="faq" items="${faqList}">
                <tr>
                    <form action="${pageContext.request.contextPath}/admin/faq/edit/${faq.id}" method="post">
                        <td hidden>${faq.id}</td>
                        <td><input type="text" name="keyword" value="${faq.keyword}" required/></td>
                        <td><input type="text" name="answer" value="${faq.answer}" required/></td>
                        <td>
                            <div class="action-buttons">
                                <button type="submit">수정</button>
                                <button type="button" class="delete-button" onclick="if(confirm('삭제할까요?')) document.getElementById('delete-form-${faq.id}').submit();">삭제</button>
                            </div>
                            <form id="delete-form-${faq.id}" action="${pageContext.request.contextPath}/admin/faq/delete/${faq.id}" method="post" style="display: none;"></form>
                        </td>
                    </form>
                </tr>
            </c:forEach>
        </table>

        <hr/>

        <h2>FAQ 추가</h2>
        <form action="${pageContext.request.contextPath}/admin/faq/add" method="post" class="add-form">
            <div class="form-group">
                <label for="keyword">키워드</label>
                <input type="text" id="keyword" name="keyword" required />
            </div>
            
            <div class="form-group">
                <label for="answer">답변</label>
                <input type="text" id="answer" name="answer" required />
            </div>
            
            <button type="submit">등록</button>
        </form>
    </div>
</body>
</html>