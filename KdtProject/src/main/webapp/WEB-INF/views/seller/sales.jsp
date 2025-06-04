<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>판매 내역 - 판매자</title>
</head>
<body>
    <h2>판매 내역</h2>
    
    <a href="/seller/list">상품 목록</a> |  
    <a href="/seller/delivery">배송 관리</a>
    <br><br>
    
    <c:choose>
        <c:when test="${empty salesList}">
            <p>판매 내역이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <table border="1" width="100%">
                <tr>
                    <th>주문번호</th>
                    <th>구매자</th>
                    <th>상품명</th>
                    <th>제조사</th>
                    <th>가격</th>
                    <th>주문일</th>
                    <th>배송 주소</th>
                    <th>배송 상태</th>
                    <th>배송 요청일</th>
                    <th>배송 완료일</th>
                </tr>
                <c:forEach items="${salesList}" var="sales">
                    <tr>
                        <td>${sales.orderNumber}</td>
                        <td>${sales.userId}</td>
                        <td>${sales.productName}</td>
                        <td>${sales.companyName}</td>
                        <td><fmt:formatNumber value="${sales.productPrice}" pattern="#,###"/>원</td>
                        <td><fmt:formatDate value="${sales.orderDate}" pattern="yyyy-MM-dd"/></td>
                        <td>${sales.orderAddress}</td>
                        <td>
                            <c:choose>
                                <c:when test="${sales.deliveryState == 'REQUESTED'}">배송 요청</c:when>
                                <c:when test="${sales.deliveryState == 'IN_PROGRESS'}">배송 중</c:when>
                                <c:when test="${sales.deliveryState == 'COMPLETED'}">배송 완료</c:when>
                                <c:otherwise>${sales.deliveryState}</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${not empty sales.requestDate}">
                                <fmt:formatDate value="${sales.requestDate}" pattern="yyyy-MM-dd"/>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${not empty sales.completeDate}">
                                <fmt:formatDate value="${sales.completeDate}" pattern="yyyy-MM-dd"/>
                            </c:if>
                        </td>
                        
                    </tr>
                </c:forEach>
            </table>
            
            <br>
            <p><strong>총 판매 건수:</strong> ${salesList.size()}건</p>
            
            <!-- 매출 합계 계산 -->
            <c:set var="totalSales" value="0" />
            <c:forEach items="${salesList}" var="sales">
                <c:set var="totalSales" value="${totalSales + sales.productPrice}" />
            </c:forEach>
            <p><strong>총 매출:</strong> <fmt:formatNumber value="${totalSales}" pattern="#,###"/>원</p>
        </c:otherwise>
    </c:choose>
    
    
</body>
</html>