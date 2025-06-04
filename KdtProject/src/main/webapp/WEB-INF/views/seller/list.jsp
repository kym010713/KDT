<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록 - 판매자</title>
    <style>
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
    </style>
</head>
<body>
    <h2>상품 목록</h2>
    <a href="/seller/register">새 상품 등록</a><br><br>
    <a href="/seller/delivery">배송 관리</a> |
    <a href="/seller/sales">판매 내역</a>
    <br><br>
    
    카테고리:
    <form method="get" action="/seller/list">
        <select name="category" onchange="this.form.submit()">
            <option value="">전체</option>
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
    <br>
    
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
    
    <div id="detailModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('detailModal')">&times;</span>
            <h3>상품 상세 정보</h3>
            <div id="detailContent"></div>
        </div>
    </div>
    
    <!-- 수정 모달 -->
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
                    <input type="text" id="editCompanyName" name="companyName" required>
                </div>
                <div class="form-group">
                    <label for="editProductDetail">상품 설명:</label>
                    <textarea id="editProductDetail" name="productDetail" required></textarea>
                </div>
                <div class="form-group">
                    <label for="editProductPrice">가격:</label>
                    <input type="text" id="editProductPrice" name="productPrice" required>
                </div>
                
                <!-- 사이즈별 재고 입력 영역 -->
                <div class="form-group">
                    <label>사이즈별 재고:</label>
                    <div id="sizeStockContainer">
                        <!-- JavaScript로 동적 생성 -->
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="editProductPhoto">사진 URL:</label>
                    <input type="text" id="editProductPhoto" name="productPhoto">
                </div>
                <div class="form-group">
                    <button type="button" onclick="updateProduct()">수정 완료</button>
                    <button type="button" onclick="closeModal('editModal')">취소</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
        let currentEditProductId = null;
        
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
        
        function editProduct(productId) {
            currentEditProductId = productId;
            clearAlert();
            
            fetch('/seller/product/edit/' + productId)
                .then(response => response.json())
                .then(responseData => {
                    if (responseData.success && responseData.data) {
                        const data = responseData.data;
                        document.getElementById('editCategory').value = data.category || '';
                        document.getElementById('editProductName').value = data.productName || '';
                        document.getElementById('editCompanyName').value = data.companyName || '';
                        document.getElementById('editProductDetail').value = data.productDetail || '';
                        document.getElementById('editProductPrice').value = data.productPrice || '';
                        document.getElementById('editProductPhoto').value = data.productPhoto || '';
                        
                       
                        generateSizeStockInputs(data.productOptions || []);
                        
                        document.getElementById('editModal').style.display = 'block';
                    } else {
                        alert('상품 정보를 불러올 수 없습니다: ' + (responseData.message || '알 수 없는 오류'));
                    }
                })
                .catch(error => alert('오류가 발생했습니다: ' + error.message));
        }
        
        function generateSizeStockInputs(productOptions) {
            const container = document.getElementById('sizeStockContainer');
            container.innerHTML = '';
            
            productOptions.forEach(option => {
                const div = document.createElement('div');
                div.style.marginBottom = '5px';
                div.innerHTML = 
                    '<label style="display: inline-block; width: 80px;">' + option.sizeName + ':</label>' +
                    '<input type="number" min="0" value="' + (option.stock || 0) + '" ' +
                           'name="stock_' + option.sizeId + '" style="width: 80px;"> 개';
                container.appendChild(div);
            });
        }
        
        function updateProduct() {
            if (!currentEditProductId) return;
            
            // 사이즈별 재고 데이터 수집
            const sizeStockInputs = document.querySelectorAll('#sizeStockContainer input[name^="stock_"]');
            const productOptions = [];
            
            sizeStockInputs.forEach(input => {
                const sizeId = input.name.split('_')[1];
                const stock = parseInt(input.value) || 0;
                if (stock > 0) {
                    productOptions.push({
                        sizeId: parseInt(sizeId),
                        stock: stock
                    });
                }
            });
            
            const formData = {
                category: document.getElementById('editCategory').value,
                productName: document.getElementById('editProductName').value,
                companyName: document.getElementById('editCompanyName').value,
                productDetail: document.getElementById('editProductDetail').value,
                productPrice: document.getElementById('editProductPrice').value,
                productPhoto: document.getElementById('editProductPhoto').value,
                productOptions: productOptions
            };
            
            fetch('/seller/product/update/' + currentEditProductId, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            })
            .then(response => response.json())
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
                showAlert('error', '오류가 발생했습니다: ' + error.message);
            });
        }
        
        function showAlert(type, message) {
            const alertContainer = document.getElementById('alertContainer');
            const color = type === 'success' ? 'green' : 'red';
            alertContainer.innerHTML = '<div style="color: ' + color + ';">' + message + '</div>';
        }
        
        function clearAlert() {
            document.getElementById('alertContainer').innerHTML = '';
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
            if (modalId === 'editModal') {
                currentEditProductId = null;
                clearAlert();
            }
        }
        
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