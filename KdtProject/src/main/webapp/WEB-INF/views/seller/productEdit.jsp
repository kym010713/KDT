<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>상품 수정</title>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; max-width: 600px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .btn { padding: 8px 16px; margin: 5px; background: #007bff; color: white; text-decoration: none; border-radius: 4px; border: none; cursor: pointer; }
        .btn:hover { background: #0056b3; }
        .btn-secondary { background: #6c757d; }
        .btn-secondary:hover { background: #545b62; }
        .form-group { margin: 15px 0; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input, .form-group select { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .form-group select { height: 40px; }
        .product-id { background: #e9ecef; color: #495057; font-weight: bold; padding: 10px; border-radius: 4px; margin-bottom: 15px; }
        .message { padding: 10px; margin: 10px 0; border-radius: 4px; }
        .message.success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .message.error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .form-actions { margin-top: 20px; text-align: center; }
        .preview { margin-top: 10px; padding: 10px; background: #f8f9fa; border-radius: 4px; }
    </style>
    <script>
        function previewImage() {
            var url = document.getElementById('productPhoto').value;
            var preview = document.getElementById('imagePreview');
            if (url) {
                preview.innerHTML = '<img src="' + url + '" style="max-width: 200px; max-height: 200px;" onerror="this.src=\'\'; this.style.display=\'none\'; this.parentNode.innerHTML=\'이미지를 불러올 수 없습니다.\';">';
            } else {
                preview.innerHTML = '';
            }
        }
    </script>
</head>
<body>
    <div class="header">
        <h2>상품 수정</h2>
        <a href="/seller/productList" class="btn btn-secondary">상품 목록</a>
    </div>
    
    <!-- 메시지 표시 -->
    <c:if test="${not empty message}">
        <div class="message ${isSuccess ? 'success' : 'error'}">
            ${message}
        </div>
    </c:if>
    
    <div class="product-id">
        수정 중인 상품 ID: ${product.productId}
    </div>
    
    <form method="post" action="/seller/productEdit">
        <input type="hidden" name="productId" value="${product.productId}">
        
        <div class="form-group">
            <label for="category">카테고리</label>
            <select id="category" name="category" required>
                <option value="">카테고리를 선택하세요</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category}" ${product.category == category ? 'selected' : ''}>${category}</option>
                </c:forEach>
                <!-- 카테고리 데이터가 없을 경우 기본값 -->
                <c:if test="${empty categories}">
                    <option value="상의" ${product.category == '상의' ? 'selected' : ''}>상의</option>
                    <option value="하의" ${product.category == '하의' ? 'selected' : ''}>하의</option>
                    <option value="아우터" ${product.category == '아우터' ? 'selected' : ''}>아우터</option>
                    <option value="신발" ${product.category == '신발' ? 'selected' : ''}>신발</option>
                    <option value="액세서리" ${product.category == '액세서리' ? 'selected' : ''}>액세서리</option>
                </c:if>
            </select>
        </div>
        
        <div class="form-group">
            <label for="productName">상품명</label>
            <input type="text" id="productName" name="productName" value="${product.productName}" required>
        </div>
        
        <div class="form-group">
            <label for="companyName">제조사명</label>
            <input type="text" id="companyName" name="companyName" value="${product.companyName}" required>
        </div>
        
        <div class="form-group">
            <label for="productPhoto">상품 이미지 URL</label>
            <input type="text" id="productPhoto" name="productPhoto" value="${product.productPhoto}" 
                   placeholder="상품 이미지 URL을 입력하세요 " onblur="previewImage()">
            <div id="imagePreview" class="preview">
                <c:if test="${not empty product.productPhoto}">
                    <img src="${product.productPhoto}" style="max-width: 200px; max-height: 200px;" 
                         onerror="this.style.display='none'; this.parentNode.innerHTML='이미지를 불러올 수 없습니다.';">
                </c:if>
            </div>
        </div>
        
        <div class="form-actions">
            <input type="submit" value="수정 완료" class="btn">
            <input type="button" value="취소" class="btn btn-secondary" onclick="location.href='/seller/productList'">
        </div>
    </form>
    
    
</body>
</html>