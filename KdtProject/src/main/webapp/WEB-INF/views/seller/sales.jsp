<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>판매 내역 - 판매자</title>
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
        .main-content {
    margin-top: 100px; 
    padding: 2rem;
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
            flex-wrap: wrap;
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

        .btn-primary {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            border-radius: 8px;
            padding: 0.5rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            transform: translateY(-1px);
        }

        .btn-outline-secondary {
            border-color: var(--border-color);
            color: var(--secondary-color);
            border-radius: 8px;
            padding: 0.5rem 1rem;
            transition: all 0.3s ease;
        }

        .btn-outline-secondary:hover {
            background-color: var(--hover-color);
            border-color: var(--secondary-color);
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
        .table th:nth-child(4), .table td:nth-child(4) { width: 10%; }  /* 제조사 */
        .table th:nth-child(5), .table td:nth-child(5) { width: 8%; }   /* 가격 */
        .table th:nth-child(6), .table td:nth-child(6) { width: 8%; }   /* 주문일 */
        .table th:nth-child(7), .table td:nth-child(7) { width: 18%; }  /* 배송 주소 */
        .table th:nth-child(8), .table td:nth-child(8) { width: 10%; }  /* 배송 상태 */
        .table th:nth-child(9), .table td:nth-child(9) { width: 8%; }   /* 배송 요청일 */
        .table th:nth-child(10), .table td:nth-child(10) { width: 8%; } /* 배송 완료일 */

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

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--secondary-color);
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

        .company-name {
            max-width: 80px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: left;
        }

        .price-cell {
            text-align: right;
            font-weight: 500;
        }

        .filter-info {
            background-color: #e3f2fd;
            border: 1px solid #2196f3;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1rem;
            color: #1565c0;
        }

        .filter-info i {
            margin-right: 0.5rem;
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
            
            .filter-form {
                flex-direction: column;
                align-items: stretch;
            }
            
            .filter-form > * {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/seller/nav.jsp" %>
    
    <div class="main-content">
    <div class="container">
        <h2 class="page-title">판매 내역</h2>
        
        <!-- 필터 섹션 -->
        <div class="filter-section">
            <form method="get" action="/seller/sales" class="filter-form">
                <span class="filter-label">
                    <i class="fas fa-filter me-2"></i>필터:
                </span>
                
                <!-- 월별 필터 -->
                <select name="month" class="form-select">
                    <option value="">전체 기간</option>
                    <option value="2025-06" <c:if test="${selectedMonth eq '2025-06'}">selected</c:if>>2025년 6월</option>
                    <option value="2025-05" <c:if test="${selectedMonth eq '2025-05'}">selected</c:if>>2025년 5월</option>
                    <option value="2025-04" <c:if test="${selectedMonth eq '2025-04'}">selected</c:if>>2025년 4월</option>
                    <option value="2025-03" <c:if test="${selectedMonth eq '2025-03'}">selected</c:if>>2025년 3월</option>
                    <option value="2025-02" <c:if test="${selectedMonth eq '2025-02'}">selected</c:if>>2025년 2월</option>
                    <option value="2025-01" <c:if test="${selectedMonth eq '2025-01'}">selected</c:if>>2025년 1월</option>
                    <option value="2024-12" <c:if test="${selectedMonth eq '2024-12'}">selected</c:if>>2024년 12월</option>
                    <option value="2024-11" <c:if test="${selectedMonth eq '2024-11'}">selected</c:if>>2024년 11월</option>
                    <option value="2024-10" <c:if test="${selectedMonth eq '2024-10'}">selected</c:if>>2024년 10월</option>
                </select>
                
                <!-- 배송 상태 필터 -->
                <select name="status" class="form-select">
                    <option value="">전체 상태</option>
                    <option value="미등록" <c:if test="${selectedStatus eq '미등록'}">selected</c:if>>미등록</option>
                    <option value="REQUESTED" <c:if test="${selectedStatus eq 'REQUESTED'}">selected</c:if>>배송 요청</option>
                    <option value="IN_PROGRESS" <c:if test="${selectedStatus eq 'IN_PROGRESS'}">selected</c:if>>배송 중</option>
                    <option value="COMPLETED" <c:if test="${selectedStatus eq 'COMPLETED'}">selected</c:if>>배송 완료</option>
                </select>
                
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search me-1"></i>조회
                </button>
                
                <!-- 필터 초기화 버튼 -->
                <c:if test="${not empty selectedMonth or not empty selectedStatus}">
                    <a href="/seller/sales" class="btn btn-outline-secondary">
                        <i class="fas fa-times me-1"></i>초기화
                    </a>
                </c:if>
            </form>
        </div>
        
        <!-- 필터 적용 상태 표시 -->
        <c:if test="${not empty selectedMonth or not empty selectedStatus}">
            <div class="filter-info">
                <i class="fas fa-info-circle"></i>
                <strong>필터 적용됨:</strong>
                <c:if test="${not empty selectedMonth}">
                    <c:choose>
                        <c:when test="${selectedMonth eq '2025-06'}">2025년 6월</c:when>
                        <c:when test="${selectedMonth eq '2025-05'}">2025년 5월</c:when>
                        <c:when test="${selectedMonth eq '2025-04'}">2025년 4월</c:when>
                        <c:when test="${selectedMonth eq '2025-03'}">2025년 3월</c:when>
                        <c:when test="${selectedMonth eq '2025-02'}">2025년 2월</c:when>
                        <c:when test="${selectedMonth eq '2025-01'}">2025년 1월</c:when>
                        <c:when test="${selectedMonth eq '2024-12'}">2024년 12월</c:when>
                        <c:when test="${selectedMonth eq '2024-11'}">2024년 11월</c:when>
                        <c:when test="${selectedMonth eq '2024-10'}">2024년 10월</c:when>
                        <c:otherwise>${selectedMonth}</c:otherwise>
                    </c:choose>
                </c:if>
                <c:if test="${not empty selectedMonth and not empty selectedStatus}"> | </c:if>
                <c:if test="${not empty selectedStatus}">
                    <c:choose>
                        <c:when test="${selectedStatus eq 'REQUESTED'}">배송 요청</c:when>
                        <c:when test="${selectedStatus eq 'IN_PROGRESS'}">배송 중</c:when>
                        <c:when test="${selectedStatus eq 'COMPLETED'}">배송 완료</c:when>
                        <c:otherwise>${selectedStatus}</c:otherwise>
                    </c:choose>
                </c:if>
            </div>
        </c:if>
        
        <!-- 판매 내역 테이블 -->
        <div class="card">
            <c:choose>
                <c:when test="${empty salesList}">
                    <div class="empty-state">
                        <i class="fas fa-box-open fa-3x mb-3"></i>
                        <c:choose>
                            <c:when test="${not empty selectedMonth or not empty selectedStatus}">
                                <p>선택된 조건에 해당하는 판매 내역이 없습니다.</p>
                                <a href="/seller/sales" class="btn btn-outline-secondary">
                                    <i class="fas fa-list me-1"></i>전체 내역 보기
                                </a>
                            </c:when>
                            <c:otherwise>
                                <p>판매 내역이 없습니다.</p>
                            </c:otherwise>
                        </c:choose>
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
                                    <th>제조사</th>
                                    <th>가격</th>
                                    <th>주문일</th>
                                    <th>배송 주소</th>
                                    <th>배송 상태</th>
                                    <th>배송 요청일</th>
                                    <th>배송 완료일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${salesList}" var="sales">
                                <tr>
                                    <td>${sales.orderNumber}</td>
                                    <td>${sales.userId}</td>
                                    <td>
                                        <div class="product-name" title="${sales.productName}">
                                            ${sales.productName}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="company-name" title="${sales.companyName}">
                                            ${sales.companyName}
                                        </div>
                                    </td>
                                    <td class="price-cell">
                                        <fmt:formatNumber value="${sales.productPrice}" pattern="#,###"/>원
                                    </td>
                                    <td><fmt:formatDate value="${sales.orderDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>
                                        <div class="address-cell" title="${sales.orderAddress}">
                                            ${sales.orderAddress}
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${sales.deliveryState == 'REQUESTED'}">
                                                <span class="status-badge status-requested">배송 요청</span>
                                            </c:when>
                                            <c:when test="${sales.deliveryState == 'IN_PROGRESS'}">
                                                <span class="status-badge status-in-progress">배송 중</span>
                                            </c:when>
                                            <c:when test="${sales.deliveryState == 'COMPLETED'}">
                                                <span class="status-badge status-completed">배송 완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge">${sales.deliveryState}</span>
                                            </c:otherwise>
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
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- 요약 정보 -->
                    <div class="summary-box">
                        <div class="summary-item">
                            <span class="summary-label">
                                <c:choose>
                                    <c:when test="${not empty selectedMonth or not empty selectedStatus}">
                                        필터된 판매 건수
                                    </c:when>
                                    <c:otherwise>
                                        총 판매 건수
                                    </c:otherwise>
                                </c:choose>
                            </span>
                            <span class="summary-value">${salesList.size()}건</span>
                        </div>
                        
                        <!-- 매출 합계 계산 -->
                        <c:set var="totalSales" value="0" />
                        <c:forEach items="${salesList}" var="sales">
                            <c:set var="totalSales" value="${totalSales + sales.productPrice}" />
                        </c:forEach>
                        <div class="summary-item">
                            <span class="summary-label">
                                <c:choose>
                                    <c:when test="${not empty selectedMonth or not empty selectedStatus}">
                                        필터된 매출
                                    </c:when>
                                    <c:otherwise>
                                        총 매출
                                    </c:otherwise>
                                </c:choose>
                            </span>
                            <span class="summary-value"><fmt:formatNumber value="${totalSales}" pattern="#,###"/>원</span>
                        </div>
                        
                        <!-- 평균 주문가 -->
                        <c:if test="${salesList.size() > 0}">
                            <div class="summary-item">
                                <span class="summary-label">평균 주문가</span>
                                <span class="summary-value">
                                    <fmt:formatNumber value="${totalSales / salesList.size()}" pattern="#,###"/>원
                                </span>
                            </div>
                        </c:if>
                        
                      
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>