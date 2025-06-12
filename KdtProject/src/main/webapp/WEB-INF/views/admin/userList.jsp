<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 관리</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
	integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script>
	tailwind.config = {
		theme : {
			extend : {
				fontFamily : {
					pretendard : [ 'Pretendard', 'sans-serif' ],
				},
				colors : {
					'main-color' : {
						DEFAULT : '#1f2937',
						'hover' : '#111827'
					}
				}
			},
		},
	}
</script>
</head>
<body class="bg-gray-50 font-pretendard">

	<c:if test="${not empty sessionScope.alertMsg}">
		<script>
			alert("${sessionScope.alertMsg}");
		</script>
		<c:remove var="alertMsg" scope="session" />
	</c:if>

	<%@ include file="/WEB-INF/views/buyer/nav.jsp"%>

	<div class="container mx-auto max-w-full px-4 sm:px-6 lg:px-8 py-12">
		<div class="flex justify-between items-center mb-8 border-b pb-4">
			<h1 class="text-3xl font-bold text-gray-800">
				<i class="fas fa-users mr-3"></i>회원 관리
			</h1>
			<a href="${pageContext.request.contextPath}/admin/main"
				class="px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-main-color">
				<i class="fas fa-arrow-left mr-2"></i>대시보드로 돌아가기
			</a>
		</div>

		<!-- 검색 폼 -->
		<div class="mb-8">
			<form action="${pageContext.request.contextPath}/admin/userList"
				method="get" class="flex max-w-md">
				<input type="text" name="keyword"
					class="flex-grow px-3 py-2 bg-white border border-gray-300 rounded-l-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm"
					placeholder="회원 이름으로 검색" value="${param.keyword}" />
				<button type="submit"
					class="inline-flex items-center px-4 py-2 border border-transparent rounded-r-md shadow-sm text-sm font-medium text-white bg-main-color hover:bg-main-color-hover focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-main-color">
					<i class="fas fa-search"></i>
				</button>
			</form>
		</div>

		<!-- 회원 목록 테이블 -->
		<div class="bg-white shadow-md rounded-lg overflow-x-auto">
			<table class="min-w-full divide-y divide-gray-200">
				<thead class="bg-gray-50">
					<tr>
						<th scope="col"
							class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">#</th>
						<th scope="col"
							class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">이름</th>
						<th scope="col"
							class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">아이디</th>
						<th scope="col" colspan="3"
							class="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">사용자 정보 수정</th>
						<th scope="col"
							class="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">역할</th>
						<th scope="col"
							class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">가입일</th>
						<th scope="col"
							class="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">등급
							변경</th>
						<th scope="col"
							class="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">탈퇴
							처리</th>
					</tr>
				</thead>
				<tbody class="bg-white divide-y divide-gray-200">
					<c:forEach var="user" items="${userList}" varStatus="status">
						<tr>
							<td
								class="px-4 py-2 whitespace-nowrap text-sm font-medium text-gray-900">${status.count}</td>
							<td class="px-4 py-2 whitespace-nowrap text-sm text-gray-800">${user.name}</td>
							<td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500">${user.id}</td>
							
							<td class="px-4 py-2" colspan="3">
								<form
									action="${pageContext.request.contextPath}/admin/updateUser"
									method="post" class="flex items-center gap-2">
									<input type="hidden" name="id" value="${user.id}" />
									<input type="email" name="email" value="${user.email}"
										class="flex-1 w-full px-2 py-1 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-main-color focus:border-main-color"
										placeholder="이메일" />
									<input type="password" name="passwd"
										class="flex-1 w-full px-2 py-1 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-main-color focus:border-main-color"
										placeholder="새 비밀번호" />
									<button type="submit"
										class="px-3 py-1 bg-main-color text-white text-sm rounded-md hover:bg-main-color-hover whitespace-nowrap">저장</button>
								</form>
							</td>

							<td class="px-4 py-2 whitespace-nowrap text-center text-sm text-gray-500">
								<span
									class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full 
									${user.role == 'ADMIN' ? 'bg-red-100 text-red-800' : 
									 user.role == 'SELLER' ? 'bg-blue-100 text-blue-800' : 'bg-green-100 text-green-800'}">
									${user.role} </span>
							</td>
							<td class="px-4 py-2 whitespace-nowrap text-sm text-gray-500">${user.createdAt.toLocalDate()}</td>
							<td class="px-4 py-2 whitespace-nowrap text-center">
								<form
									action="${pageContext.request.contextPath}/admin/updateGrade"
									method="post" class="inline-flex items-center">
									<input type="hidden" name="id" value="${user.id}" /> <select
										name="grade"
										class="block w-full pl-3 pr-8 py-1 text-sm border-gray-300 focus:outline-none focus:ring-main-color focus:border-main-color rounded-md">
										<option value="BRONZE"
											${user.grade == 'BRONZE' ? 'selected' : ''}>BRONZE</option>
										<option value="SILVER"
											${user.grade == 'SILVER' ? 'selected' : ''}>SILVER</option>
										<option value="GOLD"
											${user.grade == 'GOLD' ? 'selected' : ''}>GOLD</option>
										<option value="PLATINUM"
											${user.grade == 'PLATINUM' ? 'selected' : ''}>PLATINUM</option>
									</select>
									<button type="submit"
										class="ml-2 px-3 py-1 border border-transparent text-sm font-medium rounded-md text-white bg-main-color hover:bg-main-color-hover focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-main-color">변경</button>
								</form>
							</td>
							<td class="px-4 py-2 whitespace-nowrap text-sm text-center">
								<form
									action="${pageContext.request.contextPath}/admin/deleteUser"
									method="post" class="inline-block">
									<input type="hidden" name="id" value="${user.id}" />
									<button type="submit" class="text-red-600 hover:text-red-900"
										onclick="return confirm('정말 ${user.name} 회원을 탈퇴 처리하시겠습니까?');">
										<i class="fas fa-user-slash mr-1"></i>탈퇴
									</button>
								</form>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty userList}">
						<tr>
							<td colspan="10" class="text-center py-10"><i
								class="fas fa-exclamation-circle text-4xl text-gray-400 mb-3"></i>
								<p class="text-gray-600">해당하는 회원이 없습니다.</p></td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>
