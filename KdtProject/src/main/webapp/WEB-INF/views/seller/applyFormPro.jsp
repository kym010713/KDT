<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>입점 신청 완료</title>
</head>
<body>

<h2>입점 신청이 완료되었습니다</h2>

<p>관리자의 승인 후 판매자로 전환됩니다.</p>
<p>승인 결과는 로그인 후 [마이페이지]에서 확인하실 수 있습니다.</p>

<hr>

<h3>신청 정보</h3>
<ul>
    <li><strong>판매자 ID:</strong> ${seller.sellerId}</li>
    <li><strong>회사명 (브랜드명):</strong> ${seller.brandName}</li>
    <li><strong>대표자 이름:</strong> ${seller.sellerName}</li>
    <li><strong>사업자 번호:</strong> ${seller.businessNumber}</li>
    <li><strong>주소:</strong> ${seller.sellerAddress}</li>
    <li><strong>전화번호:</strong> ${seller.sellerPhone}</li>

</ul>

<br>
<button onclick="location.href='/'">메인으로 가기</button>

</body>
</html>
