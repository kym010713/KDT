<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>상품 목록 - 판매자</title>
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

        .header-info {
            background-color: var(--card-background);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .company-badge {
            background-color: var(--accent-color);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }

        .user-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-links {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .nav-link {
            color: var(--secondary-color);
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-link:hover {
            background-color: var(--hover-color);
            color: var(--accent-color);
        }

        .logout-link {
            color: #dc3545;
            text-decoration: none;
            font-weight: 500;
        }

        .logout-link:hover {
            color: #b02a37;
        }

        .filter-section {
            background-color: var(--card-background);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
        }

        .filter-label {
            color: var(--secondary-color);
            font-weight: 500;
            margin-right: 1rem;
             white-space: nowrap;
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
        .table th:nth-child(1), .table td:nth-child(1) { width: 8%; }   /* 이미지 */
    .table th:nth-child(2), .table td:nth-child(2) { width: 10%; }  /* 카테고리 */
    .table th:nth-child(3), .table td:nth-child(3) { width: 18%; }  /* 상품명 */
    .table th:nth-child(4), .table td:nth-child(4) { width: 10%; }  /* 제조사 */
    .table th:nth-child(5), .table td:nth-child(5) { width: 10%; }  /* 가격 */
    .table th:nth-child(6), .table td:nth-child(6) { width: 18%; }  /* 사이즈별 재고 */
    .table th:nth-child(7), .table td:nth-child(7) { width: 10%; }  /* 상품ID */
    .table th:nth-child(8), .table td:nth-child(8) { width: 16%; }  /* 액션 */

        .btn {
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background-color: var(--accent-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-color);
        }

        .btn-outline-primary {
            border: 1px solid var(--accent-color);
            color: var(--accent-color);
            background-color: transparent;
        }

        .btn-outline-primary:hover {
            background-color: var(--accent-color);
            color: white;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .size-tag { 
            display: inline-block; 
            margin: 2px 5px 2px 0; 
            padding: 0.25rem 0.5rem; 
            background-color: var(--hover-color); 
            border-radius: 12px; 
            font-size: 0.75rem; 
            border: 1px solid var(--border-color);
            color: var(--primary-color);
        }

        .size-loading { 
            color: var(--secondary-color); 
            font-style: italic; 
            font-size: 0.875rem;
        }

        .size-error { 
            color: #dc3545; 
            font-size: 0.75rem; 
        }

        .modal { 
            display: none; 
            position: fixed; 
            z-index: 1000; 
            left: 0; 
            top: 0; 
            width: 100%; 
            height: 100%; 
            background-color: rgba(0,0,0,0.5);
            overflow-y: auto;
        }

        .modal-content { 
            background-color: var(--card-background); 
            margin: 5% auto; 
            padding: 2rem; 
            width: 50%; 
            max-height: 90vh;
            overflow-y: auto;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }

        .close { 
            float: right; 
            font-size: 1.5rem; 
            cursor: pointer; 
            color: var(--secondary-color);
            transition: color 0.3s ease;
        }

        .close:hover {
            color: var(--accent-color);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--primary-color);
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 0.2rem rgba(0,0,0,0.1);
            outline: none;
        }

        .form-group textarea {
            height: 100px;
            resize: vertical;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--secondary-color);
        }

        .summary-box {
            background-color: var(--card-background);
            border-radius: 10px;
            padding: 1.5rem;
            margin-top: 1rem;
            border: 1px solid var(--border-color);
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
        }

        .summary-label {
            color: var(--secondary-color);
            font-weight: 500;
        }

        .summary-value {
            color: var(--accent-color);
            font-weight: 600;
        }

        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 1rem;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }

        .product-name {
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: left;
        }

        .company-name {
            max-width: 100px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: left;
        }

        .price-cell {
            text-align: right;
            font-weight: 500;
        }
        .table td img:hover {
        transform: scale(1.1);
        transition: transform 0.3s ease;
        cursor: pointer;
    }

         @media (max-width: 1200px) {
        .table th:nth-child(1), .table td:nth-child(1) { 
            width: 10%; 
        }
        .table td img {
            width: 50px;
            height: 50px;
        }
            
            .table th, .table td {
                padding: 0.75rem 0.25rem;
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/seller/nav.jsp" %>
    
    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
            <h2 class="page-title" style="margin-bottom: 0;">상품 목록</h2>
            <a href="/seller/register" class="btn btn-primary">
                <i class="fas fa-plus me-2"></i>새 상품 등록
            </a>
        </div>

        <!-- 카테고리 필터 -->
        <div class="filter-section">
            <form method="get" action="/seller/list" class="d-flex align-items-center">
                <span class="filter-label">
                    <i class="fas fa-filter me-2"></i>카테고리 필터:
                </span>
                <select name="category" class="form-select" onchange="this.form.submit()">
                    <option value="">전체 카테고리</option>
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.topName}" 
                                <c:if test="${selectedCategory eq category.topName}">selected</c:if>>
                            ${category.topName}
                        </option>
                    </c:forEach>
                </select>
                <c:if test="${not empty selectedCategory}">
                    <a href="/seller/list" class="btn btn-outline-primary ms-2">
                        <i class="fas fa-times me-1"></i>초기화
                    </a>
                </c:if>
            </form>
        </div>
        
        <!-- 상품 목록 테이블 -->
        <div class="card">
            <c:choose>
                <c:when test="${empty products}">
                    <div class="empty-state">
                        <i class="fas fa-box-open fa-3x mb-3"></i>
                        <p>등록된 상품이 없습니다.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>이미지</th>
                                    <th>카테고리</th>
                                    <th>상품명</th>
                                    <th>제조사</th>
                                    <th>가격</th>
                                    <th>사이즈별 재고</th>
                                    <th>상품ID</th>
                                    <th>상세/수정/삭제</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${products}" var="product">
                                    <tr>
                                        <!-- 상품 이미지 -->
                                        <td style="text-align: center; vertical-align: middle;">
                                            <c:choose>
                                                <c:when test="${not empty product.productPhoto}">
                                                    <img src="https://ik.imagekit.io/alzwu0day/clodi/product/${product.productPhoto}" 
                                                         alt="${product.productName}"
                                                         style="width: 60px; height: 60px; object-fit: cover; border-radius: 8px; border: 1px solid var(--border-color);"
                                                         onerror="this.src='${pageContext.request.contextPath}/resources/images/no-image.png';" />
                                                </c:when>
                                                <c:otherwise>
                                                    <div style="width: 60px; height: 60px; background-color: var(--hover-color); border-radius: 8px; display: flex; align-items: center; justify-content: center; border: 1px solid var(--border-color);">
                                                        <i class="fas fa-image text-gray-400"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${product.category}</td>
                                        <td>
                                            <div class="product-name" title="${product.productName}">
                                                ${product.productName}
                                            </div>
                                        </td>
                                        <td>
                                            <div class="company-name" title="${product.companyName}">
                                                ${product.companyName}
                                            </div>
                                        </td>
                                        <td class="price-cell">
                                            <c:choose>
                                                <c:when test="${product.productPrice != null}">
                                                    <fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원
                                                </c:when>
                                                <c:otherwise>0원</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div id="sizeInfo_${product.productId}" class="size-loading">로딩중...</div>
                                        </td>
                                        <td>${product.productId}</td>
                                        <td>
                                            <button class="btn btn-primary btn-sm me-1" onclick="showProductDetail('${product.productId}')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button class="btn btn-outline-primary btn-sm me-1" onclick="editProduct('${product.productId}')">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button class="btn btn-danger btn-sm" onclick="deleteProduct('${product.productId}')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="summary-box">
                        <div class="summary-item">
                            <span class="summary-label">총 상품 수</span>
                            <span class="summary-value">${products.size()}개</span>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 상세보기 모달 -->
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
        <form id="editForm">
            <div class="form-group">
                <label for="editCategory">카테고리:</label>
                <select id="editCategory" name="category">
                    <option value="">카테고리를 선택하세요</option>
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.topName}">${category.topName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="editProductName">상품명:</label>
                <input type="text" id="editProductName" name="productName" required>
            </div>
            <div class="form-group">
                <label for="editCompanyName">제조사:</label>
                <input type="text" id="editCompanyName" name="companyName" readonly style="background-color: #f8f9fa;">
            </div>
            <div class="form-group">
                <label for="editProductDetail">상품 설명:</label>
                <textarea id="editProductDetail" name="productDetail" required></textarea>
            </div>
            <div class="form-group">
                <label for="editProductPrice">가격:</label>
                <input type="text" id="editProductPrice" name="productPrice" required>
            </div>
            
            <!-- 이미지 업로드 부분 - 단순화 -->
            <div class="form-group">
                <label>상품 이미지:</label>
                
                <!-- 현재 이미지 표시 -->
                <div style="margin-bottom: 15px;">
                    <label style="font-size: 0.9em; color: var(--secondary-color); display: block; margin-bottom: 5px;">현재 이미지:</label>
                    <div id="currentImageDisplay" style="padding: 10px; border: 1px solid var(--border-color); border-radius: 8px; min-height: 60px; display: flex; align-items: center; justify-content: center;">
                        <!-- JavaScript로 동적 생성 -->
                    </div>
                </div>
                
                <!-- 새 이미지 업로드 -->
                <div style="margin-bottom: 15px;">
                    <label style="font-size: 0.9em; color: var(--secondary-color); display: block; margin-bottom: 5px;">새 이미지 업로드:</label>
                    <input type="file" id="editProductImageFile" name="productImageFile" accept="image/*" onchange="handleEditImageSelect(this)" style="width: 100%; padding: 8px; border: 1px solid var(--border-color); border-radius: 4px;">
                    <div id="editImagePreview" style="margin-top: 10px; text-align: center;"></div>
                </div>
                
                <!-- URL 직접 입력 -->
                <div>
                    <label for="editProductPhoto" style="font-size: 0.9em; color: var(--secondary-color); display: block; margin-bottom: 5px;">또는 URL 직접 입력:</label>
                    <input type="text" id="editProductPhoto" name="productPhoto" placeholder="이미지 URL" style="width: 100%; padding: 8px; border: 1px solid var(--border-color); border-radius: 4px;">
                </div>
            </div>
            
            <!-- 사이즈별 재고 입력 영역 -->
            <div class="form-group">
                <label>사이즈별 재고:</label>
                <div id="sizeStockContainer">
                    <!-- JavaScript로 동적 생성 -->
                </div>
            </div>
            
            <div class="form-group">
                <button type="button" class="btn btn-primary" onclick="updateProduct()">
                    <i class="fas fa-save me-1"></i>수정 완료
                </button>
                <button type="button" class="btn btn-outline-primary" onclick="closeModal('editModal')">
                    <i class="fas fa-times me-1"></i>취소
                </button>
            </div>
        </form>
    </div>
</div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

 
<script>
    let currentEditProductId = null;
    
    // HTML 이스케이프 함수
    function escapeHtml(text) {
        if (!text) return '';
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
    
    // 안전한 필드 값 설정 함수
    function setFieldValue(fieldId, value) {
        const field = document.getElementById(fieldId);
        if (field) {
            field.value = value || '';
        } else {
            console.warn('Field not found:', fieldId);
        }
    }

    // ✅ 사이즈 정보 로드 함수 (다시 정의)
    function loadSizeInfo(productId) {
        console.log('Loading size info for product:', productId);
        
        if (!productId) {
            console.error('Product ID is null or undefined');
            return;
        }
        
        const container = document.getElementById('sizeInfo_' + productId);
        if (!container) {
            console.error('Container not found for product ID:', productId);
            return;
        }
        
        // 로딩 상태 표시
        container.innerHTML = '<span class="size-loading">로딩중...</span>';
        
        fetch('/seller/product/detail/' + encodeURIComponent(productId))
            .then(response => {
                console.log('Response status for', productId, ':', response.status);
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                console.log('API Response for', productId, ':', data);
                
                if (data.success && data.optionDetails && data.optionDetails.length > 0) {
                    let sizeHtml = '';
                    data.optionDetails.forEach(option => {
                        sizeHtml += '<span class="size-tag">' + 
                                   escapeHtml(option.sizeName) + ': ' + option.stock + '개</span>';
                    });
                    container.innerHTML = sizeHtml;
                    console.log('Successfully updated size info for', productId);
                } else {
                    console.warn('No option details found for', productId, ':', data);
                    container.innerHTML = '<span class="size-error">재고 정보 없음</span>';
                }
            })
            .catch(error => {
                console.error('Error loading size info for product ' + productId + ':', error);
                container.innerHTML = '<span class="size-error">로드 실패: ' + error.message + '</span>';
            });
    }
    
    // ✅ 페이지 로드 후 사이즈 정보 로드 - 통합된 이벤트 리스너
    document.addEventListener('DOMContentLoaded', function() {
        console.log('DOM Content Loaded - Starting size info load');
        
        // 약간의 지연을 두고 실행 (DOM이 완전히 준비될 때까지)
        setTimeout(function() {
            <c:if test="${not empty products}">
                const productIds = [
                    <c:forEach items="${products}" var="product" varStatus="status">
                        '${product.productId}'<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];
                
                console.log('Product IDs to load:', productIds);
                
                productIds.forEach(function(productId, index) {
                    if (productId && productId.trim() !== '') {
                        // 순차적으로 로드 (서버 부하 방지)
                        setTimeout(() => {
                            loadSizeInfo(productId);
                        }, index * 100);
                    }
                });
            </c:if>
        }, 200);
    });
    
    // 상품 상세보기
    function showProductDetail(productId) {
        if (!productId) {
            alert('상품 ID가 유효하지 않습니다.');
            return;
        }
        
        fetch('/seller/product/detail/' + encodeURIComponent(productId))
            .then(response => {
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                if (data.success && data.product) {
                    const product = data.product;
                    const optionDetails = data.optionDetails || [];
                    
                    let optionsHtml = '';
                    if (optionDetails.length > 0) {
                        optionsHtml = '<p><strong>사이즈별 재고:</strong></p><ul>';
                        optionDetails.forEach(option => {
                            optionsHtml += '<li>' + escapeHtml(option.sizeName) + ': ' + option.stock + '개</li>';
                        });
                        optionsHtml += '</ul>';
                    } else {
                        optionsHtml = '<p><strong>재고:</strong> 재고 정보 없음</p>';
                    }
                    
                    const price = product.productPrice ? parseInt(product.productPrice).toLocaleString() : '0';
                    
                    document.getElementById('detailContent').innerHTML = 
                        '<p><strong>상품명:</strong> ' + escapeHtml(product.productName || '') + '</p>' +
                        '<p><strong>제조사:</strong> ' + escapeHtml(product.companyName || '') + '</p>' +
                        '<p><strong>카테고리:</strong> ' + escapeHtml(product.category || '') + '</p>' +
                        '<p><strong>설명:</strong> ' + escapeHtml(product.productDetail || '') + '</p>' +
                        '<p><strong>가격:</strong> ' + price + '원</p>' +
                        optionsHtml +
                        (product.productPhoto ? '<p><strong>사진:</strong> ' + escapeHtml(product.productPhoto) + '</p>' : '');
                        
                    document.getElementById('detailModal').style.display = 'block';
                } else {
                    alert('상품 정보를 불러올 수 없습니다: ' + (data.message || '알 수 없는 오류'));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다: ' + error.message);
            });
    }
    
    // 현재 이미지 표시 함수
    function displayCurrentImage(photoUrl) {
        const currentImageDisplay = document.getElementById('currentImageDisplay');
        if (currentImageDisplay) {
            if (photoUrl && photoUrl.trim() !== '') {
                currentImageDisplay.innerHTML = 
                    '<img src="https://ik.imagekit.io/alzwu0day/clodi/product/' + escapeHtml(photoUrl) + '" ' +
                    'style="max-width: 150px; max-height: 150px; border-radius: 8px; border: 1px solid var(--border-color);" ' +
                    'alt="현재 상품 이미지" ' +
                    'onerror="this.src=\'/resources/images/no-image.png\';">';
            } else {
                currentImageDisplay.innerHTML = '<span style="color: var(--secondary-color);">등록된 이미지가 없습니다.</span>';
            }
        }
    }
    
    // 이미지 선택 핸들러
    function handleEditImageSelect(input) {
        const file = input.files[0];
        const preview = document.getElementById('editImagePreview');
        
        if (file) {
            // 파일 크기 체크 (10MB 제한)
            if (file.size > 10 * 1024 * 1024) {
                alert('파일 크기는 10MB 이하여야 합니다.');
                input.value = '';
                return;
            }
            
            // 이미지 파일 타입 체크
            if (!file.type.startsWith('image/')) {
                alert('이미지 파일만 업로드 가능합니다.');
                input.value = '';
                return;
            }
            
            // 이미지 미리보기
            const reader = new FileReader();
            reader.onload = function(e) {
                if (preview) {
                    preview.innerHTML = '<img src="' + e.target.result + '" style="max-width: 150px; max-height: 150px; border-radius: 8px; border: 1px solid var(--border-color);">';
                }
            };
            reader.readAsDataURL(file);
            
            // URL 입력 필드 비우기
            const photoUrlField = document.getElementById('editProductPhoto');
            if (photoUrlField) {
                photoUrlField.value = '';
            }
        } else {
            if (preview) {
                preview.innerHTML = '';
            }
        }
    }
    
    // 상품 수정
    function editProduct(productId) {
        if (!productId) {
            alert('상품 ID가 유효하지 않습니다.');
            return;
        }
        
        currentEditProductId = productId;
        clearAlert();
        
        fetch('/seller/product/edit/' + encodeURIComponent(productId))
            .then(response => {
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                }
                return response.json();
            })
            .then(responseData => {
                if (responseData.success && responseData.data) {
                    const data = responseData.data;
                    
                    // 폼 필드 안전하게 설정
                    setFieldValue('editCategory', data.category);
                    setFieldValue('editProductName', data.productName);
                    setFieldValue('editCompanyName', data.companyName);
                    setFieldValue('editProductDetail', data.productDetail);
                    setFieldValue('editProductPrice', data.productPrice);
                    setFieldValue('editProductPhoto', data.productPhoto);
                    
                    // 현재 이미지 표시
                    displayCurrentImage(data.productPhoto);
                    
                    // 사이즈별 재고 입력 폼 생성
                    generateSizeStockInputs(data.productOptions || []);
                    
                    document.getElementById('editModal').style.display = 'block';
                } else {
                    alert('상품 정보를 불러올 수 없습니다: ' + (responseData.message || '알 수 없는 오류'));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다: ' + error.message);
            });
    }
    
    // 사이즈별 재고 입력 폼 생성
    function generateSizeStockInputs(productOptions) {
        const container = document.getElementById('sizeStockContainer');
        if (!container) {
            console.error('Size stock container not found');
            return;
        }
        
        container.innerHTML = '';
        
        if (!Array.isArray(productOptions)) {
            console.error('Product options is not an array');
            return;
        }
        
        productOptions.forEach(option => {
            if (!option.sizeName) return;
            
            const div = document.createElement('div');
            div.style.marginBottom = '5px';
            div.innerHTML = 
                '<label style="display: inline-block; width: 80px;">' + escapeHtml(option.sizeName) + ':</label>' +
                '<input type="number" min="0" value="' + (option.stock || 0) + '" ' +
                       'name="stock_' + (option.sizeId || '') + '" style="width: 80px;"> 개';
            container.appendChild(div);
        });
    }
    
    // 상품 업데이트
    function updateProduct() {
        if (!currentEditProductId) {
            alert('상품 ID가 설정되지 않았습니다.');
            return;
        }
        
        try {
            // FormData 생성
            const formData = new FormData();
            
            // 기본 정보 추가
            formData.append('category', document.getElementById('editCategory')?.value || '');
            formData.append('productName', document.getElementById('editProductName')?.value || '');
            formData.append('companyName', document.getElementById('editCompanyName')?.value || '');
            formData.append('productDetail', document.getElementById('editProductDetail')?.value || '');
            formData.append('productPrice', document.getElementById('editProductPrice')?.value || '');
            formData.append('productPhoto', document.getElementById('editProductPhoto')?.value || '');
            
            // 이미지 파일 추가
            const imageFileInput = document.getElementById('editProductImageFile');
            if (imageFileInput && imageFileInput.files[0]) {
                formData.append('productImageFile', imageFileInput.files[0]);
            }
            
            // 사이즈별 재고 데이터 수집
            const sizeStockInputs = document.querySelectorAll('#sizeStockContainer input[name^="stock_"]');
            const productOptions = [];
            
            sizeStockInputs.forEach(input => {
                const sizeId = input.name.split('_')[1];
                const stock = parseInt(input.value) || 0;
                if (sizeId && stock > 0) {
                    productOptions.push({
                        sizeId: parseInt(sizeId),
                        stock: stock
                    });
                }
            });
            
            // productOptions를 JSON 문자열로 추가
            formData.append('productOptions', JSON.stringify(productOptions));
            
            console.log('FormData 내용:');
            for (let [key, value] of formData.entries()) {
                if (value instanceof File) {
                    console.log(key + ':', value.name, '(' + value.size + ' bytes)');
                } else {
                    console.log(key + ':', value);
                }
            }
            
            // 서버로 전송
            fetch('/seller/product/update/' + encodeURIComponent(currentEditProductId), {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    showAlert('success', data.message);
                    setTimeout(() => {
                        closeModal('editModal');
                        location.reload();
                    }, 1500);
                } else {
                    showAlert('error', data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showAlert('error', '오류가 발생했습니다: ' + error.message);
            });
        } catch (error) {
            console.error('Update product error:', error);
            showAlert('error', '상품 업데이트 중 오류가 발생했습니다.');
        }
    }
    
    // 알림 표시
    function showAlert(type, message) {
        const alertContainer = document.getElementById('alertContainer');
        if (!alertContainer) return;
        
        const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
        const iconClass = type === 'success' ? 'check-circle' : 'exclamation-circle';
        
        alertContainer.innerHTML = '<div class="alert ' + alertClass + '">' + 
                                 '<i class="fas fa-' + iconClass + ' me-2"></i>' + 
                                 escapeHtml(message) + '</div>';
    }
    
    // 알림 지우기
    function clearAlert() {
        const alertContainer = document.getElementById('alertContainer');
        if (alertContainer) {
            alertContainer.innerHTML = '';
        }
    }
    
    // 상품 삭제
    function deleteProduct(productId) {
        if (!productId) {
            alert('상품 ID가 유효하지 않습니다.');
            return;
        }
        
        if (confirm('정말로 이 상품을 삭제하시겠습니까? 삭제된 상품은 복구할 수 없습니다.')) {
            fetch('/seller/product/delete/' + encodeURIComponent(productId), {
                method: 'DELETE'
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status + ': ' + response.statusText);
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    location.reload();
                } else {
                    alert('삭제 실패: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다: ' + error.message);
            });
        }
    }
    
    // 모달 닫기
    function closeModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.style.display = 'none';
        }
        
        if (modalId === 'editModal') {
            currentEditProductId = null;
            clearAlert();
            // 이미지 미리보기 초기화
            const preview = document.getElementById('editImagePreview');
            if (preview) {
                preview.innerHTML = '';
            }
            // 파일 입력 초기화
            const fileInput = document.getElementById('editProductImageFile');
            if (fileInput) {
                fileInput.value = '';
            }
        }
    }
    
    // 모달 외부 클릭시 닫기
    window.onclick = function(event) {
        const detailModal = document.getElementById('detailModal');
        const editModal = document.getElementById('editModal');
        
        if (detailModal && event.target === detailModal) {
            closeModal('detailModal');
        }
        if (editModal && event.target === editModal) {
            closeModal('editModal');
        }
    }

    // 전역 에러 핸들러
    window.addEventListener('error', function(event) {
        console.error('Global error:', event.error);
    });
    
    // Promise rejection 핸들러
    window.addEventListener('unhandledrejection', function(event) {
        console.error('Unhandled promise rejection:', event.reason);
    });
</script>
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
    </body>
    </html>