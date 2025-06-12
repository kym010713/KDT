<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>클로디</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        pretendard: ['Pretendard', 'sans-serif'],
                    },
                    colors: {
                        'main-color': {
                            DEFAULT: '#1f2937',
                            'hover': '#111827'
                        }
                    }
                },
            },
        }
    </script>
</head>
<body class="bg-gray-50 font-pretendard">

    <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

    <div class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12">
        <div class="text-center mb-16">
            <h1 class="text-4xl md:text-5xl font-extrabold tracking-tight text-gray-900">
                <span class="text-main-color">클로디</span>에서 발견하는 당신만의 스타일
            </h1>
            <p class="mt-4 max-w-2xl mx-auto text-lg text-gray-500">
                최신 트렌드부터 베이직 아이템까지, 필요한 모든 것을 한곳에서 만나보세요.
            </p>
        </div>

        <div>
            <h2 class="text-3xl font-bold text-gray-800 mb-8">새로운 상품</h2>
            
            <c:if test="${empty products}">
                <div class="text-center py-20 bg-white rounded-lg shadow-md">
                    <i class="fas fa-store-slash text-5xl text-gray-400 mb-4"></i>
                    <p class="text-gray-600 text-lg">현재 판매중인 상품이 없습니다.</p>
                </div>
            </c:if>

            <!-- 상품 목록을 카드 형태로 표시 -->
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
                <c:forEach var="product" items="${products}">
                    <div class="group relative bg-white rounded-xl shadow-md overflow-hidden transform hover:-translate-y-1 transition-all duration-300">
                        <a href="${pageContext.request.contextPath}/mypage/product/detail?id=${product.productId}" class="block">
                            <div class="w-full h-56 overflow-hidden">
                                <img 
                                    src="${imagekitUrl}product/${product.productPhoto}" 
                                    alt="${product.productName}" 
                                    class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                                />
                            </div>
                            <div class="p-4">
                                <h3 class="text-lg font-semibold text-gray-800 truncate">${product.productName}</h3>
                                <p class="text-md text-gray-900 font-bold mt-2">
                                    <fmt:formatNumber value="${product.productPrice}" groupingUsed="true"/>원
                                </p>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
<%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>
