<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* 네비게이션을 최상단에 고정하고 전체 화면 너비로 확장 */
        body {
            margin: 0;
            padding: 0;
        }
        
        .nav-fixed {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            width: 100%;
            z-index: 1000;
        }
        
        /* 본문 내용이 네비게이션 아래 표시되도록 여백 추가 */
        .content-wrapper {
            margin-top: 180px; /* 네비게이션 + 로고 높이만큼 여백 */
        }
        
        /* 드롭다운 메뉴 강제 표시 스타일 */
        .dropdown-show {
            display: block !important;
            visibility: visible !important;
            opacity: 1 !important;
        }
        
        /* 드롭다운 메뉴가 잘리지 않도록 설정 */
        #user-dropdown-menu {
            background-color: white !important;
            border: 1px solid #ccc !important;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1) !important;
            position: fixed !important;
            top: 60px !important;
            right: 16px !important;
            z-index: 9999 !important;
            width: 192px !important;
        }
        
        /* 네비게이션이 다른 요소를 가리지 않도록 */
        .nav-fixed {
            z-index: 1000 !important;
        }
    </style>
</head>

<nav class="bg-gray-800 nav-fixed">
	<div class="mx-auto px-4 sm:px-6 lg:px-8" style="max-width: 100%; width: 100%;">
		<div class="relative flex h-16 items-center justify-between">
			<div class="absolute inset-y-0 left-0 flex items-center sm:hidden">
				<!-- Mobile menu button -->
				<button type="button"
					class="relative inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-700 hover:text-white focus:ring-2 focus:ring-white focus:outline-hidden focus:ring-inset"
					aria-controls="mobile-menu" aria-expanded="false" id="mobile-menu-button">
					<span class="absolute -inset-0.5"></span> <span class="sr-only">Open
						main menu</span>
					<svg class="block size-6" id="menu-open-icon" fill="none" viewBox="0 0 24 24"
						stroke-width="1.5" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round"
							d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
          </svg>
					<svg class="hidden size-6" id="menu-close-icon" fill="none" viewBox="0 0 24 24"
						stroke-width="1.5" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round"
							d="M6 18 18 6M6 6l12 12" />
          </svg>
				</button>
			</div>

			<!-- 로고 및 메뉴 -->
			<div class="flex flex-1 items-start justify-center sm:items-stretch sm:justify-start pt-4">
				<div class="flex shrink-0 items-start">
					<!-- 이미지 크기를 약 5배 키움 -->
					<a href="${pageContext.request.contextPath}/seller/list"> <img
						class="h-[143px] w-auto"
						src="${pageContext.request.contextPath}/resources/upload/logo_no3.png"
						alt="Your Company">
					</a>
				</div>
				<div class="hidden sm:ml-6 sm:block ml-8">
					<div class="flex space-x-4 mt-12">
						<!-- 판매자 전용 메뉴 -->
						<a href="${pageContext.request.contextPath}/seller/list"
							class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">상품 목록</a>
						<a href="${pageContext.request.contextPath}/seller/sales"
							class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">판매 내역</a>
						<a href="${pageContext.request.contextPath}/seller/delivery"
							class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">배송 관리</a>
						<a href="${pageContext.request.contextPath}/seller/analytics"
							class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white">매출 분석</a>
					</div>
				</div>
			</div>

			<div class="absolute inset-y-0 right-0 flex items-center pr-4">
				<!-- 고객 쇼핑몰로 전환 버튼 -->
				<a href="${pageContext.request.contextPath}/"
					class="hidden sm:flex rounded-md bg-gray-700 px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-600 hover:text-white focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800 focus:outline-hidden me-3 items-center"
					aria-label="Go to customer shopping mall"> 
					<svg class="size-4 mr-2" fill="none" viewBox="0 0 24 24"
						stroke-width="1.5" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round"
							d="M3 3h2l.4 2M7 13h10l4-8H5.4m0 0L7 13m0 0l-1.1 5M7 13l-1.1 5m0 0h9.2M18 18a2 2 0 11-4 0 2 2 0 014 0zm-6 0a2 2 0 11-4 0 2 2 0 014 0z" />
					</svg>
					고객 쇼핑몰
				</a>

				<!-- 판매자 배지 표시 -->
				<div class="mr-3 hidden sm:block">
					<span class="bg-blue-600 text-white px-3 py-1 rounded-full text-sm font-medium flex items-center">
						<i class="fas fa-user-tie text-sm mr-1"></i>
						판매자
					</span>
				</div>

				<!-- 사용자 메뉴 -->
				<div class="relative">
					<div>
						<button type="button"
							class="relative flex rounded-full bg-gray-800 text-sm focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800 focus:outline-hidden"
							id="user-menu-button" aria-expanded="false" aria-haspopup="true"
							onclick="toggleUserMenu(); console.log('Direct onclick triggered');">
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
						class="hidden"
						role="menu" aria-orientation="vertical"
						aria-labelledby="user-menu-button" tabindex="-1" id="user-dropdown-menu">
						<button id="profileBtn"
							class="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">
							내 프로필
						</button>
						<a href="${pageContext.request.contextPath}/logout"
							class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">로그아웃</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 모바일 메뉴 -->
	<div class="sm:hidden hidden" id="mobile-menu">
		<div class="space-y-1 px-2 pt-2 pb-3">
			<a href="${pageContext.request.contextPath}/seller/list"
				class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">상품 목록</a>
			<a href="${pageContext.request.contextPath}/seller/sales"
				class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">판매 내역</a>
			<a href="${pageContext.request.contextPath}/seller/delivery"
				class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">배송 관리</a>
			<a href="${pageContext.request.contextPath}/seller/analytics"
				class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">매출 분석</a>
			
			<!-- 모바일에서만 보이는 추가 메뉴 -->
			<div class="border-t border-gray-700 pt-4 mt-4">
				<a href="${pageContext.request.contextPath}/"
					class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white flex items-center">
					<svg class="size-5 mr-2" fill="none" viewBox="0 0 24 24"
						stroke-width="1.5" stroke="currentColor">
						<path stroke-linecap="round" stroke-linejoin="round"
							d="M3 3h2l.4 2M7 13h10l4-8H5.4m0 0L7 13m0 0l-1.1 5M7 13l-1.1 5m0 0h9.2M18 18a2 2 0 11-4 0 2 2 0 014 0zm-6 0a2 2 0 11-4 0 2 2 0 014 0z" />
					</svg>
					고객 쇼핑몰
				</a>
				<button onclick="toggleUserMenu()"
					class="block w-full text-left rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">
					내 프로필
				</button>
				<a href="${pageContext.request.contextPath}/logout"
					class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">로그아웃</a>
			</div>
		</div>
	</div>
