<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>주문서 확인</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
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
  </script>
</head>
<body class="bg-gray-50 min-h-screen font-pretendard">
  <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

  <div class="max-w-4xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
    <h1 class="text-2xl font-bold mb-8 text-gray-800">주문서 확인</h1>

    <!-- 1. 내 정보 -->
    <section class="mb-10 bg-white shadow rounded-lg p-6">
      <h2 class="text-lg font-semibold mb-4 text-gray-800">내 정보</h2>
      <p class="text-gray-700 mb-1"><strong>이름:</strong> <c:out value="${sessionScope.loginUser.name}"/></p>
      <p class="text-gray-700 mb-1"><strong>연락처:</strong> <c:out value="${sessionScope.loginUser.phoneNumber}"/></p>
      <p class="text-gray-700"><strong>주소:</strong> <c:out value="${sessionScope.loginUser.address}"/></p>
      <div class="mt-4 text-right">
        <a href="${pageContext.request.contextPath}/mypage/address/form" class="text-sm text-main-color hover:underline">내 정보 수정 &gt;</a>
      </div>
    </section>

    <!-- 2. 주문 상품 요약 -->
    <section class="mb-10 bg-white shadow rounded-lg p-6">
      <h2 class="text-lg font-semibold mb-4 text-gray-800">주문 상품</h2>
      <table class="w-full text-sm text-left text-gray-600">
        <thead class="bg-gray-100 text-xs text-gray-700 uppercase">
          <tr>
            <th class="py-3 px-4">상품명</th>
            <th class="py-3 px-4 text-center">옵션</th>
            <th class="py-3 px-4 text-center">수량</th>
            <th class="py-3 px-4 text-center">금액</th>
          </tr>
        </thead>
        <tbody>
          <c:set var="grandTotal" value="0" />
          <c:forEach var="item" items="${cartList}">
            <tr class="border-b">
              <td class="py-3 px-4">
                <div class="flex items-center gap-3">
                  <img src="${pageContext.request.contextPath}/resources/upload/${item.productPhoto}" class="w-12 h-12 object-cover rounded" />
                  <span class="font-medium text-gray-800">${item.productName}</span>
                </div>
              </td>
              <td class="py-3 px-4 text-center">${item.productSize}</td>
              <td class="py-3 px-4 text-center">${item.cartCount}</td>
              <td class="py-3 px-4 text-center">
                <fmt:formatNumber value="${item.cartCount * item.productPrice}" groupingUsed="true"/>원
              </td>
            </tr>
            <c:set var="grandTotal" value="${grandTotal + (item.cartCount * item.productPrice)}" />
          </c:forEach>
        </tbody>
      </table>
      <div class="text-right mt-4 text-lg font-bold text-gray-800">
        총 결제금액:
        <span class="text-main-color text-xl ml-1">
          <fmt:formatNumber value="${grandTotal}" groupingUsed="true"/> 원
        </span>
      </div>
    </section>

    <!-- 3. 결제수단 선택 (카카오페이 단일) -->
    <section class="mb-10 bg-white shadow rounded-lg p-6">
      <h2 class="text-lg font-semibold mb-4 text-gray-800">결제수단 선택</h2>
      <form action="${pageContext.request.contextPath}/mypage/order/kakao/ready"
      method="post">
        <input type="hidden" name="totalPrice" value="${grandTotal}" />

        <div class="space-y-4">
          <label class="flex items-center gap-3">
            <input type="radio" name="payMethod" value="KAKAO" class="w-5 h-5 text-main-color" checked />
            <span class="text-gray-700">카카오페이</span>
          </label>
        </div>

        <div class="mt-8 text-center">
          <button type="submit" class="px-8 py-3 text-white text-lg font-semibold bg-main-color rounded-lg hover:bg-main-color-hover transition-colors shadow">
            결제하기
          </button>
        </div>
      </form>
    </section>
  </div>
</body>
</html>
