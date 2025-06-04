<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송 관리 - 판매자</title>
</head>
<body>
    <h2>배송 관리</h2>
    
    <a href="/seller/list">상품 관리</a> | 
    <a href="/seller/sales">판매 내역</a> 
    <br><br>
    
    <!-- 배송 상태 필터 -->
    배송 상태 필터:
    <form method="get" action="/seller/delivery" style="display: inline;">
        <select name="status" onchange="this.form.submit()">
            <option value="ALL" <c:if test="${selectedStatus eq 'ALL'}">selected</c:if>>전체</option>
            <option value="미등록" <c:if test="${selectedStatus eq '미등록'}">selected</c:if>>미등록</option>
            <option value="IN_PROGRESS" <c:if test="${selectedStatus eq 'IN_PROGRESS'}">selected</c:if>>배송 중</option>
            <option value="COMPLETED" <c:if test="${selectedStatus eq 'COMPLETED'}">selected</c:if>>배송 완료</option>
        </select>
    </form>
    <br><br>
    
    <c:choose>
        <c:when test="${empty deliveryList}">
            <p>해당 상태의 배송 건이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <table border="1" width="100%">
                <tr>
                    <th>주문번호</th>
                    <th>구매자</th>
                    <th>상품명</th>
                    <th>주문일</th>
                    <th>배송 주소</th>
                    <th>현재 배송 상태</th>
                    <th>배송 요청일</th>
                    <th>배송 완료일</th>
                    <th>배송 액션</th>
                </tr>
                <c:forEach items="${deliveryList}" var="delivery">
                    <tr>
                        <td>${delivery.orderNumber}</td>
                        <td>${delivery.userId}</td>
                        <td>${delivery.productName}</td>
                        <td><fmt:formatDate value="${delivery.orderDate}" pattern="yyyy-MM-dd"/></td>
                        <td style="max-width: 200px; word-wrap: break-word;">${delivery.orderAddress}</td>
                        <td>
                            <c:choose>
                                <c:when test="${delivery.deliveryState == 'REQUESTED'}">
                                    <span style="color: orange;">배송 요청</span>
                                </c:when>
                                <c:when test="${delivery.deliveryState == 'IN_PROGRESS'}">
                                    <span style="color: blue;">배송 중</span>
                                </c:when>
                                <c:when test="${delivery.deliveryState == 'COMPLETED'}">
                                    <span style="color: green;">배송 완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: red;">${delivery.deliveryState}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${not empty delivery.requestDate}">
                                <fmt:formatDate value="${delivery.requestDate}" pattern="yyyy-MM-dd"/>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${not empty delivery.completeDate}">
                                <fmt:formatDate value="${delivery.completeDate}" pattern="yyyy-MM-dd"/>
                            </c:if>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${delivery.deliveryState == 'COMPLETED'}">
                                    <span style="color: green;">완료됨</span>
                                </c:when>
                                <c:otherwise>
                                    <select onchange="changeDeliveryStatus(${delivery.orderNumber}, this.value)">
                                        <option value="">상태 변경</option>
                                        
                                        <c:if test="${delivery.deliveryState != 'IN_PROGRESS'}">
                                            <option value="IN_PROGRESS">배송 중</option>
                                        </c:if>
                                        <c:if test="${delivery.deliveryState != 'COMPLETED'}">
                                            <option value="COMPLETED">배송 완료</option>
                                        </c:if>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            
            <br>
            <p><strong>총 배송 건수:</strong> ${deliveryList.size()}건</p>
            
            <!-- 상태별 카운트 -->
            <c:set var="inProgressCount" value="0" />
            <c:set var="completedCount" value="0" />
            <c:set var="unregisteredCount" value="0" />
            
            <c:forEach items="${deliveryList}" var="delivery">
                <c:choose>
                    <c:when test="${delivery.deliveryState == 'IN_PROGRESS'}">
                        <c:set var="inProgressCount" value="${inProgressCount + 1}" />
                    </c:when>
                    <c:when test="${delivery.deliveryState == 'COMPLETED'}">
                        <c:set var="completedCount" value="${completedCount + 1}" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="unregisteredCount" value="${unregisteredCount + 1}" />
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            
            <p>
                <strong>상태별 현황:</strong> 
                미등록 ${unregisteredCount}건 |  
                배송중 ${inProgressCount}건 | 
                배송완료 ${completedCount}건
            </p>
        </c:otherwise>
    </c:choose>
    
    <script>
        function changeDeliveryStatus(orderNumber, newStatus) {
            if (!newStatus) return;
            
            let confirmMessage = '';
            switch(newStatus) {
                
                case 'IN_PROGRESS':
                    confirmMessage = '배송 중으로 변경하시겠습니까?';
                    break;
                case 'COMPLETED':
                    confirmMessage = '배송 완료로 변경하시겠습니까?';
                    break;
                default:
                    confirmMessage = '배송 상태를 변경하시겠습니까?';
            }
            
            if (confirm(confirmMessage)) {
                fetch('/seller/delivery/update', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'orderNumber=' + orderNumber + '&newStatus=' + newStatus
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        location.reload();
                    } else {
                        alert('실패: ' + data.message);
                    }
                })
                .catch(error => {
                    alert('오류가 발생했습니다: ' + error.message);
                });
            } else {
                // 취소한 경우 select 초기화
                event.target.value = '';
            }
        }
    </script>
</body>
</html>