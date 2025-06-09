<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<nav class="bg-gray-800 fixed top-0 left-0 right-0 z-50">
    <div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
        <div class="relative flex h-16 items-center justify-between">
            <div class="absolute inset-y-0 left-0 flex items-center sm:hidden">
                <!-- Mobile menu button -->
                <button type="button"
                    class="relative inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-700 hover:text-white focus:ring-2 focus:ring-white focus:outline-hidden focus:ring-inset"
                    aria-controls="mobile-menu" aria-expanded="false" id="mobile-menu-button">
                    <span class="absolute -inset-0.5"></span>
                    <span class="sr-only">Open main menu</span>
                    <svg class="block size-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
                    </svg>
                    <svg class="hidden size-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>

            <!-- 로고 및 메뉴 -->
            <div class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-start">
                <div class="flex shrink-0 items-center">
                    <a href="${pageContext.request.contextPath}/seller/list">
                        <img class="h-16 w-auto"
                             src="${pageContext.request.contextPath}/resources/upload/logo_no3.png"
                             alt="Your Company">
                    </a>
                </div>
                <div class="hidden sm:ml-6 sm:block">
                    <div class="flex space-x-4 items-center h-16">
                        <!-- 판매자 전용 메뉴 -->
                        <a href="${pageContext.request.contextPath}/seller/list"
                           class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white flex items-center">
                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
                            </svg>
                            상품 목록
                        </a>
                        <a href="${pageContext.request.contextPath}/seller/sales"
                           class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white flex items-center">
                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                            판매 내역
                        </a>
                        <a href="${pageContext.request.contextPath}/seller/delivery"
                           class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white flex items-center">
                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"/>
                            </svg>
                            배송 관리
                        </a>
                        <a href="${pageContext.request.contextPath}/seller/analytics"
                           class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white flex items-center">
                            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 8v8m-4-5v5m-4-2v2m-2 4h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                            </svg>
                            매출 분석
                        </a>
                    </div>
                </div>
            </div>

            <div class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">
                <!-- 고객 쇼핑몰로 전환 버튼 -->
                <a href="${pageContext.request.contextPath}/"
                   class="mr-3 rounded-md px-3 py-2 text-sm font-medium text-gray-300 hover:bg-gray-700 hover:text-white flex items-center">
                    <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4m0 0L7 13m0 0l-1.1 5M7 13l-1.1 5m0 0h9.2M18 18a2 2 0 11-4 0 2 2 0 014 0zm-6 0a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                    고객 쇼핑몰
                </a>

                <!-- 판매자 정보 배지 -->
                <div class="mr-4 hidden sm:block">
                    <div class="flex items-center">
                        <span class="bg-blue-600 text-white px-3 py-1 rounded-full text-sm font-medium flex items-center">
                            <svg class="w-4 h-4 inline mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                            </svg>
                            판매자
                        </span>
                    </div>
                </div>

                <!-- 판매자 메뉴 -->
                <div class="relative ml-3 flex items-center">
                    <div>
                        <button type="button"
                            class="relative flex rounded-full bg-gray-800 text-sm focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800 focus:outline-hidden"
                            id="user-menu-button" aria-expanded="false" aria-haspopup="true">
                            <span class="absolute -inset-1.5"></span>
                            <span class="sr-only">Open user menu</span>
                            <svg class="size-8 text-gray-400 hover:text-white" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0zM4.5 20.25a8.25 8.25 0 0 1 15 0" />
                            </svg>
                        </button>
                    </div>
                    <div class="absolute right-0 z-10 mt-2 w-56 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black/5 focus:outline-hidden hidden top-full"
                         role="menu" aria-orientation="vertical" aria-labelledby="user-menu-button" tabindex="-1">
                        
                        <!-- 사용자 정보 표시 -->
                        <div class="px-4 py-2 border-b border-gray-200">
                            <p class="text-sm font-medium text-gray-900">${sessionScope.loginUser.name}</p>
                            <p class="text-xs text-gray-500">${currentCompany}</p>
                        </div>
                        
                        <a href="${pageContext.request.contextPath}/seller/profile"
                           class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">
                            <svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                            </svg>
                            내 정보
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/logout"
                           class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">
                            <svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
                            </svg>
                            로그아웃
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 모바일 메뉴 -->
    <div class="sm:hidden hidden" id="mobile-menu">
        <div class="space-y-1 px-2 pt-2 pb-3">
            <a href="${pageContext.request.contextPath}/seller/list"
               class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">
                상품 목록
            </a>
            <a href="${pageContext.request.contextPath}/seller/sales"
               class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">
                판매 내역
            </a>
            <a href="${pageContext.request.contextPath}/seller/delivery"
               class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">
                배송 관리
            </a>
            <a href="${pageContext.request.contextPath}/seller/analytics"
               class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">
                매출 분석
            </a>
        </div>
    </div>
</nav>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    // 사용자 메뉴 토글
    const userMenuButton = document.getElementById("user-menu-button");
    const userMenu = userMenuButton?.parentElement?.nextElementSibling;

    if (userMenuButton && userMenu) {
      userMenuButton.addEventListener("click", function (e) {
        e.stopPropagation();
        userMenu.classList.toggle("hidden");
      });

      document.addEventListener("click", function () {
        if (!userMenu.classList.contains("hidden")) {
          userMenu.classList.add("hidden");
        }
      });
    }

    // 모바일 메뉴 토글
    const mobileMenuButton = document.getElementById("mobile-menu-button");
    const mobileMenu = document.getElementById("mobile-menu");

    if (mobileMenuButton && mobileMenu) {
      mobileMenuButton.addEventListener("click", function () {
        mobileMenu.classList.toggle("hidden");
        
        // 아이콘 변경
        const openIcon = mobileMenuButton.querySelector(".block");
        const closeIcon = mobileMenuButton.querySelector(".hidden");
        
        openIcon.classList.toggle("hidden");
        openIcon.classList.toggle("block");
        closeIcon.classList.toggle("hidden");
        closeIcon.classList.toggle("block");
      });
    }
  });
</script>