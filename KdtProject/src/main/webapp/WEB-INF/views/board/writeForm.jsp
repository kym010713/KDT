<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>새 글 작성</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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

    <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

    <div class="max-w-4xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <div class="bg-white shadow-lg rounded-xl overflow-hidden">
            <div class="px-6 py-5 border-b border-gray-200">
                <h2 class="text-xl font-bold text-gray-800 flex items-center">
                    <i class="fas fa-pencil-alt mr-3 text-main-color"></i>
                    <span>새 게시글 작성</span>
                </h2>
            </div>
            
            <form:form action="/board/writePro" method="post" modelAttribute="boardDTO" class="p-6 space-y-6">
                <%-- 작성자 필드는 현재 비활성화 되어 있습니다.
                <div class="space-y-2">
                    <label for="boardWriter" class="block text-sm font-medium text-gray-700">작성자</label>
                    <form:input path="boardWriter" id="boardWriter" required="required" cssClass="block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm" />
                    <form:errors path="boardWriter" cssClass="text-sm text-red-600" />
                </div>
                --%>
                
                <div class="space-y-2">
                    <label for="boardTitle" class="block text-sm font-medium text-gray-700">제목</label>
                    <form:input path="boardTitle" id="boardTitle" required="required" cssClass="block w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm transition-colors" />
                    <form:errors path="boardTitle" cssClass="text-sm text-red-600 mt-1" />
                </div>
                
                <div class="space-y-2">
                    <label for="boardContent" class="block text-sm font-medium text-gray-700">본문</label>
                    <form:textarea path="boardContent" id="boardContent" required="required" rows="12" cssClass="block w-full px-3 py-2 border border-gray-300 rounded-lg shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm transition-colors"></form:textarea>
                    <form:errors path="boardContent" cssClass="text-sm text-red-600 mt-1" />
                </div>
                
                <div class="flex justify-end gap-x-3 pt-4 border-t border-gray-200 mt-8">
                    <a href="/board/list" class="inline-flex items-center justify-center px-4 py-2 text-sm font-semibold text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors shadow-sm">
                        취소
                    </a>
                    <button type="submit" class="inline-flex items-center justify-center gap-2 px-4 py-2 text-sm font-semibold text-white bg-main-color rounded-lg hover:bg-main-color-hover transition-colors shadow-sm">
                        <i class="fas fa-check"></i>
                        <span>글 작성 완료</span>
                    </button>
                </div>
            </form:form>
        </div>
    </div>

</body>
</html>





