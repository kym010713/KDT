<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<h2>입점 신청서</h2>

<c:if test="${not empty message}">
    <p style="color: green;">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<form action="/seller/apply" method="post">
    <p>
        아이디: ${sessionScope.loginUser.id}
		<input type="hidden" name="sellerId" value="${sessionScope.loginUser.id}" />
    </p>
    <p>
        회사명 (브랜드명):<br>
        <input type="text" name="brandName" placeholder="예: 나이키, 아디다스" required>
    </p>
    <p>
        대표자 이름:<br>
        <input type="text" name="sellerName" placeholder="예: 홍길동" required>
    </p>
    <p>
        사업자 번호:<br>
        <input type="text" name="businessNumber" placeholder="예: 123-45-67890" required>
    </p>
    <p>
        사업장 주소:<br>
        <input type="text" name="sellerAddress" placeholder="예: 서울시 강남구 테헤란로 123" required>
    </p>
    <p>
        대표 전화번호:<br>
        <input type="text" name="sellerPhone" placeholder="예: 010-1234-5678" required>
    </p>
    <p>
        <button type="submit">입점 신청</button>
    </p>
</form>