</nav>

<!-- 본문 내용을 위한 여백 추가 -->
<div class="content-wrapper">
	<!-- 여기에 페이지 본문 내용이 들어갑니다 -->
</div>

<!-- 프로필 모달 -->
<div id="profileModal" 
     class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white rounded-xl max-w-lg w-full mx-4 overflow-hidden">
        <!-- 모달 헤더 -->
        <div class="p-6 border-b border-gray-100 flex justify-between items-center">
            <h3 class="text-xl font-bold text-navy-dark">판매자 프로필</h3>
            <button id="closeModal" class="text-gray-400 hover:text-gray-600">
                <i class="fas fa-times text-xl"></i>
            </button>
        </div>
        
        <!-- 모달 내용 -->
        <div class="p-2 space-y-4">
            <div class="space-y-4">
            
            <div class="p-1 bg-gray-50 rounded-lg">
                    <div class="flex items-center gap-2 text-gray-500 mb-1">
                        <i class="fas fa-id-card text-sm"></i>
                        <span class="text-sm">아이디</span>
                    </div>
                    <p class="text-base text-gray-800">${loginUser.id}</p>
                </div>
                
                <div class="p-4 bg-gray-50 rounded-lg">
                    <div class="flex items-center gap-2 text-gray-500 mb-1">
                        <i class="fas fa-envelope text-sm"></i>
                        <span class="text-sm">이메일</span>
                    </div>
                    <p class="text-lg text-gray-800">${loginUser.email}</p>
                </div>  
                
                 <div class="p-4 bg-gray-50 rounded-lg">
                    <div class="flex items-center gap-2 text-gray-500 mb-1">
                        <i class="fas fa-phone text-sm"></i>
                        <span class="text-sm">전화번호</span>
                    </div>
                    <p class="text-lg text-gray-800">${loginUser.phoneNumber}</p>
                </div>  
                
                <div class="p-4 bg-gray-50 rounded-lg">
                    <div class="flex items-center gap-2 text-gray-500 mb-1">
                        <i class="fas fa-user text-sm"></i>
                        <span class="text-sm">이름</span>
                    </div>
                    <p class="text-lg text-gray-800">${loginUser.name}</p>
                </div>
                
                <div class="p-4 bg-gray-50 rounded-lg">
                    <div class="flex items-center gap-2 text-gray-500 mb-1">
                        <i class="fas fa-map-marker-alt text-sm"></i>
                        <span class="text-sm">주소</span>
                    </div>
                    <p class="text-lg text-gray-800">${loginUser.address}</p>
                </div>
                
                <div class="p-4 bg-gray-50 rounded-lg">
                    <div class="flex items-center gap-2 text-gray-500 mb-1">
                        <i class="fas fa-store text-sm"></i>
                        <span class="text-sm">판매자 등급</span>
                    </div>
                    <p class="text-lg text-gray-800">${loginUser.grade}</p>
                </div>
                
                <!-- 판매자 전용 정보 -->
                <div class="p-4 bg-blue-50 rounded-lg">
                    <div class="flex items-center gap-2 text-blue-600 mb-1">
                        <i class="fas fa-chart-line text-sm"></i>
                        <span class="text-sm">판매자 상태</span>
                    </div>
                    <p class="text-lg text-blue-800">활성 판매자</p>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/seller/profile" class="text-sm text-gray-500 hover:underline">&#x2039; 판매자 정보 수정</a>
        </div>
        
        <!-- 모달 푸터 -->
        <div class="p-6 border-t border-gray-100">
            <button id="closeModalBtn" 
                    class="w-full py-3 bg-gray-800 text-white rounded-lg hover:bg-gray-700 transition-colors duration-200">
                닫기
            </button>
        </div>
    </div>
