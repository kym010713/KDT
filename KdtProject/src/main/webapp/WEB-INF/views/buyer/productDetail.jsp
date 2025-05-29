<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <script src="https://cdn.tailwindcss.com"></script>
  <title>${detail.productId} 상세정보</title>
</head>
<body class="bg-gray-100 text-gray-900">

  <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

  <div class="container mx-auto px-4 py-6">
    <h1 class="text-2xl font-bold mb-4">${detail.productName}</h1>

    <div class="bg-white rounded-lg shadow-md p-6 flex gap-6">
      <img src="${pageContext.request.contextPath}/resources/upload/${detail.productPhoto}" class="w-64 h-64 object-cover rounded" />

      <div>
        <p><strong>가격:</strong> ${detail.productPrice}원</p>
        <p><strong>상세설명:</strong> ${detail.productDetail}</p>
        <p><strong>재고 수량:</strong> ${detail.productCount}개</p>
        <p><strong>사이즈:</strong> ${detail.productSize}</p>
      </div>
    </div>
  </div>
</body>
</html>
