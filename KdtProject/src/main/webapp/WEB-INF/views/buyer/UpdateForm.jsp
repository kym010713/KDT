<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        gray: {
                            50: '#F9FAFB',
                            100: '#F3F4F6',
                            200: '#E5E7EB',
                            300: '#D1D5DB',
                            400: '#9CA3AF',
                            500: '#6B7280',
                            600: '#4B5563',
                            700: '#374151',
                            800: '#1F2937',
                            900: '#111827',
                        }
                    },
                    fontFamily: {
                        pretendard: ['Pretendard', 'sans-serif']
                    }
                }
            }
        };
    </script>
</head>
<body class="bg-gray-50 min-h-screen font-pretendard">
    <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

    <div class="max-w-2xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <div class="bg-white rounded-2xl shadow-lg p-8">
            <!-- 헤더 -->
            <div class="text-center mb-8">
                <h1 class="text-2xl font-bold text-gray-900">회원정보 수정</h1>
                <p class="mt-2 text-sm text-gray-600">변경하실 정보를 입력해주세요</p>
            </div>

            <!-- 에러 메시지 -->
            <c:if test="${not empty error}">
                <div class="mb-6 p-4 bg-red-50 border-l-4 border-red-500 rounded-md">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <i class="fas fa-exclamation-circle text-red-500"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-sm text-red-700">${error}</p>
                        </div>
                    </div>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/mypage/address/updateUser" method="post" class="space-y-6">
                <input type="hidden" name="id" value="${sessionScope.loginUser.id}" />

                <!-- 이름 필드 -->
                <div class="relative">
                    <label for="recipient" class="block text-sm font-medium text-gray-700 mb-1">이름</label>
                    <div class="relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-user text-gray-400"></i>
                        </div>
                        <input type="text" id="recipient" name="name" value="${sessionScope.loginUser.name}"
                            class="block w-full pl-10 pr-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-gray-800 focus:border-transparent transition-colors"
                            required />
                    </div>
                </div>

                <!-- 이메일 필드 -->
                <div class="relative">
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-1">이메일</label>
                    <div class="relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-envelope text-gray-400"></i>
                        </div>
                        <input type="email" id="email" name="email" value="${sessionScope.loginUser.email}"
                            class="block w-full pl-10 pr-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-gray-800 focus:border-transparent transition-colors"
                            required />
                    </div>
                </div>

                <!-- 연락처 필드 -->
                <div class="relative">
                    <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">연락처</label>
                    <div class="relative rounded-md shadow-sm">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-phone text-gray-400"></i>
                        </div>
                        <input type="tel" id="phone" name="phoneNumber" value="${sessionScope.loginUser.phoneNumber}"
                            class="block w-full pl-10 pr-3 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-gray-800 focus:border-transparent transition-colors"
                            placeholder="010-1234-5678" required
                            pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" />
                    </div>
                    <p class="mt-1 text-xs text-gray-500">형식: 010-1234-5678</p>
                </div>

                <!-- 주소 필드 -->
                <div class="relative">
                    <label for="address" class="block text-sm font-medium text-gray-700 mb-0.5">주소</label>
                    <div class="space-y-2">
                        <div class="flex gap-2">
                            <div class="relative flex-1">
                                <div class="absolute inset-y-0 left-0 pl-2.5 flex items-center pointer-events-none">
                                    <i class="fas fa-map-marker-alt text-gray-400 text-sm"></i>
                                </div>
                                <input type="text" id="postcode" placeholder="우편번호"
                                    class="block w-full pl-8 pr-2 py-2 text-sm border border-gray-300 rounded-md focus:ring-2 focus:ring-gray-800 focus:border-transparent transition-colors"
                                    readonly />
                            </div>
                            <button type="button" onclick="execDaumPostcode()"
                                class="px-3 py-2 bg-gray-800 text-white text-sm rounded-md hover:bg-gray-700 transition-colors flex items-center gap-1.5">
                                <i class="fas fa-search text-sm"></i>
                                주소 찾기
                            </button>
                        </div>
                        <input type="text" id="address" name="address" value="${sessionScope.loginUser.address}"
                            class="block w-full px-2.5 py-2 text-sm border border-gray-300 rounded-md focus:ring-2 focus:ring-gray-800 focus:border-transparent transition-colors"
                            placeholder="주소" readonly required />
                    </div>
                </div>

                <!-- 버튼 영역 -->
                <div class="flex justify-end gap-3 pt-6">
                    <a href="${pageContext.request.contextPath}/"
                        class="px-6 py-2.5 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors">
                        취소
                    </a>
                    <button type="submit"
                        class="px-6 py-2.5 bg-gray-800 text-white rounded-lg hover:bg-gray-700 transition-colors flex items-center gap-2">
                        <i class="fas fa-check"></i>
                        저장하기
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById('address').value = data.address;
                }
            }).open();
        }
    </script>
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>
