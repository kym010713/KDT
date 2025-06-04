<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>FAQ 목록</title></head>
<body>
<<h2>FAQ 목록</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>키워드</th>
        <th>답변</th>
        <th>수정</th>
        <th>삭제</th>
    </tr>

    <c:forEach var="faq" items="${faqList}">
        <tr>
            <form action="${pageContext.request.contextPath}/admin/faq/edit/${faq.id}" method="post">
                <td>${faq.id}</td>
                <td><input type="text" name="keyword" value="${faq.keyword}" /></td>
                <td><input type="text" name="answer" value="${faq.answer}" /></td>
                <td><button type="submit">수정</button></td>
            </form>
            <td>
                <form action="${pageContext.request.contextPath}/admin/faq/delete/${faq.id}" method="post">
                    <button type="submit" onclick="return confirm('삭제할까요?');">삭제</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<hr/>

<h2>FAQ 추가</h2>
<form action="${pageContext.request.contextPath}/admin/faq/add" method="post">
    키워드: <input type="text" name="keyword" required />
    답변: <input type="text" name="answer" required />
    <button type="submit">등록</button>
</form>

</body>
</html>
