<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<script src="https://cdn.tailwindcss.com"></script>
<title>상품 상세정보</title>
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script>
    tailwind.config = {
        theme: {
            extend: {
                fontFamily: {
                    pretendard: ['Pretendard', 'sans-serif'],
                },
                colors: {
                    'main-color': {
                        DEFAULT: '#1f2937',
                        'hover': '#111827'
                    }
                }
            },
        },
    }
</script>
</head>
<body class="bg-gray-50 font-pretendard">

	<%@ include file="/WEB-INF/views/buyer/nav.jsp"%>

	<div class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 py-12">
		<h2 class="text-3xl font-bold text-gray-800 tracking-tight mb-8">상품 상세정보</h2>

		<c:if test="${not empty options}">
			<%-- 첫 번째 옵션만 사용해서 상품 정보 출력 --%>
			<c:set var="firstOption" value="${options[0]}" />

			<form action="${pageContext.request.contextPath}/mypage/cart/add"
				method="post" enctype="multipart/form-data">
				
				<!-- 상품 정보 섹션 - 새로운 레이아웃 -->
				<div class="bg-white rounded-lg shadow-md p-6 mb-8">
					<div class="flex flex-col md:flex-row gap-6">
						<!-- 상품 이미지 - 화면의 2/5 차지 -->
						<div class="w-full md:w-2/5">
							<div class="aspect-square bg-gray-50 rounded-lg overflow-hidden">
								<c:choose>
									<c:when test="${not empty firstOption.product.productPhoto}">
										<img
											src="${imagekitUrl}product/${firstOption.product.productPhoto}"
											alt="상품 사진" 
											class="w-full h-full object-cover"
											onerror="this.src='${pageContext.request.contextPath}/resources/images/no-image.png';" />
									</c:when>
									<c:otherwise>
										<img
											src="${pageContext.request.contextPath}/resources/images/no-image.png"
											alt="이미지 없음" 
											class="w-full h-full object-cover" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>

						<!-- 상품 정보 - 나머지 3/5 차지, 세로 정렬 -->
						<div class="w-full md:w-3/5 flex flex-col justify-between">
							<!-- 상품 기본 정보 -->
							<div class="space-y-4">
								<div>
									<h3 class="text-2xl font-bold text-gray-900 mb-2">
										${firstOption.product.productName}
									</h3>
									<p class="text-3xl font-bold text-gray-900">
										<fmt:formatNumber value="${firstOption.product.productPrice}" type="number" groupingUsed="true"/>원
									</p>
								</div>

								<div class="border-t pt-4">
									<p class="text-gray-700 leading-relaxed">
										${firstOption.product.productDetail}
									</p>
								</div>
							</div>

							<!-- 구매 옵션 -->
							<div class="space-y-4 mt-6">
								<!-- 사이즈 선택 -->
								<div>
									<label class="block text-sm font-semibold text-gray-700 mb-2">
										사이즈 선택
									</label>
									<select name="productSize" id="sizeSelect" 
											class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-gray-400" required>
										<c:forEach var="option" items="${options}">
											<option value="${option.size.sizeName}">
												${option.size.sizeName}
											</option>
										</c:forEach>
									</select>
								</div>

								<!-- 재고 및 수량 -->
								<div class="flex space-x-4">
									<div class="flex-1">
										<label class="block text-sm font-semibold text-gray-700 mb-2">
											재고
										</label>
										<div class="bg-gray-50 border border-gray-300 rounded-md px-3 py-2">
											<span id="stockDisplay">${firstOption.stock}</span>개
										</div>
									</div>
									<div class="flex-1">
										<label class="block text-sm font-semibold text-gray-700 mb-2">
											수량
										</label>
										<input type="number" name="count" min="1" value="1"
											class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-2 focus:ring-gray-400" required />
									</div>
								</div>

								<!-- 장바구니 버튼 -->
								<div class="pt-4">
									<input type="hidden" name="productId" value="${firstOption.product.productId}" />
									<button type="submit"
										class="w-full bg-main-color text-white py-3 px-6 rounded-md font-semibold hover:bg-main-color-hover transition duration-200">
										장바구니 담기
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>

			<!-- 리뷰 목록 출력 -->
			<div class="mt-8">
				<h3 class="text-xl font-bold mb-4">상품 리뷰</h3>

				<c:choose>
					<c:when test="${not empty reviews}">
						<div class="space-y-4">
							<c:forEach var="review" items="${reviews}">
								<div class="bg-white rounded-lg shadow-md p-6">
									<!-- 이름 + 작성일 -->
									<div class="flex justify-between items-center mb-3">
										<span class="font-semibold text-gray-900">${review.userName}</span>
										<span class="text-sm text-gray-500">
											<fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd" />
										</span>
									</div>
									
									<!-- 평점 -->
									<div class="mb-3">
										<div class="flex items-center">
											<c:forEach var="i" begin="1" end="${review.score}">
												<span class="text-yellow-400 text-lg">★</span>
											</c:forEach>
											<c:forEach var="i" begin="1" end="${5 - review.score}">
												<span class="text-gray-300 text-lg">☆</span>
											</c:forEach>
										</div>
									</div>
									
									<!-- 이미지 -->
									<c:if test="${not empty review.reviewImageUrl}">
										<div class="mb-4">
											<img src="${imagekitUrl}review/${review.reviewImageUrl}"
												alt="리뷰 이미지" 
												class="w-48 h-48 object-cover rounded-lg"
												onerror="this.style.display='none';" />
										</div>
									</c:if>
									
									<!-- 내용 -->
									<div class="mb-4">
										<p class="text-gray-700 leading-relaxed">${review.content}</p>
									</div>
									
									<!-- 삭제 및 수정 버튼 (리뷰 작성자만 보임) -->
									<c:if test="${review.userId eq sessionScope.loginUser.id}">
										<div class="flex gap-2 pt-2 border-t">
											<form
												action="${pageContext.request.contextPath}/mypage/product/review/delete"
												method="post"
												onsubmit="return confirm('리뷰를 삭제하시겠습니까?');"
												style="display: inline;">
												<input type="hidden" name="reviewId"
													value="${review.reviewId}" />
												<input type="hidden" name="productId"
													value="${firstOption.product.productId}">
												<button type="submit"
													class="flex items-center justify-center bg-red-500 text-white px-3 py-1 h-9 rounded text-sm hover:bg-red-600 transition duration-200" >삭제</button>
											</form>

											<button
												onclick="showEditForm('${review.reviewId}', '${review.score}', 
												'${fn:escapeXml(review.content)}', '${review.reviewImageUrl}')"
												class="flex items-center justify-center bg-gray-500 text-white px-3 py-1 h-9 rounded text-sm hover:bg-gray-600 transition duration-200">수정</button>
										</div>
									</c:if>
								</div>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<div class="bg-white rounded-lg shadow-md p-6">
							<p class="text-gray-600 text-center">작성된 리뷰가 없습니다.</p>
						</div>
					</c:otherwise>
				</c:choose>
			</div>

			<!-- 리뷰 수정 폼 (처음에는 숨김) -->
			<div id="editReviewForm" class="mt-8 hidden">
				<h3 class="text-xl font-bold mb-4">리뷰 수정</h3>
				<form
					action="${pageContext.request.contextPath}/mypage/product/review/update"
					method="post" enctype="multipart/form-data"
					class="bg-white p-6 rounded-lg shadow-md">

					<input type="hidden" name="reviewId" id="editReviewId" />
					<input type="hidden" name="productId" value="${firstOption.product.productId}" />

					<div class="mb-4">
						<label for="editScore" class="block font-semibold mb-2">평점</label>
						<select name="score" id="editScore" required
							class="border rounded px-3 py-2 w-full focus:outline-none focus:ring-2 focus:ring-gray-400">
							<option value="5">★★★★★</option>
							<option value="4">★★★★☆</option>
							<option value="3">★★★☆☆</option>
							<option value="2">★★☆☆☆</option>
							<option value="1">★☆☆☆☆</option>
						</select>
					</div>

					<div class="mb-4">
						<label for="editContent" class="block font-semibold mb-2">리뷰 내용</label>
						<textarea name="content" id="editContent" rows="4" required
							class="border rounded px-3 py-2 w-full focus:outline-none focus:ring-2 focus:ring-gray-400"></textarea>
					</div>

					<div class="mb-4">
						<label for="editImage" class="block font-semibold mb-2">이미지 변경 (선택)</label>
						<input type="file" name="reviewImage" id="editImage"
							accept="image/*" class="border rounded px-3 py-2 w-full" />
						<p class="text-sm text-gray-500 mt-1">새 이미지를 선택하면 기존 이미지가 교체됩니다.</p>
					</div>

					<div class="flex gap-2">
						<button type="submit"
							class="bg-main-color text-white px-4 py-2 rounded hover:bg-main-color-hover">
							리뷰 수정</button>
						<button type="button" onclick="hideEditForm()"
							class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">
							취소</button>
					</div>
				</form>
			</div>

			<%-- 사용자가 이미 리뷰를 작성했는지 확인 --%>
			<c:set var="alreadyReviewed" value="false" />
			<c:forEach var="review" items="${reviews}">
				<c:if test="${review.userId eq sessionScope.loginUser.id}">
					<c:set var="alreadyReviewed" value="true" />
				</c:if>
			</c:forEach>
			
			<c:if test="${canWriteReview}">
				<div class="mt-8">
					<h3 class="text-xl font-bold mb-4">리뷰 작성</h3>
					<form
						action="${pageContext.request.contextPath}/mypage/product/review"
						method="post" enctype="multipart/form-data"
						class="bg-white p-6 rounded-lg shadow-md">
						<input type="hidden" name="productId"
							value="${firstOption.product.productId}" />

						<div class="mb-4">
							<label for="score" class="block font-semibold mb-2">평점</label>
							<select name="score" id="score" required
								class="border rounded px-3 py-2 w-full focus:outline-none focus:ring-2 focus:ring-gray-400">
								<option value="">선택하세요</option>
								<option value="5">★★★★★</option>
								<option value="4">★★★★☆</option>
								<option value="3">★★★☆☆</option>
								<option value="2">★★☆☆☆</option>
								<option value="1">★☆☆☆☆</option>
							</select>
						</div>

						<div class="mb-4">
							<label for="content" class="block font-semibold mb-2">리뷰 내용</label>
							<textarea name="content" id="content" rows="4" required
								class="border rounded px-3 py-2 w-full focus:outline-none focus:ring-2 focus:ring-gray-400"
								placeholder="상품에 대한 리뷰를 작성해주세요."></textarea>
						</div>

						<div class="mb-4">
							<label for="reviewImage" class="block font-semibold mb-2">리뷰 이미지 (선택)</label>
							<input type="file" name="reviewImage"
								id="reviewImage" accept="image/*"
								class="border rounded px-3 py-2 w-full" />
							<p class="text-sm text-gray-500 mt-1">JPG, PNG, GIF 파일만 업로드 가능합니다.</p>
						</div>

						<button type="submit"
							class="bg-main-color text-white px-4 py-2 rounded font-semibold hover:bg-main-color-hover transition duration-200">
							리뷰 등록</button>
					</form>
				</div>
			</c:if>

			<%-- 로그인하지 않은 경우 안내 메시지 --%>
			<c:if test="${empty sessionScope.loginUser}">
				<div class="mt-8 bg-yellow-50 border border-yellow-200 rounded p-4">
					<p class="text-yellow-800">
						리뷰를 작성하려면 <a href="${pageContext.request.contextPath}/login"
							class="text-main-color underline font-semibold">로그인</a>해주세요.
					</p>
				</div>
			</c:if>
		</c:if>
	</div>

	<script>
		// 사이즈 선택에 따른 재고 변경
		const sizeSelect = document.getElementById("sizeSelect");
		const stockDisplay = document.getElementById("stockDisplay");

		const stockMap = {
			<c:forEach var="opt" items="${options}" varStatus="status">
				'${opt.size.sizeName}': '${opt.stock}'<c:if test="${!status.last}">,</c:if>
			</c:forEach>
		};

		sizeSelect.addEventListener("change", function () {
			const selectedSize = sizeSelect.value;
			stockDisplay.textContent = stockMap[selectedSize] || "0";
		});

		// 리뷰 수정 폼 표시
		function showEditForm(reviewId, score, content, imageUrl) {
			document.getElementById('editReviewId').value = reviewId;
			document.getElementById('editScore').value = score;
			document.getElementById('editContent').value = content;

			const form = document.getElementById('editReviewForm');
			form.classList.remove('hidden');
			form.scrollIntoView({ behavior: 'smooth' });
		}

		// 리뷰 수정 폼 숨기기
		function hideEditForm() {
			const form = document.getElementById('editReviewForm');
			form.classList.add('hidden');
		}

		// 이미지 로드 실패 시 처리
		function handleImageError(img) {
			img.style.display = 'none';
			const parent = img.parentElement;
			if (!parent.querySelector('.no-image-text')) {
				const noImageText = document.createElement('span');
				noImageText.className = 'no-image-text text-gray-400 text-sm';
				noImageText.textContent = '이미지 없음';
				parent.appendChild(noImageText);
			}
		}
	</script>
</body>
</html>