<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h2>공지사항</h2>

<button onclick="location.href='/board/writeForm'">글작성</button>
<br />
<br />

<table border="1" width="800">
	<tr>
		<th>글번호</th>
		<th>작성자</th>
		<th>제목</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>

	<c:forEach var="dto" items="${boardList.content}">
		<tr>
			<td>${dto.boardId}</td>
			<td>${dto.boardWriter}</td>
			<td><a href="listDetail?id=${dto.boardId}&page=${currentPage}">${dto.boardTitle}</a></td>
			<td>${dto.formattedDate}</td>
			<td>${dto.boardCount}</td>
		</tr>
	</c:forEach>
</table>

<c:if test="${startPage > 0}">
	<a href="?page=${startPage - 10}"
		style="text-decoration: none; color: black;">[이전]</a>
</c:if>

<c:forEach var="i" begin="${startPage}" end="${endPage}">
	<a href="?page=${i}" style="text-decoration: none; color: black;">[${i+1}]</a>
</c:forEach>

<c:if test="${endPage + 1 < totalPage}">
	<a href="?page=${startPage + 10}"
		style="text-decoration: none; color: black;">[다음]</a>
</c:if>























