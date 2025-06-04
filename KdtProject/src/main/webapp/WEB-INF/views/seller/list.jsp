<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    </style>
</head>
<body>
    <h2>상품 목록</h2>
    <a href="/seller/register">새 상품 등록</a>
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
                    <th>상품ID</th>
                    <th>액션</th>
                </tr>
                <c:forEach items="${products}" var="product">
                    <tr>
                        <td>${product.category}</td>
                        <td>${product.productName}</td>
                        <td>${product.companyName}</td>
                        <td>${product.productId}</td>
                        <td>
                            <button onclick="showProductDetail('${product.productId}')">상세보기</button>
                            <button onclick="editProduct('${product.productId}')">수정</button>
                            <button onclick="deleteProduct('${product.productId}')">삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
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
                <div class="form-group">
                    <label for="editProductSize">사이즈:</label>
                    <select id="editProductSize" name="productSize" required>
                        <option value="">사이즈를 선택하세요</option>
                        <option value="Free">Free</option>
                        <option value="XS">XS</option>
                        <option value="S">S</option>
                        <option value="M">M</option>
                        <option value="L">L</option>
                        <option value="XL">XL</option>
                        <option value="XXL">XXL</option>
                        <option value="220mm">220mm</option>
                        <option value="230mm">230mm</option>
                        <option value="240mm">240mm</option>
                        <option value="250mm">250mm</option>
                        <option value="260mm">260mm</option>
                        <option value="270mm">270mm</option>
                        <option value="280mm">280mm</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="editProductCount">수량:</label>
                    <input type="number" id="editProductCount" name="productCount" min="1" required>
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
        
        function showProductDetail(productId) {
            fetch('/seller/product/detail/' + encodeURIComponent(productId))
                .then(response => response.json())
                .then(data => {
                    if (data) {
                        document.getElementById('detailContent').innerHTML = 
                            '<p><strong>상품명:</strong> ' + (data.productName || '') + '</p>' +
                            '<p><strong>설명:</strong> ' + (data.productDetail || '') + '</p>' +
                            '<p><strong>가격:</strong> ' + (data.productPrice || '') + '원</p>' +
                            '<p><strong>사이즈:</strong> ' + (data.productSize || '') + '</p>' +
                            '<p><strong>재고:</strong> ' + (data.productCount || 0) + '개</p>';
                        document.getElementById('detailModal').style.display = 'block';
                    } else {
                        alert('상품 정보를 불러올 수 없습니다.');
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
                        document.getElementById('editProductSize').value = data.productSize || '';
                        document.getElementById('editProductCount').value = data.productCount || '';
                        document.getElementById('editProductPhoto').value = data.productPhoto || '';
                        
                        document.getElementById('editModal').style.display = 'block';
                    } else {
                        alert('상품 정보를 불러올 수 없습니다: ' + (responseData.message || '알 수 없는 오류'));
                    }
                })
                .catch(error => alert('오류가 발생했습니다: ' + error.message));
        }
        
        function updateProduct() {
            if (!currentEditProductId) return;
            
            const formData = {
                category: document.getElementById('editCategory').value,
                productName: document.getElementById('editProductName').value,
                companyName: document.getElementById('editCompanyName').value,
                productDetail: document.getElementById('editProductDetail').value,
                productPrice: document.getElementById('editProductPrice').value,
                productSize: document.getElementById('editProductSize').value,
                productCount: parseInt(document.getElementById('editProductCount').value),
                productPhoto: document.getElementById('editProductPhoto').value
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