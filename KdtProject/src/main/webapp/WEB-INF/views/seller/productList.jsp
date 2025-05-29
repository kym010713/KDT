<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>상품 관리</title>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .btn { padding: 8px 16px; margin: 5px; background: #007bff; color: white; text-decoration: none; border-radius: 4px; }
        .btn:hover { background: #0056b3; }
        .btn-danger { background: #dc3545; }
        .btn-danger:hover { background: #c82333; }
        .btn-success { background: #28a745; }
        .btn-success:hover { background: #218838; }
        .product-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .product-table th, .product-table td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        .product-table th { background-color: #f8f9fa; font-weight: bold; }
        .product-table tr:nth-child(even) { background-color: #f9f9f9; }
        .detail-row { background-color: #f0f8ff !important; }
        .detail-form { margin: 10px 0; padding: 15px; background: #f8f9fa; border-radius: 5px; }
        .detail-form input, .detail-form select, .detail-form textarea { margin: 5px; padding: 5px; }
        .form-group { margin: 10px 0; }
        .form-group label { display: inline-block; width: 100px; font-weight: bold; }
        .message { padding: 10px; margin: 10px 0; border-radius: 4px; }
        .message.success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .message.error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .toggle-btn { background: #6c757d; color: white; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer; }
        .toggle-btn:hover { background: #545b62; }
    </style>
    <script>
        function toggleDetails(productName) {
            var row = document.getElementById('details-' + productName);
            if (row.style.display === 'none' || row.style.display === '') {
                row.style.display = 'table-row';
            } else {
                row.style.display = 'none';
            }
        }
        
        function confirmDelete(productId) {
            return confirm('상품 ID: ' + productId + '를 삭제하시겠습니까?');
        }
        
        function submitDetailForm(productName) {
            document.getElementById('detailForm-' + productName).submit();
        }
    </script>
</head>
<body>
    <div class="header">
        <h2>상품 관리</h2>
        <div>
            <a href="/seller/productInsert" class="btn">새 상품 등록</a>
        </div>
    </div>
    
    <!-- 메시지 표시 -->
    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>
    
    <c:if test="${not empty message}">
        <div class="message success">${message}</div>
    </c:if>
    
    <c:choose>
        <c:when test="${empty products}">
            <div class="message">등록된 상품이 없습니다.</div>
        </c:when>
        <c:otherwise>
            <table class="product-table">
                <thead>
                    <tr>
                        <th>상품 ID</th>
                        <th>카테고리</th>
                        <th>상품명</th>
                        <th>제조사</th>
                        <th>이미지 URL</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr>
                            <td>${product.productId}</td>
                            <td>${product.category}</td>
                            <td><strong>${product.productName}</strong></td>
                            <td>${product.companyName}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty product.productPhoto}">
                                        <a href="${product.productPhoto}" target="_blank">이미지 보기</a>
                                    </c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="/seller/productEdit?productId=${product.productId}" class="btn">수정</a>
                                <button type="button" class="toggle-btn" onclick="toggleDetails('${product.productName}')">상세정보</button>
                                <form method="post" action="/seller/productDelete" style="display:inline;" 
                                      onsubmit="return confirmDelete('${product.productId}');">
                                    <input type="hidden" name="productId" value="${product.productId}">
                                    <input type="submit" value="삭제" class="btn btn-danger">
                                </form>
                            </td>
                        </tr>
                        
                        <!-- 상품 상세 정보 행 (토글) -->
                        <tr id="details-${product.productName}" class="detail-row" style="display: none;">
                            <td colspan="6">
                                <div class="detail-form">
                                    <h4>${product.productName} 상세 정보</h4>
                                    
                                    <!-- 기존 상세 정보가 있으면 표시 -->
                                    <c:set var="hasDetail" value="false" />
                                    <c:forEach var="detail" items="${details}">
                                        <c:if test="${detail.productName == product.productName}">
                                            <c:set var="hasDetail" value="true" />
                                            <form id="detailUpdateForm-${product.productName}" method="post" action="/seller/productDetailUpdate">
                                                <input type="hidden" name="productName" value="${product.productName}">
                                                <input type="hidden" name="originalProductPhoto" value="${detail.productPhoto}">
                                                
                                                <div class="form-group">
                                                    <label>재고:</label>
                                                    <input type="number" name="productCount" value="${detail.productCount}" min="0" required>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label>가격:</label>
                                                    <input type="text" name="productPrice" value="${detail.productPrice}" required>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label>사이즈:</label>
                                                    <select name="productSize" required>
                                                        <option value="XS" ${detail.productSize == 'XS' ? 'selected' : ''}>XS</option>
                                                        <option value="S" ${detail.productSize == 'S' ? 'selected' : ''}>S</option>
                                                        <option value="M" ${detail.productSize == 'M' ? 'selected' : ''}>M</option>
                                                        <option value="L" ${detail.productSize == 'L' ? 'selected' : ''}>L</option>
                                                        <option value="XL" ${detail.productSize == 'XL' ? 'selected' : ''}>XL</option>
                                                        <option value="XXL" ${detail.productSize == 'XXL' ? 'selected' : ''}>XXL</option>
                                                        <option value="FREE" ${detail.productSize == 'FREE' ? 'selected' : ''}>FREE</option>
                                                    </select>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label>상세설명:</label><br>
                                                    <textarea name="productDetail" rows="3" cols="60" required>${detail.productDetail}</textarea>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <input type="submit" value="상세정보 수정" class="btn btn-success">
                                                </div>
                                            </form>
                                        </c:if>
                                    </c:forEach>
                                    
                                    <!-- 상세 정보가 없으면 등록 폼 표시 -->
                                    <c:if test="${!hasDetail}">
                                        <form id="detailForm-${product.productName}" method="post" action="/seller/productDetailInsert">
                                            <input type="hidden" name="productName" value="${product.productName}">
                                            <input type="hidden" name="productPhoto" value="">
                                            
                                            <div class="form-group">
                                                <label>재고:</label>
                                                <input type="number" name="productCount" min="0" >
                                            </div>
                                            
                                            <div class="form-group">
                                                <label>가격:</label>
                                                <input type="text" name="productPrice">
                                            </div>
                                            
                                            <div class="form-group">
                                                <label>사이즈:</label>
                                                <select name="productSize" required>
                                                    <option value="">사이즈 선택</option>
                                                    <option value="XS">XS</option>
                                                    <option value="S">S</option>
                                                    <option value="M">M</option>
                                                    <option value="L">L</option>
                                                    <option value="XL">XL</option>
                                                    <option value="XXL">XXL</option>
                                                    <option value="FREE">FREE</option>
                                                </select>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label>상세설명:</label><br>
                                                <textarea name="productDetail" rows="3" cols="60" ></textarea>
                                            </div>
                                            
                                            <div class="form-group">
                                                <input type="submit" value="상세정보 등록" class="btn btn-success">
                                            </div>
                                        </form>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
    
</body>
</html>