<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원 관리</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Pretendard Font -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <!-- Custom CSS (adminMain.css) -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/adminMain.css" />
    <!-- Custom CSS (userList.css) -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/userList.css" />
</head>
<body class="bg-light">

<c:if test="${not empty sessionScope.alertMsg}">
    <script>
        alert("${sessionScope.alertMsg}");
    </script>
    <c:remove var="alertMsg" scope="session" />
</c:if>

<div class="container py-5">
    <div class="row mb-4 align-items-center position-relative">
        <div class="col-auto" style="position: absolute; left: 0; top: 50%; transform: translateY(-50%); z-index: 1;">
            <a href="${pageContext.request.contextPath}/admin/main" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>메인으로
            </a>
        </div>
        <div class="col text-center">
            <h1 class="display-5 text-main fw-semibold mb-0">
                <i class="fas fa-users me-3"></i>회원 관리
            </h1>
        </div>
    </div>

    <!-- 검색 폼 -->
    <div class="row mb-4">
        <div class="col-md-6 offset-md-3">
            <form action="${pageContext.request.contextPath}/admin/userList" method="get" class="d-flex">
                <input type="text" name="keyword" class="form-control me-2" placeholder="이름 검색" value="${param.keyword}" />
                <button type="submit" class="btn btn-main"><i class="fas fa-search"></i> 검색</button>
            </form>
        </div>
    </div>

    <!-- 회원 목록 테이블 -->
    <div class="card shadow-sm">
        <div class="card-body">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">회원 이름</th>
                        <th scope="col">아이디</th>
                        <th scope="col">이메일</th>
                        <th scope="col">역할</th>
                        <th scope="col">주소</th>
                        <th scope="col">가입 날짜</th>
                        <th scope="col" class="text-center">등급 변경</th>
                        <th scope="col" class="text-center">탈퇴 처리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userList}" varStatus="status">
                        <tr>
                            <th scope="row">${status.count}</th>
                            <td>${user.name}</td>
                            <td>${user.id}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td>${user.address}</td>
                            <td>${user.createdAt.toLocalDate()}</td>
                            <td class="text-center">
                                <form action="${pageContext.request.contextPath}/admin/updateGrade" method="post" class="d-inline-flex align-items-center">
                                    <input type="hidden" name="id" value="${user.id}" /> 
                                    <select name="grade" class="form-select form-select-sm me-2" style="width: auto;">
                                        <option value="BRONZE" ${user.grade == 'BRONZE' ? 'selected' : ''}>BRONZE</option>
                                        <option value="SILVER" ${user.grade == 'SILVER' ? 'selected' : ''}>SILVER</option>
                                        <option value="GOLD" ${user.grade == 'GOLD' ? 'selected' : ''}>GOLD</option>
                                        <option value="PLATINUM" ${user.grade == 'PLATINUM' ? 'selected' : ''}>PLATINUM</option>
                                    </select> 
                                    <button type="submit" class="btn btn-sm btn-outline-success">변경</button>
                                </form>
                            </td>
                            <td class="text-center">
                                <form action="${pageContext.request.contextPath}/admin/deleteUser" method="post" class="d-inline">
                                    <input type="hidden" name="id" value="${user.id}" /> 
                                    <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('정말 ${user.name} 회원을 탈퇴 처리하시겠습니까?');">
                                        <i class="fas fa-user-slash"></i> 탈퇴
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userList}">
                        <tr>
                            <td colspan="9" class="text-center py-4">해당하는 회원이 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
