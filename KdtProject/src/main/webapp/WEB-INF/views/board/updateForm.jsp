<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 수정</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="${pageContext.request.contextPath}/resources/js/tailwind-config.js"></script>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body class="bg-gray-50 font-pretendard">

<%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

<div class="container mx-auto max-w-4xl px-4 sm:px-6 lg:px-8 py-12">
    <div class="bg-white p-8 rounded-lg shadow-md">
        <h2 class="text-3xl font-bold text-gray-800 mb-8 border-b pb-4">공지사항 수정</h2>

        <form action="${pageContext.request.contextPath}/board/updatePro" method="post">
            <div class="mb-6">
                <label for="boardTitle" class="block text-sm font-medium text-gray-700 mb-2">제목</label>
                <input type="text" id="boardTitle" name="boardTitle" value="${dto.boardTitle}" class="block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm" />
            </div>

            <div class="mb-6">
                <label for="boardContent" class="block text-sm font-medium text-gray-700 mb-2">내용</label>
                <textarea id="boardContent" name="boardContent" rows="10" class="block w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm">${dto.boardContent}</textarea>
            </div>

            <input type="hidden" name="boardId" value="${dto.boardId}" />
            <input type="hidden" name="page" value="${page}" />

            <div class="flex justify-end gap-4 mt-8">
                <button type="button" onclick="location.href='${pageContext.request.contextPath}/board/list?page=${page}'" class="px-6 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-main-color">
                    취소
                </button>
                <button type="submit" class="px-6 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-main-color hover:bg-main-color-hover focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-main-color">
                    수정 완료
                </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
