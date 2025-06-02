<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>
<script src="https://cdn.tailwindcss.com"></script>
<title>상품 상세정보</title>
</head>
<body class="bg-gray-100 text-gray-900">

	<%@ include file="/WEB-INF/views/buyer/nav.jsp"%>

	<div class="container mx-auto px-4 py-6">
		<h2 class="text-2xl font-bold mb-6">상품 상세정보</h2>

		<table class="min-w-full table-auto bg-white border border-gray-300 mb-6">
			<thead class="bg-gray-200">
				<tr>
					<th class="px-4 py-2 border">상품명</th>
					<th class="px-4 py-2 border">가격</th>
					<th class="px-4 py-2 border">사이즈 선택</th>
					<th class="px-4 py-2 border">재고</th>
					<th class="px-4 py-2 border">상세 설명</th>
					<th class="px-4 py-2 border">사진</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty options}">
					<%-- 첫 번째 옵션만 사용해서 상품 정보 출력 --%>
					<c:set var="firstOption" value="${options[0]}" />
					<tr class="text-center">
						<td class="border px-4 py-2">${firstOption.product.productName}</td>
						<td class="border px-4 py-2">${firstOption.product.productPrice}원</td>

						<%-- 사이즈 셀렉트 박스 --%>
						<td class="border px-4 py-2">
							<select name="sizeId" id="sizeSelect" class="border rounded px-2 py-1">
								<c:forEach var="option" items="${options}">
									<option value="${option.size.sizeId}">
										${option.size.sizeName}
									</option>
								</c:forEach>
							</select>
						</td>

						<%-- 기본 사이즈(stock)는 첫 번째 옵션 기준으로 보여줌. JS로 동적 변경 가능 --%>
						<td class="border px-4 py-2" id="stockDisplay">${firstOption.stock}</td>
						<td class="border px-4 py-2">${firstOption.product.productDetail}</td>
						<td class="border px-4 py-2">
							<img src="${pageContext.request.contextPath}/resources/upload/${firstOption.product.productPhoto}" 
								 alt="상품 사진" style="width: 100px;" />
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>

	</div>

	<script>
		// 사이즈 선택 시 해당 옵션의 재고를 업데이트
		const options = ${fn:escapeXml(options)};
		const sizeSelect = document.getElementById("sizeSelect");
		const stockDisplay = document.getElementById("stockDisplay");

		const stockMap = {
			<c:forEach var="opt" items="${options}">
				'${opt.size.sizeId}': '${opt.stock}',
			</c:forEach>
		};

		sizeSelect.addEventListener("change", function () {
			const selectedSizeId = sizeSelect.value;
			stockDisplay.textContent = stockMap[selectedSizeId] || "0";
		});
	</script>

</body>
</html>
