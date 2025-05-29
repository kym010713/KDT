<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록 - 판매자</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        button, .btn { background-color: #007bff; color: white; padding: 5px 10px; border: none; cursor: pointer; text-decoration: none; margin: 2px; }
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); }
        .modal-content { background-color: white; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 50%; }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer; }
    </style>
</head>
<body>
    <h2>상품 목록</h2>
    <a href="/seller/register" class="btn">새 상품 등록</a>
    <br><br>
    
    <!-- 필터 섹션 -->
    <form method="get" action="/seller/list">
        <label for="category">카테고리:</label>
        <select name="category" id="category" onchange="this.form.submit()">
            <option value="">전체</option>
            <c:forEach items="${categories}" var="category">
                <option value="${category.topName}" 
                        <c:if test="${selectedCategory eq category.topName}">selected</c:if>>
                    ${category.topName}
                </option>
            </c:forEach>
        </select>
        <c:if test="${not empty selectedCategory}">
            <a href="/seller/list" class="btn">초기화</a>
        </c:if>
    </form>
    <br>
    
    <!-- 상품 목록 -->
    <c:choose>
        <c:when test="${empty products}">
            <p>등록된 상품이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>카테고리</th>
                        <th>상품명</th>
                        <th>제조사</th>
                        <th>상품ID</th>
                        <th>액션</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${products}" var="product">
                        <tr>
                            <td>${product.category}</td>
                            <td>${product.productName}</td>
                            <td>${product.companyName}</td>
                            <td>${product.productId}</td>
                            <td>
                                <button onclick="showProductDetail('${product.productName}')">상세보기</button>
                                <button class="btn-warning">수정</button>
                                <button class="btn-danger" onclick="deleteProduct('${product.productId}')">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
    
    <div id="detailModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h3>상품 상세 정보</h3>
            <div id="detailContent"></div>
        </div>
    </div>
    
    <script>
        function showProductDetail(productName) {
            fetch('/seller/product/detail/' + encodeURIComponent(productName))
                .then(response => response.json())
                .then(data => {
                    if (data) {
                        document.getElementById('detailContent').innerHTML = 
                            '<p><strong>상품명:</strong> ' + data.productName + '</p>' +
                            '<p><strong>설명:</strong> ' + data.productDetail + '</p>' +
                            '<p><strong>가격:</strong> ' + data.productPrice + '원</p>' +
                            '<p><strong>사이즈:</strong> ' + data.productSize + '</p>' +
                            '<p><strong>재고:</strong> ' + data.productCount + '개</p>';
                        document.getElementById('detailModal').style.display = 'block';
                    } else {
                        alert('상품 정보를 불러올 수 없습니다.');
                    }
                })
                .catch(error => alert('오류가 발생했습니다: ' + error.message));
        }
        
        function closeModal() {
            document.getElementById('detailModal').style.display = 'none';
        }
        
        function deleteProduct(productId) {
            if (confirm('정말로 이 상품을 삭제하시겠습니까?')) {
                alert('삭제 기능은 아직 구현되지 않았습니다.');
            }
        }
        
        window.onclick = function(event) {
            const modal = document.getElementById('detailModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</body>
</html>