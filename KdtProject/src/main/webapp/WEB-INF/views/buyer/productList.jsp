<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${category} 상품 목록</title>

    <!-- Tailwind & 폰트 -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" as="style" crossorigin
          href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {pretendard: ['Pretendard', 'sans-serif']},
                    colors: {
                        'main-color': {DEFAULT: '#1f2937', 'hover': '#111827'}
                    }
                }
            }
        };
    </script>
</head>
<body class="bg-gray-50 font-pretendard">

<%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

<div class="container mx-auto max-w-7xl py-12 px-4 sm:px-6 lg:px-8">
    <div class="text-left mb-12">
        <h2 class="text-3xl font-bold text-gray-800 tracking-tight">
            <c:out value="${category}"/>
        </h2>
    </div>

    <c:if test="${not empty products}">
        <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-x-6 gap-y-10">
            <c:forEach var="p" items="${products}">
                <div class="group relative">
                    <a href="${pageContext.request.contextPath}/mypage/product/detail?id=${p.productId}"
                       class="block text-left">
                        <div class="aspect-w-1 aspect-h-1 w-full overflow-hidden rounded-lg bg-gray-200 xl:aspect-w-7 xl:aspect-h-8">
                            <img src="${imagekitUrl}product/${p.productPhoto}"
                                 alt="${p.productName}" class="h-full w-full object-cover object-center group-hover:opacity-75 transition-opacity duration-300">
                        </div>
                        <h3 class="mt-4 text-sm text-gray-700 h-10">${p.productName}</h3>
                        <p class="mt-1 text-lg font-medium text-gray-900">
                            <fmt:formatNumber value="${p.productPrice}" type="number" groupingUsed="true"/>원
                        </p>
                    </a>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty products}">
        <div class="text-center py-20 bg-white rounded-lg shadow-md">
            <i class="fas fa-box-open text-5xl text-gray-400 mb-4"></i>
            <p class="text-gray-600 text-lg">이 카테고리에 등록된 상품이 없습니다.</p>
        </div>
    </c:if>
</div>

<%@ include file="/WEB-INF/views/buyer/footer.jsp" %>

</body>
</html>
