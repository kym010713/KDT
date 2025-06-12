<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 보기</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="${pageContext.request.contextPath}/resources/js/tailwind-config.js"></script>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .post-content {
            white-space: pre-wrap; /* Preserve line breaks and spaces */
            word-break: break-word; /* Break long words */
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen font-pretendard">

    <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

    <div class="max-w-5xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <c:if test="${not empty dto}">
            <div class="bg-white shadow-lg rounded-xl overflow-hidden">
                <!-- Header -->
                <div class="px-6 py-6 border-b border-gray-200 lg:px-8">
                    <h1 class="text-2xl lg:text-3xl font-bold text-gray-900 leading-tight">
                        ${dto.boardTitle}
                    </h1>
                    <div class="mt-4 flex items-center justify-between text-sm text-gray-500">
                        <div class="flex items-center gap-x-4">
                            <span class="font-semibold text-gray-800">${dto.boardWriter}</span>
                            <span class="text-gray-400">|</span>
                            <span>${dto.formattedDate}</span>
                        </div>
                        <span class="flex items-center gap-x-2">
                            <i class="fas fa-eye text-gray-400"></i>
                            <span>${dto.boardCount}</span>
                        </span>
                    </div>
                </div>

                <!-- Content -->
                <div class="px-6 py-8 lg:px-8">
                    <div class="post-content text-gray-800 leading-relaxed">
                        ${dto.boardContent}
                    </div>
                </div>
                
                <!-- Footer Buttons -->
                <div class="px-6 py-4 bg-gray-50 border-t border-gray-200 flex justify-between items-center">
                     <div>
                        <c:if test="${sessionScope.loginUser.role eq 'ADMIN'}">
                           <a href="/board/update?id=${dto.boardId}&page=${page}" class="inline-flex items-center justify-center gap-2 px-4 py-2 text-sm font-semibold text-gray-800 bg-white border border-gray-300 rounded-lg hover:bg-gray-100 transition-colors shadow-sm">
                                <i class="fas fa-edit"></i>
                                <span>수정</span>
                           </a>
                           <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="/board/delete?id=${dto.boardId}&page=${page}" class="inline-flex items-center justify-center gap-2 px-4 py-2 text-sm font-semibold text-white bg-red-600 rounded-lg hover:bg-red-700 transition-colors shadow-sm ml-2">
                               <i class="fas fa-trash"></i>
                               <span>삭제</span>
                           </a>
                        </c:if>
                    </div>

                    <a href="/board/list?page=${page}" class="inline-flex items-center justify-center gap-2 px-4 py-2 text-sm font-semibold text-white bg-main-color rounded-lg hover:bg-main-color-hover transition-colors shadow-sm">
                        <i class="fas fa-list"></i>
                        <span>목록</span>
                    </a>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>

