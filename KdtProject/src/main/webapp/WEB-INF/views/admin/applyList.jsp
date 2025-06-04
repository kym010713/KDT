<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>입점 신청 목록</h2>

<c:if test="${empty applyList}">
	<p>현재 등록된 입점 신청이 없습니다.</p>
</c:if>

<script>
function approveSeller(sellerRoleId, status) {
    if (status === 'Y') {
        alert('이미 승인된 신청입니다.');
        return;
    }

    if (confirm('신청을 승인하시겠습니까?')) {
        fetch('/admin/approveSeller?sellerRoleId=' + sellerRoleId, {
            method: 'POST'
        }).then(() => {
            alert('승인 처리되었습니다.');
            location.reload();
        }).catch(() => {
            alert('승인 처리 중 오류가 발생했습니다.');
        });
    }
}
</script>

<c:if test="${not empty applyList}">
	<table border="1" style="width: 100%; border-collapse: collapse;">
		<tr>
			<th>아이디</th>
			<th>회사명(브랜드명)</th>
			<th>대표자 이름</th>
			<th>사업자 번호</th>
			<th>사업장 주소</th>
			<th>대표 전화번호</th>
			<th>승인 상태</th>
		</tr>
		<c:forEach var="seller" items="${applyList}">
			<tr>
				<td style="text-align: center;">${seller.sellerId}</td>
				<td style="text-align: center;">${seller.brandName}</td>
				<td style="text-align: center;">${seller.sellerName}</td>
				<td style="text-align: center;">${seller.businessNumber}</td>
				<td style="text-align: center;">${seller.sellerAddress}</td>
				<td style="text-align: center;">${seller.sellerPhone}</td>
				<td style="text-align: center; cursor: pointer;"
				    onclick="approveSeller('${seller.sellerRoleId}', '${seller.status}')">
				    <c:choose>
				        <c:when test="${seller.status == 'Y'}">✅ 승인됨</c:when>
				        <c:otherwise>❌ 미승인</c:otherwise>
				    </c:choose>
				</td>
			</tr>
		</c:forEach>
	</table>
</c:if>