</div>

<script>
  // 즉시 실행으로 전역 함수 등록
  window.toggleUserMenu = function() {
    console.log("toggleUserMenu called!");
    const menu = document.getElementById("user-dropdown-menu");
    if (menu) {
      menu.classList.toggle("hidden");
      menu.classList.toggle("dropdown-show");
      console.log("Menu toggled, hidden:", menu.classList.contains("hidden"));
    }
  };

  // 강제 onclick 방식 (콘솔에서 성공한 방법 적용)
  function setupButtonClick() {
    const btn = document.getElementById("user-menu-button");
    if (btn) {
      console.log("Setting up button click - direct onclick method");
      btn.onclick = function() {
        console.log("Button clicked!");
        const menu = document.getElementById("user-dropdown-menu");
        if (menu) {
          menu.classList.toggle("hidden");
          menu.classList.toggle("dropdown-show");
        }
      };
      console.log("Button click setup complete");
    } else {
      console.error("Button not found!");
    }
  }

  // 모바일 메뉴 토글 함수
  function setupMobileMenu() {
    const mobileButton = document.getElementById("mobile-menu-button");
    const mobileMenu = document.getElementById("mobile-menu");
    const openIcon = document.getElementById("menu-open-icon");
    const closeIcon = document.getElementById("menu-close-icon");
    
    if (mobileButton && mobileMenu) {
      console.log("Setting up mobile menu");
      mobileButton.onclick = function() {
        console.log("Mobile menu button clicked!");
        
        // 메뉴 토글
        mobileMenu.classList.toggle("hidden");
        
        // 아이콘 변경
        if (openIcon && closeIcon) {
          openIcon.classList.toggle("hidden");
          openIcon.classList.toggle("block");
          closeIcon.classList.toggle("hidden");
          closeIcon.classList.toggle("block");
        }
      };
      console.log("Mobile menu setup complete");
    } else {
      console.error("Mobile menu elements not found!");
    }
  }

  // DOM 로드 후 즉시 실행
  document.addEventListener("DOMContentLoaded", function() {
    setupButtonClick();
    setupMobileMenu();
  });
  
  // 추가 보험: 약간의 지연 후에도 실행
  setTimeout(function() {
    setupButtonClick();
    setupMobileMenu();
  }, 100);
  setTimeout(function() {
    setupButtonClick();
    setupMobileMenu();
  }, 500);

  document.addEventListener("DOMContentLoaded", function () {
    // 프로필 모달 관련
    const profileBtn = document.getElementById("profileBtn");
    const profileModal = document.getElementById("profileModal");
    const closeModal = document.getElementById("closeModal");
    const closeModalBtn = document.getElementById("closeModalBtn");

    if (profileBtn && profileModal) {
      profileBtn.addEventListener("click", () => {
        profileModal.classList.remove("hidden");
        const menu = document.getElementById("user-dropdown-menu");
        if (menu) {
          menu.classList.add("hidden");
          menu.classList.remove("dropdown-show");
        }
        document.body.style.overflow = "hidden";
      });
    }

    const hideModal = () => {
      if (profileModal) {
        profileModal.classList.add("hidden");
        document.body.style.overflow = "";
      }
    };

    if (closeModal) closeModal.addEventListener("click", hideModal);
    if (closeModalBtn) closeModalBtn.addEventListener("click", hideModal);

    if (profileModal) {
      profileModal.addEventListener("click", (e) => {
        if (e.target === profileModal) hideModal();
      });
    }

    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape" && profileModal && !profileModal.classList.contains("hidden")) {
        hideModal();
      }
    });

    // 문서 클릭시 메뉴 닫기
    document.addEventListener("click", function (e) {
      const menu = document.getElementById("user-dropdown-menu");
      const button = document.getElementById("user-menu-button");
      if (menu && button && !menu.classList.contains("hidden") && !button.contains(e.target) && !menu.contains(e.target)) {
        menu.classList.add("hidden");
        menu.classList.remove("dropdown-show");
      }
    });
  });
</script>