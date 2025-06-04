<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 등록 - 판매자</title>
    <style>
        .error { color: red; }
        .success { color: green; }
        .error-message { color: red; }
    </style>
</head>
<body>
    <h2>상품 등록</h2>
    <a href="/seller/list">상품 목록으로 돌아가기</a><br><br>
    
    <!-- 성공 메시지 -->
    <c:if test="${not empty successMessage}">
        <div class="success">${successMessage}</div>
    </c:if>
    
    <!-- 에러 메시지 -->
    <c:if test="${not empty errorMessage}">
        <div class="error-message">${errorMessage}</div>
    </c:if>
    
    <form:form method="post" modelAttribute="productDto" action="/seller/register">
            
            <!-- 카테고리 선택 -->
            <div class="form-group">
                <label for="category">카테고리 *</label>
                <form:select path="category" id="category">
                    <form:option value="">카테고리를 선택하세요</form:option>
                    <c:forEach items="${categories}" var="category">
                        <form:option value="${category.topName}">${category.topName}</form:option>
                    </c:forEach>
                </form:select>
                <form:errors path="category" cssClass="error" />
            </div>
            
            <!-- 상품명 -->
            <div class="form-group">
                <label for="productName">상품명 *</label>
                <form:input path="productName" id="productName" placeholder="상품명을 입력하세요" />
                <form:errors path="productName" cssClass="error" />
            </div>
            
            <!-- 제조사 -->
            <div class="form-group">
                <label for="companyName">제조사 *</label>
                <form:input path="companyName" id="companyName" placeholder="제조사를 입력하세요" />
                <form:errors path="companyName" cssClass="error" />
            </div>
            
            <!-- 상품 설명 -->
            <div class="form-group">
                <label for="productDetail">상품 설명 *</label>
                <form:textarea path="productDetail" id="productDetail" placeholder="상품 설명을 입력하세요" />
                <form:errors path="productDetail" cssClass="error" />
            </div>
            
            <!-- 상품 가격 -->
            <div class="form-group">
                <label for="productPrice">상품 가격 *</label>
                <form:input path="productPrice" id="productPrice" placeholder="예: 29000" />
                <form:errors path="productPrice" cssClass="error" />
            </div>
            
            <!-- 상품 사이즈 -->
            <div class="form-group">
                <label for="productSize">상품 사이즈 *</label>
                <form:select path="productSize" id="productSize">
                    <form:option value="">사이즈를 선택하세요</form:option>
                    <form:option value="Free">Free</form:option>
                    <form:option value="XS">XS</form:option>
                    <form:option value="S">S</form:option>
                    <form:option value="M">M</form:option>
                    <form:option value="L">L</form:option>
                    <form:option value="XL">XL</form:option>
                    <form:option value="XXL">XXL</form:option>        
                    <form:option value="220mm">220mm</form:option>
                    <form:option value="230mm">230mm</form:option>
                    <form:option value="240mm">240mm</form:option>
                    <form:option value="250mm">250mm</form:option>
                    <form:option value="260mm">260mm</form:option>
                    <form:option value="270mm">270mm</form:option>
                    <form:option value="280mm">280mm</form:option>
                </form:select>
                <form:errors path="productSize" cssClass="error" />
            </div>
            
            <!-- 상품 수량 -->
            <div class="form-group">
                <label for="productCount">상품 수량 *</label>
                <form:input path="productCount" type="number" id="productCount" min="1" placeholder="상품 수량을 입력하세요" />
                <form:errors path="productCount" cssClass="error" />
            </div>
            
            <!-- 상품 사진 URL (일단 텍스트로) -->
            <div class="form-group">
                <label for="productPhoto">상품 사진 URL</label>
                <form:input path="productPhoto" id="productPhoto" placeholder="상품 사진 URL을 입력하세요 (선택사항)" />
                <form:errors path="productPhoto" cssClass="error" />
            </div>
            
            <!-- 등록 버튼 -->
            <div class="form-group">
                <button type="submit" class="btn">상품 등록</button>
            </div>
            
        </form:form>
    </div>
</body>
</html>