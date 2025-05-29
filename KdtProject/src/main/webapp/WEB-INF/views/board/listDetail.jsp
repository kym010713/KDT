<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h2>공지사항 상세 보기</h2>

<c:if test="${not empty dto}">
	<table border="1" width="700" style="table-layout: fixed;">
		<tr>
			<th>제목</th>
			<td>${dto.boardTitle}</td>
		</tr>
		<tr>
			<th>글 번호</th>
			<td>${dto.boardId}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${dto.boardWriter}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${dto.boardContent}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${dto.boardCount}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${dto.formattedDate}</td>
		</tr>

	</table>
</c:if>

<br>
<button onclick="location.href='/board/list?page=${page}'">글 목록</button>
<c:if test="${sessionScope.loginUser.role eq 'ADMIN'}">
	<button
		onclick="location.href='/board/update?id=${dto.boardId}&page=${page}'">글수정</button>
	<button
		onclick="location.href='/board/delete?id=${dto.boardId}&page=${page}'">글삭제</button>
</c:if>

