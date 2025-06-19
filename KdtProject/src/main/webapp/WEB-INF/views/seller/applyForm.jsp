<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>입점 신청</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script>
        tailwind.config = {
            theme: {
                extend: {
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
<body class="bg-gray-50 min-h-screen font-pretendard">

    <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

    <div class="max-w-4xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <div class="bg-white shadow-lg rounded-xl overflow-hidden">
            <div class="px-6 py-5 border-b border-gray-200">
                <h2 class="text-xl font-bold text-gray-800 flex items-center">
                    <i class="fas fa-store-alt mr-3 text-main-color"></i>
                    <span>입점 신청</span>
                </h2>
            </div>
            
            <form action="/seller/apply" method="post" class="p-6 space-y-6">

                <c:if test="${not empty message}">
                    <div class="p-4 mb-4 text-sm text-green-800 rounded-lg bg-green-50" role="alert">
                        <span class="font-medium">성공!</span> ${message}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                     <div class="p-4 mb-4 text-sm text-red-800 rounded-lg bg-red-50" role="alert">
                        <span class="font-medium">오류!</span> ${error}
                    </div>
                </c:if>

                <div class="space-y-2">
                    <label class="block text-sm font-medium text-gray-700">아이디</label>
                    <p class="mt-1 text-gray-900 font-semibold">${sessionScope.loginUser.id}</p>
                    <input type="hidden" name="sellerId" value="${sessionScope.loginUser.id}" />
                </div>
                
                <div class="space-y-2">
                    <label for="brandName" class="block text-sm font-medium text-gray-700">회사명 (브랜드명)</label>
                    <input type="text" id="brandName" name="brandName" placeholder="예: 나이키, 아디다스" required
                           class="block w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm transition-colors">
                </div>

                <div class="space-y-2">
                    <label for="sellerName" class="block text-sm font-medium text-gray-700">대표자 이름</label>
                    <input type="text" id="sellerName" name="sellerName" placeholder="예: 홍길동" required
                           class="block w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm transition-colors">
                </div>

                <div class="space-y-2">
                    <label for="businessNumber" class="block text-sm font-medium text-gray-700">사업자 번호</label>
                    <input type="text" id="businessNumber" name="businessNumber" placeholder="예: 123-45-67890" required
                           class="block w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm transition-colors">
                </div>

                <div class="space-y-2">
                    <label for="sellerAddress" class="block text-sm font-medium text-gray-700">사업장 주소</label>
                    <input type="text" id="sellerAddress" name="sellerAddress" placeholder="예: 서울시 강남구 테헤란로 123" required
                           class="block w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm transition-colors">
                </div>

                <div class="space-y-2">
                    <label for="sellerPhone" class="block text-sm font-medium text-gray-700">대표 전화번호</label>
                    <input type="text" id="sellerPhone" name="sellerPhone" placeholder="예: 010-1234-5678" required
                           class="block w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm transition-colors">
                </div>
                
                <div class="flex justify-end pt-4 border-t border-gray-200 mt-8">
                    <button type="submit" class="inline-flex items-center justify-center gap-2 px-6 py-2.5 text-sm font-semibold text-white bg-main-color rounded-lg hover:bg-main-color-hover transition-colors shadow-sm">
                        <i class="fas fa-paper-plane"></i>
                        <span>입점 신청하기</span>
                    </button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>
