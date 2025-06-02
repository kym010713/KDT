<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>장바구니</h2>
	<table border="1">
		<tr>
			<th>상품 ID</th>
			<th>수량</th>
			<th>담은 날짜</th>
		</tr>
		<c:forEach var="item" items="${cartList}">
    <tr>
        <td>${item.product.productName}</td> 
        <td>${item.cartCount}</td>
        <td>${item.cartDate}</td>
    </tr>
</c:forEach>

	</table>

</body>
</html>