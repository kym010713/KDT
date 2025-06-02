<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <script src="https://cdn.tailwindcss.com"></script>
  <title>쇼핑몰 메인</title>
</head>
<body class="bg-gray-100 text-gray-900">

  <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

  <div class="container mx-auto px-4 py-6">
    <h1 class="text-3xl font-bold mb-6">쇼핑몰에 오신 것을 환영합니다!</h1>

    <h2 class="text-2xl font-semibold mb-4">상품 목록</h2>

    <!-- 상품 목록을 카드 형태로 표시 -->
    <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-6">
      <c:forEach var="product" items="${products}">
        <div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow">
          <a href="${pageContext.request.contextPath}/mypage/product/detail?id=${product.productId}">
	          <img 
	            src="${pageContext.request.contextPath}/resources/upload/${product.productPhoto}" 
	            alt="${product.productName}" 
	            class="w-full h-40 object-cover"
	          />
          </a>
          <div class="p-2 text-center">
            <p class="text-sm text-gray-800 font-medium">${product.productName}</p>
            <p class="text-xs text-gray-500 mt-1">${product.productPrice}원</p>
          </div>
        </div>
      </c:forEach>
    </div>

    <!-- 장바구니 버튼 -->
    <div class="mt-8 text-center">
      <form action="${pageContext.request.contextPath}/mypage/cart" method="get">
        <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition">
          장바구니 보기
        </button>
      </form>
    </div>
  </div>

</body>
</html>
