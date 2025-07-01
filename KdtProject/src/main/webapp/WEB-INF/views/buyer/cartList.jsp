<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" as="style" crossorigin
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
	integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script>
		tailwind.config = {
			theme: {
				extend: {
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
<body class="bg-gray-50 min-h-screen font-pretendard">

	<%@ include file="/WEB-INF/views/buyer/nav.jsp"%>

	<div class="max-w-5xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
		<div class="bg-white shadow-lg rounded-xl overflow-hidden">
			<div class="px-6 py-5 border-b border-gray-200">
				<h2 class="text-xl font-bold text-gray-800 flex items-center">
					<i class="fas fa-shopping-cart mr-3 text-main-color"></i> <span>장바구니</span>
				</h2>
			</div>

			<c:choose>
				<c:when test="${empty cartList}">
					<div class="text-center py-24 px-6">
						<div class="flex flex-col items-center">
							<i class="fas fa-cart-plus text-5xl text-gray-300 mb-6"></i>
							<h3 class="text-lg font-semibold text-gray-700">장바구니가 비어
								있습니다.</h3>
							<p class="text-gray-500 mt-2">마음에 드는 상품을 담아보세요!</p>
							<a href="${pageContext.request.contextPath}/"
								class="mt-8 inline-flex items-center justify-center gap-2 px-5 py-2.5 text-sm font-semibold text-white bg-main-color rounded-lg hover:bg-main-color-hover transition-colors shadow-sm">
								<i class="fas fa-store"></i> <span>쇼핑 계속하기</span>
							</a>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="overflow-x-auto">
						<table class="w-full text-sm text-left text-gray-600">
							<thead
								class="bg-gray-100 text-xs text-gray-700 uppercase tracking-wider">
								<tr>
									<th scope="col" class="py-3 px-6 w-[45%]" colspan="2">상품
										정보</th>
									<th scope="col" class="py-3 px-6 w-[15%] text-center">사이즈</th>
									<th scope="col" class="py-3 px-6 w-[15%] text-center">수량</th>
									<th scope="col" class="py-3 px-6 w-[20%] text-center">가격</th>
									<th scope="col" class="py-3 px-6 w-[5%]"></th>
								</tr>
							</thead>
							<tbody>
								<c:set var="totalPrice" value="0" />
								<c:forEach var="item" items="${cartList}">
									<tr
										class="cart-item bg-white border-b hover:bg-gray-50 transition-colors"
										data-cart-id="${item.cartId}"
										data-price="${item.productPrice}">
										<td class="p-4 w-24"><a
											href="${pageContext.request.contextPath}/mypage/product/detail?id=${item.productId}">

												<img src="${imagekitUrl}product/${item.productPhoto}"
												alt="${item.productName}"
												class="w-20 h-20 object-cover rounded-md hover:opacity-80 transition-opacity" />
										</a></td>
										<td class="py-4 px-6 font-medium text-gray-900"><a
											href="${pageContext.request.contextPath}/mypage/product/detail?id=${item.productId}"
											class="hover:text-main-color transition-colors">${item.productName}</a>
										</td>
										<td class="py-4 px-6 text-center">${item.productSize}</td>
										<td class="py-4 px-6 text-center">
											<div class="flex items-center justify-center space-x-2">
												<button type="button"
													class="quantity-btn w-7 h-7 text-lg rounded-full border hover:bg-gray-100 transition-colors"
													data-change="-1">-</button>
												<input type="text" value="${item.cartCount}"
													class="quantity-input w-12 text-center font-semibold text-gray-800 border-transparent bg-transparent"
													readonly>
												<button type="button"
													class="quantity-btn w-7 h-7 text-lg rounded-full border hover:bg-gray-100 transition-colors"
													data-change="1">+</button>
											</div>
										</td>
										<td
											class="item-total py-4 px-6 text-center font-semibold text-gray-800">
											<fmt:formatNumber
												value="${item.cartCount * item.productPrice}" type="number"
												groupingUsed="true" />원
										</td>
										<td class="py-4 px-6 text-center">
											<form
												action="${pageContext.request.contextPath}/mypage/cart/delete"
												method="post">
												<input type="hidden" name="cartId" value="${item.cartId}" />
												<button type="submit"
													class="text-gray-400 hover:text-red-600 transition-colors"
													title="삭제">
													<i class="fas fa-times-circle"></i>
												</button>
											</form>
										</td>
									</tr>
									<c:set var="itemTotal"
										value="${item.cartCount * item.productPrice}" />
									<c:set var="totalPrice" value="${totalPrice + itemTotal}" />
								</c:forEach>
							</tbody>
						</table>
					</div>

					<div
						class="px-6 py-5 bg-gray-50 border-t border-gray-200 flex justify-between items-center">
						<div class="text-lg font-bold text-gray-800">
							<span>총 결제금액: </span> <span id="cart-total"
								class="text-main-color text-xl ml-2"> <fmt:formatNumber
									value="${totalPrice}" type="number" groupingUsed="true" /> 원
							</span>
						</div>
						<form
							action="${pageContext.request.contextPath}/mypage/order/form"
							method="get">
							<button type="submit"
								class="inline-flex items-center justify-center gap-2 px-6 py-3
                 text-base font-semibold text-white bg-main-color
                 rounded-lg hover:bg-main-color-hover transition-colors shadow-sm">
								<i class="fas fa-credit-card"></i> <span>결제하기</span>
							</button>
						</form>

					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<script>
const C_PATH = '${pageContext.request.contextPath}';

document.addEventListener('DOMContentLoaded', () => {
  // 수량 + / - 버튼 클릭 시
  document.querySelectorAll('.quantity-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const row       = btn.closest('.cart-item');
      const cartId    = row.dataset.cartId;
      const delta     = parseInt(btn.dataset.change, 10);
      const qtyInput  = row.querySelector('.quantity-input');
      const newQty    = parseInt(qtyInput.value, 10) + delta;

      if (newQty < 1) {
        if (confirm('상품을 장바구니에서 삭제하시겠습니까?')) {
          deleteCartItem(cartId);
        }
        return;
      }

      updateCartQuantity(cartId, newQty);
    });
  });
});

// ▶ 서버에 수량 업데이트 요청 후, 성공 시 페이지 새로고침
async function updateCartQuantity(cartId, cartCount) {
  try {
    const res   = await fetch(`${C_PATH}/mypage/cart/update`, {
      method : 'POST',
      headers: { 'Content-Type': 'application/json' },
      body   : JSON.stringify({ cartId, cartCount })
    });

    const json = await res.json();
    console.log('서버 응답:', json);
    if (json.success) {
      location.reload(); // ✅ 새로고침으로 가장 간단히 화면 반영
    } else {
      alert(json.message || '수량 변경에 실패했습니다.');
    }
  } catch (err) {
    console.error('fetch error:', err);
    alert('오류가 발생했습니다. 다시 시도해주세요.');
  }
}

// ▶ 항목 삭제 (폼 전송)
function deleteCartItem(cartId) {
  const form  = document.createElement('form');
  form.method = 'post';
  form.action = `${C_PATH}/mypage/cart/delete`;

  const input = document.createElement('input');
  input.type  = 'hidden';
  input.name  = 'cartId';
  input.value = cartId;
  form.appendChild(input);

  document.body.appendChild(form);
  form.submit();
}
</script>

<%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>
