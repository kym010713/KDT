<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 내역</title>

    <!-- Tailwind & 폰트 -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" as="style" crossorigin
          href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css"/>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
	<script src="<c:url value='/resources/js/orderList.js'/>"></script>
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

<div class="container mx-auto max-w-4xl py-12 px-4 sm:px-6 lg:px-8">
    <div class="text-center mb-12">
        <h2 class="text-3xl font-bold text-gray-800">주문 내역</h2>
        <p class="text-gray-500 mt-2">최근 주문 내역을 확인하세요.</p>
    </div>

    <!-- 검색 영역 -->
    <div class="mb-10">
        <div class="p-4 border border-gray-200 rounded-lg bg-white shadow-sm">
            <form id="searchForm"
                  action="${pageContext.request.contextPath}/mypage/order/list"
                  method="get"
                  class="flex flex-col sm:flex-row sm:items-center sm:gap-4">

                <div class="flex items-center gap-2 mb-4 sm:mb-0">
                    <button type="button" class="date-preset-btn px-3 py-2 border rounded-md text-sm hover:bg-gray-100"
                            data-period="day" data-amount="0">오늘
                    </button>
                    <button type="button" class="date-preset-btn px-3 py-2 border rounded-md text-sm hover:bg-gray-100"
                            data-period="day" data-amount="7">1주일
                    </button>
                    <button type="button" class="date-preset-btn px-3 py-2 border rounded-md text-sm hover:bg-gray-100"
                            data-period="month" data-amount="1">1개월
                    </button>
                    <button type="button" class="date-preset-btn px-3 py-2 border rounded-md text-sm hover:bg-gray-100"
                            data-period="month" data-amount="3">3개월
                    </button>
                    <button type="button" class="date-preset-btn px-3 py-2 border rounded-md text-sm hover:bg-gray-100"
                            data-period="month" data-amount="6">6개월
                    </button>
                </div>

                <div class="flex items-center gap-2 flex-grow mb-4 sm:mb-0">
                    <input type="date" name="start"
                           class="bg-white border border-gray-300 rounded-lg text-sm focus:ring-main-color focus:border-main-color block w-full p-2">
                    <span class="text-gray-500">-</span>
                    <input type="date" name="end"
                           class="bg-white border border-gray-300 rounded-lg text-sm focus:ring-main-color focus:border-main-color block w-full p-2">
                </div>

                <button type="submit"
                        class="px-8 py-2 bg-main-color text-white rounded-md hover:bg-main-color-hover focus:outline-none">
                    조회
                </button>
            </form>
        </div>
    </div>

    <!-- 주문 없음 -->
    <c:if test="${empty headList}">
        <div class="text-center py-20 bg-white rounded-lg shadow-md">
            <i class="fas fa-box-open text-5xl text-gray-400 mb-4"></i>
            <p class="text-gray-600 text-lg">주문 내역이 없습니다.</p>
        </div>
    </c:if>

    <!-- 주문 목록 -->
    <c:forEach var="h" items="${headList}">
        <c:set var="state" value="${h.deliveryState}"/>
        <div class="bg-white rounded-xl shadow-lg mb-8 overflow-hidden">

            <!-- 헤더 -->
            <div class="bg-gray-100 px-6 py-4 border-b border-gray-200 flex justify-between items-center">
                <div>
                    <p class="text-sm text-gray-600">
                        <span class="font-semibold">주문일:</span>
                        <c:out value="${h.formattedOrderDate}" />
                    </p>
                    <p class="text-sm text-gray-600">
                        <span class="font-semibold">주문번호:</span> ${h.orderGroup}
                    </p>
                </div>

                <div class="text-right">
                    <c:choose>
                        <c:when test="${state == 'REQUESTED'}">
                            <p class="font-semibold text-yellow-500">배송 준비중</p>
                        </c:when>
                        <c:when test="${state == 'IN_PROGRESS'}">
                            <p class="font-semibold text-blue-500">배송 중</p>
                        </c:when>
                        <c:when test="${state == 'COMPLETED'}">
                            <p class="font-semibold text-green-600">배송 완료</p>
                        </c:when>
                    </c:choose>
                </div>
            </div>

            <!-- 진행 바 -->
            <div class="p-6">
                <div class="mb-8">
                    <div class="flex items-center">
                        <!-- 결제완료 -->
                        <div class="flex flex-col items-center flex-1">
                            <div class="w-10 h-10 rounded-full bg-main-color text-white flex items-center justify-center">
                                <i class="fas fa-receipt"></i>
                            </div>
                            <p class="mt-2 text-xs font-semibold text-gray-700">결제완료</p>
                        </div>
                        <div class="flex-1 h-1 bg-main-color"></div>

                        <!-- 상품준비중 -->
                        <div class="flex flex-col items-center flex-1">
                            <div class="w-10 h-10 rounded-full flex items-center justify-center
                                 ${state == 'REQUESTED' || state == 'IN_PROGRESS' || state == 'COMPLETED'
                                        ? 'bg-main-color text-white' : 'bg-gray-200 text-gray-400'}">
                                <i class="fas fa-box-open"></i>
                            </div>
                            <p class="mt-2 text-xs
                                 ${state == 'REQUESTED' || state == 'IN_PROGRESS' || state == 'COMPLETED'
                                        ? 'font-semibold text-gray-700' : 'text-gray-500'}">
                                배송 준비중
                            </p>
                        </div>
                        <div class="flex-1 h-1
                             ${state == 'IN_PROGRESS' || state == 'COMPLETED' ? 'bg-main-color' : 'bg-gray-200'}"></div>

                        <!-- 배송중 -->
                        <div class="flex flex-col items-center flex-1">
                            <div class="w-10 h-10 rounded-full flex items-center justify-center
                                 ${state == 'IN_PROGRESS' || state == 'COMPLETED'
                                        ? 'bg-main-color text-white' : 'bg-gray-200 text-gray-400'}">
                                <i class="fas fa-truck"></i>
                            </div>
                            <p class="mt-2 text-xs
                                 ${state == 'IN_PROGRESS' || state == 'COMPLETED'
                                        ? 'font-semibold text-gray-700' : 'text-gray-500'}">
                                배송중
                            </p>
                        </div>
                        <div class="flex-1 h-1
                             ${state == 'COMPLETED' ? 'bg-main-color' : 'bg-gray-200'}"></div>

                        <!-- 배송완료 -->
                        <div class="flex flex-col items-center flex-1">
                            <div class="w-10 h-10 rounded-full flex items-center justify-center
                                 ${state == 'COMPLETED'
                                        ? 'bg-main-color text-white' : 'bg-gray-200 text-gray-400'}">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <p class="mt-2 text-xs
                                 ${state == 'COMPLETED'
                                        ? 'font-semibold text-gray-700' : 'text-gray-500'}">
                                배송완료
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 상세 -->
                <table class="w-full text-sm text-left text-gray-500">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                    <tr>
                        <th class="px-6 py-3" colspan="2">상품 정보</th>
                        <th class="px-6 py-3 text-center">수량</th>
                        <th class="px-6 py-3 text-right">금액</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="orderTotal" value="0"/>
                    <c:forEach var="d" items="${detailMap[h.orderGroup]}">
                        <tr class="bg-white border-b">
                            <td class="px-6 py-4">
                                <img src="${imagekitUrl}product/${d.product.productPhoto}"
                                     class="w-16 h-16 object-cover rounded-md"/>
                            </td>
                            <th class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                                ${d.product.productName}
                            </th>
                            <td class="px-6 py-4 text-center">${d.quantity}</td>
                            <td class="px-6 py-4 text-right">
                                <fmt:formatNumber value="${d.quantity * d.product.productPrice}" groupingUsed="true"/> 원
                            </td>
                        </tr>
                        <c:set var="orderTotal"
                               value="${orderTotal + (d.quantity * d.product.productPrice)}"/>
                    </c:forEach>
                    </tbody>
                    <tfoot>
                    <tr class="font-semibold text-gray-900">
                        <td colspan="3" class="px-6 py-3 text-right text-base">총 결제금액</td>
                        <td class="px-6 py-3 text-right text-base">
                            <fmt:formatNumber value="${orderTotal}" groupingUsed="true"/> 원
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html>
