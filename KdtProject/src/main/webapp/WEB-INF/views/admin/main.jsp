<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>관리자 대시보드</title>
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
                <i class="fas fa-shield-alt mr-3 text-main-color"></i>관리자 대시보드
            </h1>
            <p class="mt-4 max-w-2xl mx-auto text-lg text-gray-500">
                사이트의 주요 기능을 관리하고 설정합니다.
            </p>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- 회원 관리 카드 -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden transform hover:-translate-y-1 transition-all duration-300">
                <a href="${pageContext.request.contextPath}/admin/userList" class="block p-8 text-center">
                    <i class="fas fa-users text-5xl text-main-color mb-6"></i>
                    <h3 class="text-2xl font-bold text-gray-800">회원 관리</h3>
                    <p class="mt-2 text-gray-600">사용자 계정 관리 및 등급 설정</p>
                </a>
            </div>
            
            <!-- 입점 신청 관리 카드 -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden transform hover:-translate-y-1 transition-all duration-300">
                <a href="${pageContext.request.contextPath}/admin/applyList" class="block p-8 text-center">
                    <i class="fas fa-store text-5xl text-main-color mb-6"></i>
                    <h3 class="text-2xl font-bold text-gray-800">입점 신청 관리</h3>
                    <p class="mt-2 text-gray-600">신규 입점 신청 검토 및 관리</p>
                </a>
            </div>

            <!-- 챗봇 관리 카드 -->
            <div class="bg-white rounded-xl shadow-md overflow-hidden transform hover:-translate-y-1 transition-all duration-300">
                <a href="${pageContext.request.contextPath}/admin/faq/list" class="block p-8 text-center">
                    <i class="fas fa-robot text-5xl text-main-color mb-6"></i>
                    <h3 class="text-2xl font-bold text-gray-800">챗봇 관리</h3>
                    <p class="mt-2 text-gray-600">챗봇 키워드 등록 및 관리</p>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
