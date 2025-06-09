<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav class="bg-gray-800">
	<div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
		<div class="relative flex h-16 items-center justify-between">
			<div class="absolute inset-y-0 left-0 flex items-center sm:hidden">
				<!-- Mobile menu button -->
				<button type="button"
					class="relative inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-700 hover:text-white focus:ring-2 focus:ring-white focus:outline-hidden focus:ring-inset"
					aria-controls="mobile-menu" aria-expanded="false">
					<span class="absolute -inset-0.5"></span> <span class="sr-only">Open
						main menu</span>
					<svg class="block size-6" fill="none" viewBox="0 0 24 24"
						stroke-width="1.5" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round"
							d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
          </svg>
					<svg class="hidden size-6" fill="none" viewBox="0 0 24 24"
						stroke-width="1.5" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round"
							d="M6 18 18 6M6 6l12 12" />
          </svg>
				</button>
			</div>

			<!-- 로고 및 메뉴 -->
			<div
				class="flex flex-1 items-start justify-center sm:items-stretch sm:justify-start pt-4">
				<div class="flex shrink-0 items-start">
					<!-- 이미지 크기를 약 5배 키움 -->

					<a href="${pageContext.request.contextPath}/"> <img
						class="h-[143px] w-auto"
						src="${pageContext.request.contextPath}/resources/upload/logo_no3.png"
						alt="Your Company">
					</a>
				</div>
				<div class="hidden sm:ml-6 sm:block ml-8">
					<div class="flex space-x-4 mt-12">
						<a href="${pageContext.request.contextPath}/board/list"
							class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">공지사항</a>
						<a href="${pageContext.request.contextPath}/chatbot/faq"
							class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">챗봇상담</a>	
						<a href="#"
							class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Projects</a>
						<a href="#"
							class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Calendar</a>
					</div>
				</div>
			</div>

			<div
				class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">

				<!-- 관리자 전용 아이콘 (로그인한 사용자가 관리자일 경우에만 표시) -->
				<c:if
					test="${sessionScope.loginUser != null && sessionScope.loginUser.role eq 'ADMIN'}">
					<a href="${pageContext.request.contextPath}/admin/main"
						class="relative rounded-full bg-gray-800 p-1 text-gray-400 hover:text-white focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800 focus:outline-hidden me-2"
						aria-label="Admin Dashboard"> <span
						class="absolute -inset-1.5"></span> <svg class="size-6"
							fill="none" viewBox="0 0 24 24" stroke-width="1.5"
							stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round"
								d="M10.343 3.94c.09-.542.56-.94 1.11-.94h1.093c.55 0 1.02.398 1.11.94l.149.894c.07.424.384.764.78.93.398.164.855.142 1.205-.108l.737-.527a1.125 1.125 0 011.45.12l.773.774c.39.389.44 1.002.12 1.45l-.527.737c-.25.35-.272.806-.107 1.204.165.397.505.71.93.78l.893.15c.543.09.94.56.94 1.109v1.094c0 .55-.397 1.02-.94 1.11l-.893.149c-.425.07-.765.383-.93.78-.165.398-.143.854.107 1.204l.527.738c.32.447.269 1.06-.12 1.45l-.774.773a1.125 1.125 0 01-1.449.12l-.738-.527c-.35-.25-.806-.272-1.204-.107-.397.165-.71.505-.78.929l-.15.894c-.09.542-.56.94-1.11.94h-1.094c-.55 0-1.019-.398-1.11-.94l-.148-.894c-.071-.424-.384-.764-.78-.93-.398-.164-.855-.142-1.204.108l-.738.527c-.447.32-1.06.269-1.45-.12l-.773-.774a1.125 1.125 0 01-.12-1.45l.527-.737c.25-.35.273-.806.108-1.204-.165-.397-.505-.71-.93-.78l-.894-.15c-.542-.09-.94-.56-.94-1.109v-1.094c0-.55.398-1.02.94-1.11l.894-.149c.424-.07.765-.383.93-.78.165-.398.143-.854-.107-1.204l-.527-.738a1.125 1.125 0 01.12-1.45l.773-.773a1.125 1.125 0 011.45-.12l.737.527c.35.25.807.272 1.204.107.397-.165.71-.505.78-.929l.15-.894z" />
            <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
        </svg>
					</a>
				</c:if>

				<!-- 장바구니 아이콘 -->
				<a href="${pageContext.request.contextPath}/mypage/cart"
					class="relative rounded-full bg-gray-800 p-1 text-gray-400 hover:text-white focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800 focus:outline-hidden"
					aria-label="View cart"> <span class="absolute -inset-1.5"></span>
					<svg class="size-6" fill="none" viewBox="0 0 24 24"
						stroke-width="1.5" stroke="currentColor">
    <path stroke-linecap="round" stroke-linejoin="round"
							d="M2.25 3h1.386a.75.75 0 0 1 .735.59l.383 1.723m0 0l1.358 6.105a2.25 2.25 0 0 0 2.201 1.782h7.059a2.25 2.25 0 0 0 2.2-1.781l1.23-5.537a1.125 1.125 0 0 0-1.096-1.369H6.007M6.754 19.5a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5zm10.5 0a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5z" />
  </svg>
				</a>


				<!-- 사용자 메뉴 -->
				<div class="relative ml-3">
					<div>
						<button type="button"
							class="relative flex rounded-full bg-gray-800 text-sm focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800 focus:outline-hidden"
							id="user-menu-button" aria-expanded="false" aria-haspopup="true">
							<span class="absolute -inset-1.5"></span> <span class="sr-only">Open
								user menu</span>
							<svg class="size-8 text-gray-400 hover:text-white" fill="none"
								viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round"
									d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0zM4.5 20.25a8.25 8.25 0 0 1 15 0" />
              </svg>
						</button>
					</div>
					<div
						class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black/5 focus:outline-hidden hidden"
						role="menu" aria-orientation="vertical"
						aria-labelledby="user-menu-button" tabindex="-1">
						<a href="${pageContext.request.contextPath}/mypage"
							class="block px-4 py-2 text-sm text-gray-700" role="menuitem">Your
							Profile</a> <a href="#" class="block px-4 py-2 text-sm text-gray-700"
							role="menuitem">Settings</a>
							<a href="../seller/list" class="block px-4 py-2 text-sm text-gray-700"
							role="menuitem">Seller page</a> <a
							href="${pageContext.request.contextPath}/logout"
							class="block px-4 py-2 text-sm text-gray-700" role="menuitem">Sign
							out</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 모바일 메뉴 -->
	<div class="sm:hidden" id="mobile-menu">
		<div class="space-y-1 px-2 pt-2 pb-3">
			<a href="${pageContext.request.contextPath}/board/main"
				class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">공지사항</a>
			<a href="#"
				class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Team</a>
			<a href="#"
				class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Projects</a>
			<a href="#"
				class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Calendar</a>
		</div>
	</div>
</nav>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const button = document.getElementById("user-menu-button");
    const menu = button?.parentElement?.nextElementSibling;

    if (button && menu) {
      button.addEventListener("click", function (e) {
        e.stopPropagation();
        menu.classList.toggle("hidden");
      });

      document.addEventListener("click", function () {
        if (!menu.classList.contains("hidden")) {
          menu.classList.add("hidden");
        }
      });
    }
  });
</script>