<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>결제 완료</title>
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
                            hover: '#111827'
                        }
                    }
                },
            },
        }
    </script>
</head>
<body class="bg-gray-50 min-h-screen font-pretendard">

    <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

    <div class="max-w-2xl mx-auto py-20 px-4 sm:px-6 lg:px-8">
        <div class="bg-white p-10 rounded-xl shadow-lg text-center">
            <div class="mb-6">
                <i class="fas fa-check-circle text-6xl text-green-500"></i>
            </div>
            <h2 class="text-3xl font-bold mb-3 text-gray-800">결제가 완료되었습니다!</h2>
            <p class="mb-8 text-gray-600">주문해주셔서 감사합니다. 빠르고 안전하게 배송해드리겠습니다.</p>
            
            <div class="flex items-center justify-center gap-x-4">
                <a href="${pageContext.request.contextPath}/" 
                   class="inline-flex items-center justify-center gap-2 w-full sm:w-auto px-6 py-3 text-base font-semibold text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-100 transition-colors shadow-sm">
                    <i class="fas fa-store"></i>
                    <span>쇼핑 계속하기</span>
                </a>
                <a href="${pageContext.request.contextPath}/mypage/order/list" 
                   class="inline-flex items-center justify-center gap-2 w-full sm:w-auto px-6 py-3 text-base font-semibold text-white bg-main-color rounded-lg hover:bg-main-color-hover transition-colors shadow-sm">
                   <i class="fas fa-receipt"></i>
                    <span>주문내역 보기</span>
                </a>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>
