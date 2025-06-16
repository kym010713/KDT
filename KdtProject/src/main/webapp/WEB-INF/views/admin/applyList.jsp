<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>입점 신청 관리</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="${pageContext.request.contextPath}/resources/js/tailwind-config.js"></script>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body class="bg-gray-50 font-pretendard">

<%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

<div class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12">
    <div class="flex justify-between items-center mb-8 border-b pb-4">
        <h1 class="text-3xl font-bold text-gray-800">
            <i class="fas fa-store mr-3"></i>입점 신청 관리
        </h1>
        <a href="${pageContext.request.contextPath}/admin/main" class="px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-main-color">
            <i class="fas fa-arrow-left mr-2"></i>대시보드로 돌아가기
        </a>
    </div>

    <c:if test="${empty applyList}">
        <div class="text-center py-20 bg-white rounded-lg shadow-md">
            <i class="fas fa-inbox text-5xl text-gray-400 mb-4"></i>
            <p class="text-gray-600 text-lg">현재 등록된 입점 신청이 없습니다.</p>
        </div>
    </c:if>

    <c:if test="${not empty applyList}">
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">#</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">아이디</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">회사명(브랜드명)</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">대표자 이름</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">사업자 번호</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">대표 전화번호</th>
                            <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">승인 처리</th>
                            <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">삭제</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="seller" items="${applyList}" varStatus="status">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${status.count}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${seller.sellerId}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800">${seller.brandName}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-800">${seller.sellerName}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${seller.businessNumber}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${seller.sellerPhone}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-center text-sm">
                                    <c:choose>
                                        <c:when test="${seller.status == 'Y'}">
                                            <!-- Approved State: Toggle ON -->
                                            <div class="flex items-center justify-center gap-3 cursor-pointer" onclick="rejectSeller('${seller.sellerRoleId}')">
                                                <div class="relative">
                                                    <div class="w-11 h-6 bg-main-color rounded-full"></div>
                                                    <div class="absolute left-1 top-1 w-4 h-4 bg-white rounded-full transition-transform transform translate-x-5"></div>
                                                </div>
                                                <span class="font-semibold text-main-color">승인됨</span>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Not Approved State: Toggle OFF -->
                                            <div class="flex items-center justify-center gap-3 cursor-pointer" onclick="approveSeller('${seller.sellerRoleId}')">
                                                <div class="relative">
                                                    <div class="w-11 h-6 bg-gray-200 rounded-full"></div>
                                                    <div class="absolute left-1 top-1 w-4 h-4 bg-white rounded-full transition-transform"></div>
                                                </div>
                                                <span class="text-gray-500">미승인</span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-center text-sm">
                                    <button onclick="deleteApplication('${seller.sellerRoleId}')" class="text-gray-400 hover:text-red-600 transition-colors" title="신청 삭제">
                                        <i class="fas fa-trash-alt"></i>
                                    </button>
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
    // 승인
    function approveSeller(sellerRoleId) {
        if (confirm('해당 신청을 승인하시겠습니까?')) {
            fetch('${pageContext.request.contextPath}/admin/approveSeller?sellerRoleId=' + sellerRoleId, {
                method: 'POST'
            })
            .then(res => {
                if (res.ok) {
                    alert('승인 처리되었습니다.');
                    location.reload();
                } else {
                    return res.text().then(t => { throw new Error(t); });
                }
            })
            .catch(err => alert('승인 처리 중 오류가 발생했습니다: ' + err.message));
        }
    }

    // 승인 취소
    function rejectSeller(sellerRoleId) {
        if (confirm('이 신청의 승인을 취소하시겠습니까?')) {
            fetch('${pageContext.request.contextPath}/admin/rejectSeller?sellerRoleId=' + sellerRoleId, {
                method: 'POST'
            })
            .then(res => {
                if (res.ok) {
                    alert('승인 취소 처리되었습니다.');
                    location.reload();
                } else {
                    return res.text().then(t => { throw new Error(t); });
                }
            })
            .catch(err => alert('승인 취소 처리 중 오류가 발생했습니다: ' + err.message));
        }
    }

    function deleteApplication(sellerRoleId) {
    	  if (confirm('이 신청 내역을 완전히 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
    	    fetch('${pageContext.request.contextPath}/admin/deleteApplication?sellerRoleId=' + sellerRoleId,
    	          { method: 'POST' })
    	    .then(res => {
    	        if (res.ok) {
    	            alert('삭제 처리되었습니다.');
    	            location.reload();
    	        } else {
    	            return res.text().then(t => { throw new Error(t); });
    	        }
    	    })
    	    .catch(err => alert('삭제 중 오류가 발생했습니다: ' + err.message));
    	  }
    	}

</script>
<<<<<<< HEAD
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
=======


>>>>>>> refs/heads/dev
</body>
</html>

