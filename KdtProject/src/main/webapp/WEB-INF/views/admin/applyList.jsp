<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>입점 신청 관리</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Pretendard Font -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <!-- Common Admin CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/adminMain.css" />
    <!-- Page-specific CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin/applyList.css" />
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row mb-4 align-items-center position-relative">
        <div class="col-auto" style="position: absolute; left: 0; top: 50%; transform: translateY(-50%); z-index: 1;">
            <a href="${pageContext.request.contextPath}/admin/main" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>메인으로
            </a>
        </div>
        <div class="col text-center">
            <h1 class="display-5 text-main fw-semibold mb-0">
                <i class="fas fa-store-alt me-3"></i>입점 신청 관리
            </h1>
        </div>
    </div>

    <c:if test="${empty applyList}">
        <div class="card shadow-sm">
            <div class="card-body text-center py-5">
                <i class="fas fa-info-circle fa-3x text-muted mb-3"></i>
                <p class="lead">현재 등록된 입점 신청이 없습니다.</p>
            </div>
        </div>
    </c:if>

    <c:if test="${not empty applyList}">
        <div class="card shadow-sm">
            <div class="card-body">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">아이디</th>
                            <th scope="col">회사명(브랜드명)</th>
                            <th scope="col">대표자 이름</th>
                            <th scope="col">사업자 번호</th>
                            <th scope="col">사업장 주소</th>
                            <th scope="col">대표 전화번호</th>
                            <th scope="col" class="text-center">승인 상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="seller" items="${applyList}" varStatus="status">
                            <tr>
                                <th scope="row">${status.count}</th>
                                <td>${seller.sellerId}</td>
                                <td>${seller.brandName}</td>
                                <td>${seller.sellerName}</td>
                                <td>${seller.businessNumber}</td>
                                <td>${seller.sellerAddress}</td>
                                <td>${seller.sellerPhone}</td>
                                <td class="text-center status-cell" onclick="approveSeller('${seller.sellerRoleId}', '${seller.status}')">
                                    <c:choose>
                                        <c:when test="${seller.status == 'Y'}">
                                            <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i>승인됨</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning text-dark"><i class="fas fa-hourglass-half me-1"></i>미승인</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
</div>

<script>
function approveSeller(sellerRoleId, status) {
    if (status === 'Y') {
        alert('이미 승인된 신청입니다.');
        return;
    }

    if (confirm('해당 신청을 승인하시겠습니까?')) {
        fetch('${pageContext.request.contextPath}/admin/approveSeller?sellerRoleId=' + sellerRoleId, {
            method: 'POST'
        }).then(response => {
            if (response.ok) {
                alert('승인 처리되었습니다.');
                location.reload();
            } else {
                response.text().then(text => {
                    alert('승인 처리 중 오류가 발생했습니다: ' + text);
                });
            }
        }).catch(error => {
            console.error('Error:', error);
            alert('승인 처리 중 네트워크 또는 스크립트 오류가 발생했습니다.');
        });
    }
}
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

