<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<html>
<head>
<script src="https://cdn.tailwindcss.com"></script>

<title>상품 상세정보</title>
</head>
<body class="bg-gray-100 text-gray-900">

	<%@ include file="/WEB-INF/views/buyer/nav.jsp"%>

	<div class="container mx-auto px-4 py-6">
		<h2 class="text-2xl font-bold mb-6">상품 상세정보</h2>

		<table
			class="min-w-full table-auto bg-white border border-gray-300 mb-6">

			<tbody>
				<c:if test="${not empty options}">
					<%-- 첫 번째 옵션만 사용해서 상품 정보 출력 --%>
					<c:set var="firstOption" value="${options[0]}" />

					<form action="${pageContext.request.contextPath}/mypage/cart/add"
						method="post" enctype="multipart/form-data" class="text-center">
						<table
							class="min-w-full table-auto bg-white border border-gray-300 mb-6">
							<thead class="bg-gray-200">
								<tr>
									<th class="px-4 py-2 border">상품명</th>
									<th class="px-4 py-2 border">가격</th>
									<th class="px-4 py-2 border">사이즈 선택</th>
									<th class="px-4 py-2 border">재고</th>
									<th class="px-4 py-2 border">수량</th>
									<th class="px-4 py-2 border">상세 설명</th>
									<th class="px-4 py-2 border">사진</th>
									<th class="px-4 py-2 border">장바구니</th>
								</tr>
							</thead>
							<tbody>
								<tr class="text-center">
									<td class="border px-4 py-2">${firstOption.product.productName}</td>
									<td class="border px-4 py-2">${firstOption.product.productPrice}원</td>

									<%-- 사이즈 셀렉트 박스 --%>
									<td class="border px-4 py-2"><select name="productSize"
										id="sizeSelect" class="border rounded px-2 py-1" required>
											<c:forEach var="option" items="${options}">
												<option value="${option.size.sizeName}">
													${option.size.sizeName}</option>
											</c:forEach>
									</select></td>

									<%-- 재고 표시 --%>
									<td class="border px-4 py-2" id="stockDisplay">${firstOption.stock}</td>

									<%-- 수량 입력 추가 --%>
									<td class="border px-4 py-2"><input type="number"
										name="count" min="1" value="1"
										class="border rounded px-2 py-1 w-20" required /></td>

									<td class="border px-4 py-2">${firstOption.product.productDetail}</td>
									<td class="border px-4 py-2"><img
										src="${pageContext.request.contextPath}/resources/upload/${firstOption.product.productPhoto}"
										alt="상품 사진" style="width: 100px;" /></td>

									<%-- 장바구니 담기 버튼 --%>
									<td class="border px-4 py-2"><input type="hidden"
										name="productId" value="${firstOption.product.productId}" />
										<button type="submit"
											class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
											장바구니 담기</button></td>
								</tr>
							</tbody>
						</table>
					</form>
					<!-- 리뷰 목록 출력 -->
					<div class="mt-8">
						<h3 class="text-xl font-bold mb-4">상품 리뷰</h3>

						<c:choose>
							<c:when test="${not empty reviews}">
								<table
									class="min-w-full table-auto bg-white border border-gray-300">
									<thead class="bg-gray-200">
										<tr>
											<th class="px-4 py-2 border">작성자</th>
											<th class="px-4 py-2 border">평점</th>
											<th class="px-4 py-2 border">내용</th>
											<th class="px-4 py-2 border">이미지</th>
											<th class="px-4 py-2 border">작성일</th>

										</tr>
									</thead>
									<tbody>
										<c:forEach var="review" items="${reviews}">
											<tr class="text-center">
												<td class="border px-4 py-2">${review.userId}</td>
												<td class="border px-4 py-2"><c:forEach var="i"
														begin="1" end="${review.score}">
												        ★
												    </c:forEach> <c:forEach var="i" begin="1" end="${5 - review.score}">
												        ☆
												    </c:forEach></td>
												<td class="border px-4 py-2">${review.content}</td>
												<td class="border px-4 py-2"><img
													src="${pageContext.request.contextPath}/resources/upload/review/${review.reviewImageUrl}"
													alt="리뷰 이미지" style="width: 200px;" /></td>
												<td class="border px-4 py-2"><fmt:formatDate
														value="${review.reviewDate}" pattern="yyyy-MM-dd" /></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</c:when>
							<c:otherwise>
								<p class="text-gray-600">작성된 리뷰가 없습니다.</p>
							</c:otherwise>
						</c:choose>
					</div>



					<c:set var="alreadyReviewed" value="false" />
					<c:forEach var="review" items="${reviews}">
						<c:if test="${review.userId eq sessionScope.loginUser.id}">
							<c:set var="alreadyReviewed" value="true" />
						</c:if>
					</c:forEach>
					<!-- 리뷰 작성 폼 출력 조건문 -->
					<c:if test="${not alreadyReviewed}">
						<div class="mt-8">
							<h3 class="text-xl font-bold mb-4">리뷰 작성</h3>
							<form
								action="${pageContext.request.contextPath}/mypage/product/review"
								method="post" enctype="multipart/form-data"
								class="bg-white p-6 rounded shadow-md">
								<input type="hidden" name="productId"
									value="${firstOption.product.productId}" />

								<div class="mb-4">
									<label for="score" class="block font-semibold mb-2">평점</label>
									<select name="score" id="score" required
										class="border rounded px-3 py-2 w-full">
										<option value="">선택하세요</option>
										<option value="5">★★★★★</option>
										<option value="4">★★★★☆</option>
										<option value="3">★★★☆☆</option>
										<option value="2">★★☆☆☆</option>
										<option value="1">★☆☆☆☆</option>
									</select>
								</div>

								<div class="mb-4">
									<label for="content" class="block font-semibold mb-2">리뷰
										내용</label>
									<textarea name="content" id="content" rows="4" required
										class="border rounded px-3 py-2 w-full"></textarea>
								</div>
								<div class="mb-4">
									<label for="reviewImage" class="block font-semibold mb-2">리뷰
										이미지</label> <input type="file" name="reviewImage" id="reviewImage"
										accept="image/*" class="border rounded px-3 py-2 w-full" />
								</div>
								<button type="submit"
									class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">
									리뷰 등록</button>
							</form>
						</div>
					</c:if>
				</c:if>
			</tbody>
		</table>

	</div>
	<script>
	    const sizeSelect = document.getElementById("sizeSelect");
	    const stockDisplay = document.getElementById("stockDisplay");
	
	    const stockMap = {
	        <c:forEach var="opt" items="${options}">
	            '${opt.size.sizeName}': '${opt.stock}',
	        </c:forEach>
	    };
	
	    sizeSelect.addEventListener("change", function () {
	        const selectedSize = sizeSelect.value;
	        stockDisplay.textContent = stockMap[selectedSize] || "0";
	    });

	</script>


</body>
</html>
