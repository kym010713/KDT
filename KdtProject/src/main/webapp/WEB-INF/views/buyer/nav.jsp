<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
						<a href="${pageContext.request.contextPath}/board/main"
							class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">공지사항</a>
						<a href="#"
							class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Projects</a>
						<a href="#"
							class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Calendar</a>
					</div>
				</div>
			</div>

			<div
				class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">
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
							role="menuitem">Settings</a> <a
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
