<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.tailwindcss.com"></script>
<meta charset="UTF-8">
<title>장바구니</title>
</head>
<body>

<%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

<h2>장바구니</h2>

<table>
  <thead>
    <tr>
      <th>이미지</th>
      <th>상품명</th>
      <th>사이즈</th>
      <th>수량</th>
      <th>삭제</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="item" items="${cartList}">
  <tr>
      <td><img src="${pageContext.request.contextPath}/resources/upload/${item.productPhoto}" alt="${item.productName}" width="50"/></td>
      <td>${item.productName}</td>
      <td>${item.productSize}</td>
      <td>${item.cartCount}</td>
      <td>
        <form action="${pageContext.request.contextPath}/mypage/cart/delete" method="post" style="margin:0;">
          <input type="hidden" name="cartId" value="${item.cartId}" />
          <button type="submit" class="text-red-600 hover:text-red-900">삭제</button>
        </form>
      </td>
  </tr>
</c:forEach>

  </tbody>
</table>

</body>
</html>
