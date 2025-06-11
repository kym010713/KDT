<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 내역</title>
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

<div class="container mx-auto max-w-4xl py-12 px-4 sm:px-6 lg:px-8">
    <div class="text-center mb-12">
        <h2 class="text-3xl font-bold text-gray-800">주문 내역</h2>
        <p class="text-gray-500 mt-2">최근 주문 내역을 확인하세요.</p>
    </div>

    <c:if test="${empty headList}">
        <div class="text-center py-20 bg-white rounded-lg shadow-md">
            <i class="fas fa-box-open text-5xl text-gray-400 mb-4"></i>
            <p class="text-gray-600 text-lg">주문 내역이 없습니다.</p>
        </div>
    </c:if>

    <c:forEach var="h" items="${headList}">
        <div class="bg-white rounded-xl shadow-lg mb-8 overflow-hidden">
            <!-- 주문 헤더 -->
            <div class="bg-gray-100 px-6 py-4 border-b border-gray-200 flex justify-between items-center">
                <div>
                    <p class="text-sm text-gray-600">
                        <span class="font-semibold">주문일:</span>
                        <fmt:formatDate value="${h.orderDate}" pattern="yyyy-MM-dd HH:mm"/>
                    </p>
                    <p class="text-sm text-gray-600">
                        <span class="font-semibold">주문번호:</span> ${h.orderGroup}
                    </p>
                </div>
            </div>

            <!-- 주문 상세 -->
            <div class="p-6">
                <table class="w-full text-sm text-left text-gray-500">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                    <tr>
                        <th scope="col" class="px-6 py-3" colspan="2">상품 정보</th>
                        <th scope="col" class="px-6 py-3 text-center">수량</th>
                        <th scope="col" class="px-6 py-3 text-right">금액</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="orderTotal" value="0"/>
                    <c:forEach var="d" items="${detailMap[h.orderGroup]}">
                        <tr class="bg-white border-b">
                            <td class="px-6 py-4">
                                <img src="${pageContext.request.contextPath}/resources/upload/${d.product.productPhoto}"
                                     class="w-16 h-16 object-cover rounded-md"/>
                            </td>
                            <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap">
                                ${d.product.productName}
                            </th>
                            <td class="px-6 py-4 text-center">${d.quantity}</td>
                            <td class="px-6 py-4 text-right">
                                <fmt:formatNumber value="${d.quantity * d.product.productPrice}" groupingUsed="true"/> 원
                            </td>
                        </tr>
                        <!-- 총액 누적 -->
                        <c:set var="orderTotal"
                               value="${orderTotal + (d.quantity * d.product.productPrice)}"/>
                    </c:forEach>
                    </tbody>
                    <!-- 주문별 총 결제금액 -->
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
