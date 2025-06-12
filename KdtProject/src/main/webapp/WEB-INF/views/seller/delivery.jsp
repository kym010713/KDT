<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>배송 관리 - 판매자</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Pretendard Font -->
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <style>
        :root {
            --primary-color: #333;
            --secondary-color: #666;
            --accent-color: #000;
            --background-color: #f5f5f5;
            --card-background: #fff;
            --border-color: #e0e0e0;
            --hover-color: #f0f0f0;
        }

        body {
            font-family: 'Pretendard', sans-serif;
            background-color: var(--background-color);
            color: var(--primary-color);
            padding: 2rem;
            padding-top: 5rem;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .card {
            background-color: var(--card-background);
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid var(--border-color);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .page-title {
            color: var(--accent-color);
            margin-bottom: 1.5rem;
            font-weight: 600;
            font-size: 2rem;
        }

        .filter-section {
            background-color: var(--card-background);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
        }

        .filter-form {
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: nowrap;
        }

        .filter-label {
            color: var(--secondary-color);
            font-weight: 500;
            white-space: nowrap;
            flex-shrink: 0;
        }

        .form-select {
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 0.5rem;
            min-width: 150px;
            transition: all 0.3s ease;
        }

        .form-select:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.2rem rgba(0,0,0,0.1);
        }

        .table {
            background-color: var(--card-background);
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 2rem;
            table-layout: fixed;
            width: 100%;
        }

        .table th {
            background-color: var(--hover-color);
            color: var(--primary-color);
            font-weight: 600;
            padding: 1rem 0.5rem;
            border-bottom: 2px solid var(--border-color);
            white-space: nowrap;
            text-align: center;
            font-size: 0.875rem;
        }

        .table td {
            padding: 1rem 0.5rem;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
            text-align: center;
            word-wrap: break-word;
        }

        .table tr:hover {
            background-color: var(--hover-color);
        }

        /* 테이블 컬럼 너비 설정 */
        .table th:nth-child(1), .table td:nth-child(1) { width: 8%; }   /* 주문번호 */
        .table th:nth-child(2), .table td:nth-child(2) { width: 8%; }   /* 구매자 */
        .table th:nth-child(3), .table td:nth-child(3) { width: 15%; }  /* 상품명 */
        .table th:nth-child(4), .table td:nth-child(4) { width: 8%; }   /* 주문일 */
        .table th:nth-child(5), .table td:nth-child(5) { width: 18%; }  /* 배송 주소 */
        .table th:nth-child(6), .table td:nth-child(6) { width: 10%; }  /* 현재 배송 상태 */
        .table th:nth-child(7), .table td:nth-child(7) { width: 8%; }   /* 배송 요청일 */
        .table th:nth-child(8), .table td:nth-child(8) { width: 8%; }   /* 배송 완료일 */
        .table th:nth-child(9), .table td:nth-child(9) { width: 12%; }  /* 배송 액션 */

        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.5rem;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 500;
            white-space: nowrap;
        }

        .status-requested {
            background-color: #fff3cd;
            color: #856404;
            border: 1px solid #ffeeba;
        }

        .status-in-progress {
            background-color: #cce5ff;
            color: #004085;
            border: 1px solid #b8daff;
        }

        .status-completed {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .status-unregistered {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .summary-box {
            background-color: var(--card-background);
            border-radius: 10px;
            padding: 1.5rem;
            margin-top: 2rem;
            border: 1px solid var(--border-color);
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
            border-bottom: 1px solid var(--border-color);
        }

        .summary-item:last-child {
            border-bottom: none;
        }

        .summary-label {
            color: var(--secondary-color);
            font-weight: 500;
        }

        .summary-value {
            color: var(--accent-color);
            font-weight: 600;
        }

        .status-stats {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 1rem;
        }

        .stat-item {
            background-color: var(--card-background);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 1rem;
            flex: 1;
            min-width: 200px;
            text-align: center;
        }

        .stat-label {
            color: var(--secondary-color);
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
        }

        .stat-value {
            color: var(--accent-color);
            font-size: 1.25rem;
            font-weight: 600;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--secondary-color);
        }

        .action-select {
            border: 1px solid var(--border-color);
            border-radius: 6px;
            padding: 0.3rem 0.5rem;
            background-color: var(--card-background);
            color: var(--primary-color);
            transition: all 0.3s ease;
            font-size: 0.8rem;
            width: 100%;
        }

        .action-select:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.2rem rgba(0,0,0,0.1);
        }

        .completed-text {
            color: #198754;
            font-weight: 500;
            font-size: 0.8rem;
        }

        .address-cell {
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: left;
        }

        .product-name {
            max-width: 120px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: left;
        }

        @media (max-width: 1200px) {
            .container {
                max-width: 100%;
                padding: 0 1rem;
            }
            
            .table th, .table td {
                padding: 0.75rem 0.25rem;
                font-size: 0.8rem;
            }
            
            .status-badge {
                font-size: 0.7rem;
                padding: 0.2rem 0.4rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/seller/nav.jsp" %>
    
    <div class="container">
        <h2 class="page-title">배송 관리</h2>
        
        <!-- 배송 상태 필터 -->
        <div class="filter-section">
            <form method="get" action="/seller/delivery" class="filter-form">
                <span class="filter-label">
                    <i class="fas fa-filter me-2"></i>배송 상태 필터:
                </span>
                <select name="status" class="form-select" onchange="this.form.submit()">
                    <option value="ALL" <c:if test="${selectedStatus eq 'ALL'}">selected</c:if>>전체</option>
                    <option value="미등록" <c:if test="${selectedStatus eq '미등록'}">selected</c:if>>미등록</option>
                    <option value="IN_PROGRESS" <c:if test="${selectedStatus eq 'IN_PROGRESS'}">selected</c:if>>배송 중</option>
                    <option value="COMPLETED" <c:if test="${selectedStatus eq 'COMPLETED'}">selected</c:if>>배송 완료</option>
                </select>
            </form>
        </div>
        
        <div class="card">
            <c:choose>
                <c:when test="${empty deliveryList}">
                    <div class="empty-state">
                        <i class="fas fa-box-open fa-3x mb-3"></i>
                        <p>해당 상태의 배송 건이 없습니다.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>주문번호</th>
                                    <th>구매자</th>
                                    <th>상품명</th>
                                    <th>주문일</th>
                                    <th>배송 주소</th>
                                    <th>현재 배송 상태</th>
                                    <th>배송 요청일</th>
                                    <th>배송 완료일</th>
                                    <th>배송 상태</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${deliveryList}" var="delivery">
                                <tr>
                                    <td>${delivery.orderNumber}</td>
                                    <td>${delivery.userId}</td>
                                    <td>
                                        <div class="product-name" title="${delivery.productName}">
                                            ${delivery.productName}
                                        </div>
                                    </td>
                                    <td><fmt:formatDate value="${delivery.orderDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>
                                        <div class="address-cell" title="${delivery.orderAddress}">
                                            ${delivery.orderAddress}
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${delivery.deliveryState == 'REQUESTED'}">
                                                <span class="status-badge status-requested">배송 요청</span>
                                            </c:when>
                                            <c:when test="${delivery.deliveryState == 'IN_PROGRESS'}">
                                                <span class="status-badge status-in-progress">배송 중</span>
                                            </c:when>
                                            <c:when test="${delivery.deliveryState == 'COMPLETED'}">
                                                <span class="status-badge status-completed">배송 완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-unregistered">${delivery.deliveryState}</span>
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
                                                <span class="completed-text">
                                                    <i class="fas fa-check-circle me-1"></i>완료됨
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <select class="action-select" onchange="changeDeliveryStatus(${delivery.orderNumber}, this.value)">
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
                            </tbody>
                        </table>
                    </div>
                    
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
                    
                    <div class="summary-box">
                        <div class="summary-item">
                            <span class="summary-label">총 배송 건수</span>
                            <span class="summary-value">${deliveryList.size()}건</span>
                        </div>
                        
                        <div class="status-stats">
                            <div class="stat-item">
                                <div class="stat-label">미등록</div>
                                <div class="stat-value">${unregisteredCount}건</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-label">배송중</div>
                                <div class="stat-value">${inProgressCount}건</div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-label">배송완료</div>
                                <div class="stat-value">${completedCount}건</div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
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
                event.target.value = '';
            }
        }
    </script>
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>