<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 등록 - 판매자</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input, select, textarea, button { padding: 8px; margin-bottom: 5px; }
        input[type="text"], input[type="number"], select, textarea { width: 300px; }
        button { background-color: #007bff; color: white; border: none; cursor: pointer; }
        .error { color: red; font-size: 14px; }
        .success { color: green; background-color: #d4edda; padding: 10px; margin-bottom: 10px; }
        .error-message { color: red; background-color: #f8d7da; padding: 10px; margin-bottom: 10px; }
    </style>
</head>
<body>
    <h2>상품 등록</h2>
    
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
                <form:input path="productSize" id="productSize" placeholder="예: S, M, L, XL 또는 Free" />
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