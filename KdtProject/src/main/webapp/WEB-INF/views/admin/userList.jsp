<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h2>회원 목록 (관리자 제외)</h2>

<form action="/admin/userList" method="get">
    <input type="text" name="keyword" placeholder="이름 검색" value="${param.keyword}" />
    <button type="submit">검색</button>
</form>

<table style="width: 100%; border-collapse: collapse;" border="1">
	<tr>
		<th>회원 이름</th>
		<th>아이디</th>
		<th>이메일</th>
		<th>역할</th>
		<th>주소</th>
		<th>가입 날짜</th>
		<th>탈퇴 처리</th>
	</tr>
	<c:forEach var="user" items="${userList}">
		<tr>
			<td style="text-align: center;">${user.name}</td>
			<td style="text-align: center;">${user.id}</td>
			<td style="text-align: center;">${user.email}</td>
			<td style="text-align: center;">${user.role}</td>
			<td style="text-align: center;">${user.address}</td>
			<td style="text-align: center;">${user.formattedCreatedAt}</td>
			<td style="text-align: center;">
				<form action="/admin/deleteUser" method="post"
					style="display: inline;">
					<input type="hidden" name="id" value="${user.id}" /> <input
						type="submit" value="탈퇴"
						onclick="return confirm('정말 탈퇴 처리하시겠습니까?');" />
				</form>
			</td>

		</tr>
	</c:forEach>
</table>
