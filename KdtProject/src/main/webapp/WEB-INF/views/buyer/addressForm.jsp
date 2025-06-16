<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>배송지 정보 수정</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            'main-color': {
              DEFAULT: '#1f2937',
              hover: '#111827',
            },
          },
        },
      },
    };

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById('address').value = data.address;
            }
        }).open();
    }
  </script>
</head>
<body class="bg-gray-50 min-h-screen font-pretendard">
  <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

  <div class="max-w-lg mx-auto py-12 px-4 sm:px-6 lg:px-8">
    <h1 class="text-2xl font-bold mb-8 text-gray-800 text-center">내 정보 수정</h1>

    <form action="${pageContext.request.contextPath}/mypage/address/update" method="post" class="bg-white p-8 shadow rounded-lg space-y-6">
      <!-- 수령인 -->
      <div>
        <label for="recipient" class="block text-sm font-medium text-gray-700 mb-1">이름</label>
        <input type="text" id="recipient" name="name" value="${sessionScope.loginUser.name}"
               class="w-full border-gray-300 rounded-md shadow-sm focus:ring-main-color focus:border-main-color" required />
      </div>

      <!-- 연락처 -->
      <div>
        <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">연락처</label>
        <input type="text" id="phone" name="phoneNumber" value="${sessionScope.loginUser.phoneNumber}"
               class="w-full border-gray-300 rounded-md shadow-sm focus:ring-main-color focus:border-main-color" placeholder="010-1234-5678" required />
      </div>

      <!-- 주소 -->
      <div class="space-y-2">
        <label for="address" class="block text-sm font-medium text-gray-700 mb-1">주소</label>
        <div class="flex gap-2">
          <input type="text" id="postcode" placeholder="우편번호"
                 class="w-32 border-gray-300 rounded-md shadow-sm focus:ring-main-color focus:border-main-color" readonly />
          <button type="button" onclick="execDaumPostcode()"
                  class="px-4 py-2 text-white bg-main-color rounded-md hover:bg-main-color-hover transition-colors flex items-center gap-2">
            <i class="fas fa-search text-sm"></i>
            주소 찾기
          </button>
        </div>
        <input type="text" id="address" name="address" value="${sessionScope.loginUser.address}"
               class="w-full border-gray-300 rounded-md shadow-sm focus:ring-main-color focus:border-main-color" 
               placeholder="주소" readonly required />
      </div>

      <div class="flex justify-between pt-4">
        <a href="${pageContext.request.contextPath}/mypage/order/form" class="text-sm text-gray-500 hover:underline">&#x2039; 주문서로 돌아가기</a>
        <button type="submit"
                class="px-6 py-2 text-white font-semibold bg-main-color rounded-lg hover:bg-main-color-hover transition-colors shadow">
          저장하기
        </button>
      </div>
    </form>
  </div>
  <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>
