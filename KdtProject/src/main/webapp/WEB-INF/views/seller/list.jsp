<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록 - 판매자</title>
    <style>
        .header-info {
            background-color: #f8f9fa;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            border-left: 4px solid #007bff;
        }
        .company-badge {
            background-color: #007bff;
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: bold;
        }
        .user-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navigation {
            background-color: #e9ecef;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
        }
        .nav-link {
            margin-right: 15px;
            text-decoration: none;
            color: #495057;
            font-weight: 500;
        }
        .nav-link:hover {
            color: #007bff;
        }
        .error { color: red; }
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); }
        .modal-content { background-color: white; margin: 15% auto; padding: 20px; width: 50%; }
        .close { float: right; font-size: 28px; cursor: pointer; }
        .size-tag { 
            display: inline-block; 
            margin: 2px 5px 2px 0; 
            padding: 2px 6px; 
            background-color: #f0f0f0; 
            border-radius: 3px; 
            font-size: 12px; 
            border: 1px solid #ddd;
        }
        .size-loading { color: #666; font-style: italic; }
        .size-error { color: red; font-size: 11px; }
        
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #dee2e6;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f8f9fa;
            font-weight: 600;
        }
        tr:nth-child(even) {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    

    <!-- 사용자 정보 헤더 -->
    <div class="header-info">
        <div class="user-info">
            <div>
                <strong>판매자:</strong> ${sessionScope.loginUser.name} (${sessionScope.loginUser.id})
                <span class="company-badge">${currentCompany}</span>
            </div>
            <div>
                <a href="/logout" style="color: #dc3545; text-decoration: none;">로그아웃</a>
            </div>
        </div>
    </div>

    <!-- 네비게이션 -->
    <div class="navigation">
        <a href="/seller/list" class="nav-link"> 상품 목록</a>
        <a href="/seller/register" class="nav-link"> 새 상품 등록</a>
        <a href="/seller/sales" class="nav-link"> 판매 내역</a>
        <a href="/seller/delivery" class="nav-link"> 배송 관리</a>
    </div>

    <h2>상품 목록</h2>
    <p><strong>현재 표시 중:</strong> <span class="company-badge">${currentCompany}</span> 회사의 상품만 표시됩니다.</p>
    
    <!-- 카테고리 필터 -->
    <div style="margin-bottom: 20px;">
        <strong>카테고리 필터:</strong>
        <form method="get" action="/seller/list" style="display: inline;">
            <select name="category" onchange="this.form.submit()">
                <option value="">전체 카테고리</option>
                <c:forEach items="${categories}" var="category">
                    <option value="${category.topName}" 
                            <c:if test="${selectedCategory eq category.topName}">selected</c:if>>
                        ${category.topName}
                    </option>
                </c:forEach>
            </select>
            <c:if test="${not empty selectedCategory}">
                <a href="/seller/list">초기화</a>
            </c:if>
        </form>
    </div>
    
    <!-- 상품 목록 테이블 -->
    <c:choose>
        <c:when test="${empty products}">
            <p>등록된 상품이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <table border="1" width="100%">
                <tr>
                    <th>카테고리</th>
                    <th>상품명</th>
                    <th>제조사</th>
                    <th>가격</th>
                    <th>사이즈별 재고</th>
                    <th>상품ID</th>
                    <th>액션</th>
                </tr>
                <c:forEach items="${products}" var="product">
                    <tr>
                        <td>${product.category}</td>
                        <td>${product.productName}</td>
                        <td>${product.companyName}</td>
                        <td><fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원</td>
                        <td>
                            <div id="sizeInfo_${product.productId}" class="size-loading">로딩중...</div>
                        </td>
                        <td>${product.productId}</td>
                        <td>
                            <button onclick="showProductDetail('${product.productId}')">상세보기</button>
                            <button onclick="editProduct('${product.productId}')">수정</button>
                            <button onclick="deleteProduct('${product.productId}')">삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            
            <p><strong>총 상품 수:</strong> ${products.size()}개</p>
            
            <!-- 페이지 로드 후 사이즈 정보 로드 -->
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    <c:forEach items="${products}" var="product">
                        loadSizeInfo('${product.productId}');
                    </c:forEach>
                });
            </script>
        </c:otherwise>
    </c:choose>

    <!-- 모달들 -->
    <div id="detailModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('detailModal')">&times;</span>
            <h3>상품 상세 정보</h3>
            <div id="detailContent"></div>
        </div>
    </div>
    
    <div id="editModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('editModal')">&times;</span>
            <h3>상품 수정</h3>
            <div id="alertContainer"></div>
            <div id="editContent">수정 폼이 여기에 로드됩니다...</div>
        </div>
    </div>

    <!-- JavaScript 함수들 -->
    <script>
        // 사이즈 정보 로드
        function loadSizeInfo(productId) {
            fetch('/seller/product/detail/' + productId)
                .then(response => response.json())
                .then(data => {
                    const container = document.getElementById('sizeInfo_' + productId);
                    if (data.success && data.optionDetails && data.optionDetails.length > 0) {
                        let sizeHtml = '';
                        data.optionDetails.forEach(option => {
                            sizeHtml += '<span class="size-tag">' + 
                                       option.sizeName + ': ' + option.stock + '개</span>';
                        });
                        container.innerHTML = sizeHtml;
                    } else {
                        container.innerHTML = '<span class="size-error">재고 정보 없음</span>';
                    }
                })
                .catch(error => {
                    document.getElementById('sizeInfo_' + productId).innerHTML = 
                        '<span class="size-error">로드 실패</span>';
                });
        }
        
        // 상품 상세보기
        function showProductDetail(productId) {
            fetch('/seller/product/detail/' + encodeURIComponent(productId))
                .then(response => response.json())
                .then(data => {
                    if (data.success && data.product) {
                        const product = data.product;
                        const optionDetails = data.optionDetails || [];
                        
                        let optionsHtml = '';
                        if (optionDetails.length > 0) {
                            optionsHtml = '<p><strong>사이즈별 재고:</strong></p><ul>';
                            optionDetails.forEach(option => {
                                optionsHtml += '<li>' + option.sizeName + ': ' + option.stock + '개</li>';
                            });
                            optionsHtml += '</ul>';
                        } else {
                            optionsHtml = '<p><strong>재고:</strong> 재고 정보 없음</p>';
                        }
                        
                        document.getElementById('detailContent').innerHTML = 
                            '<p><strong>상품명:</strong> ' + (product.productName || '') + '</p>' +
                            '<p><strong>제조사:</strong> ' + (product.companyName || '') + '</p>' +
                            '<p><strong>카테고리:</strong> ' + (product.category || '') + '</p>' +
                            '<p><strong>설명:</strong> ' + (product.productDetail || '') + '</p>' +
                            '<p><strong>가격:</strong> ' + (product.productPrice ? product.productPrice.toLocaleString() : '0') + '원</p>' +
                            optionsHtml +
                            (product.productPhoto ? '<p><strong>사진:</strong> ' + product.productPhoto + '</p>' : '');
                            
                        document.getElementById('detailModal').style.display = 'block';
                    } else {
                        alert('상품 정보를 불러올 수 없습니다: ' + (data.message || '알 수 없는 오류'));
                    }
                })
                .catch(error => alert('오류가 발생했습니다: ' + error.message));
        }
        
        // 상품 수정
        function editProduct(productId) {
            document.getElementById('editContent').innerHTML = '수정 기능을 준비 중입니다...';
            document.getElementById('editModal').style.display = 'block';
        }
        
        // 상품 삭제
        function deleteProduct(productId) {
            if (confirm('정말로 이 상품을 삭제하시겠습니까? 삭제된 상품은 복구할 수 없습니다.')) {
                fetch('/seller/product/delete/' + productId, {
                    method: 'DELETE'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        location.reload();
                    } else {
                        alert('삭제 실패: ' + data.message);
                    }
                })
                .catch(error => {
                    alert('오류가 발생했습니다: ' + error.message);
                });
            }
        }
        
        // 모달 닫기
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }
        
        // 모달 외부 클릭시 닫기
        window.onclick = function(event) {
            const detailModal = document.getElementById('detailModal');
            const editModal = document.getElementById('editModal');
            if (event.target == detailModal) {
                closeModal('detailModal');
            }
            if (event.target == editModal) {
                closeModal('editModal');
            }
        }
    </script>

</body>
</html>