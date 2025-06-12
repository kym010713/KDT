<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>입점 신청 완료</title>
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

    <div class="max-w-3xl mx-auto py-20 px-4 sm:px-6 lg:px-8">
        <div class="bg-white p-8 rounded-xl shadow-lg text-center">
            <div class="mb-6">
                <i class="fas fa-paper-plane text-5xl text-main-color"></i>
            </div>
            <h2 class="text-3xl font-bold mb-3 text-gray-800">입점 신청이 완료되었습니다.</h2>
            <p class="mb-8 text-gray-600">관리자 승인 후 판매자 활동이 가능합니다. 검토에는 최대 1-2일이 소요될 수 있습니다.</p>
        </div>

        <div class="mt-8 bg-white shadow-lg rounded-xl overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200">
                <h3 class="text-lg font-semibold text-gray-800">신청 정보 요약</h3>
            </div>
            <div class="p-6 space-y-4">
                <div class="flex justify-between">
                    <span class="font-medium text-gray-600">판매자 ID</span>
                    <span class="font-semibold text-gray-800">${seller.sellerId}</span>
                </div>
                <div class="flex justify-between">
                    <span class="font-medium text-gray-600">회사명 (브랜드명)</span>
                    <span class="font-semibold text-gray-800">${seller.brandName}</span>
                </div>
                <div class="flex justify-between">
                    <span class="font-medium text-gray-600">대표자 이름</span>
                    <span class="font-semibold text-gray-800">${seller.sellerName}</span>
                </div>
                <div class="flex justify-between">
                    <span class="font-medium text-gray-600">사업자 번호</span>
                    <span class="font-semibold text-gray-800">${seller.businessNumber}</span>
                </div>
                <div class="flex justify-between">
                    <span class="font-medium text-gray-600">사업장 주소</span>
                    <span class="font-semibold text-gray-800">${seller.sellerAddress}</span>
                </div>
                <div class="flex justify-between">
                    <span class="font-medium text-gray-600">대표 전화번호</span>
                    <span class="font-semibold text-gray-800">${seller.sellerPhone}</span>
                </div>
            </div>
             <div class="px-6 py-4 bg-gray-50 border-t border-gray-200 text-center">
                 <a href="/" class="inline-flex items-center justify-center gap-2 px-6 py-2.5 text-sm font-semibold text-white bg-main-color rounded-lg hover:bg-main-color-hover transition-colors shadow-sm">
                    <i class="fas fa-home"></i>
                    <span>메인으로 가기</span>
                </a>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>
