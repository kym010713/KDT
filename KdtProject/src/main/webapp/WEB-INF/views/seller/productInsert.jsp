<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>상품 등록</title>
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
        .message { padding: 10px; margin: 10px 0; border-radius: 4px; }
        .message.success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .message.error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .form-actions { margin-top: 20px; text-align: center; }
    </style>
</head>
<body>
    <div class="header">
        <h2>상품 등록</h2>
        <a href="/seller/productList" class="btn btn-secondary">상품 목록</a>
    </div>
    
    <!-- 메시지 표시 -->
    <% if (request.getAttribute("message") != null) { %>
        <div class="message <%= request.getAttribute("isSuccess") != null && (Boolean)request.getAttribute("isSuccess") ? "success" : "error" %>">
            <%= request.getAttribute("message") %>
        </div>
    <% } %>
    
    <form method="post" action="/seller/productInsert">
        <div class="form-group">
            <label for="category">카테고리</label>
            <select id="category" name="category" required>
                <option value="">카테고리를 선택하세요</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category}">${category}</option>
                </c:forEach>
                <!-- 카테고리 데이터가 없을 경우 기본값 -->
                <c:if test="${empty categories}">
                    <option value="상의">상의</option>
                    <option value="하의">하의</option>
                    <option value="아우터">아우터</option>
                    <option value="신발">신발</option>
                    <option value="액세서리">액세서리</option>
                </c:if>
            </select>
        </div>
        
        <div class="form-group">
            <label for="productId">상품 ID</label>
            <input type="text" id="productId" name="productId" required placeholder="고유한 상품 ID를 입력하세요">
        </div>
        
        <div class="form-group">
            <label for="productName">상품명</label>
            <input type="text" id="productName" name="productName" required placeholder="상품명을 입력하세요">
        </div>
        
        <div class="form-group">
            <label for="companyName">제조사명</label>
            <input type="text" id="companyName" name="companyName" required placeholder="제조사명을 입력하세요">
        </div>
        
        <div class="form-group">
            <label for="productPhoto">상품 이미지 URL</label>
            <input type="text" id="productPhoto" name="productPhoto" placeholder="상품 이미지 URL을 입력하세요">
        </div>
        
        <div class="form-actions">
            <input type="submit" value="상품 등록" class="btn">
            <input type="button" value="취소" class="btn btn-secondary" onclick="location.href='/seller/productList'">
        </div>
    </form>
    
    
</body>
</html>