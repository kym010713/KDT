<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FAQ 관리</title>
    <script src="https://cdn.tailwindcss.com"></script>
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

<%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

<div class="container mx-auto max-w-5xl px-4 sm:px-6 lg:px-8 py-12">
    <div class="flex justify-between items-center mb-8 border-b pb-4">
        <h1 class="text-3xl font-bold text-gray-800">
            <i class="fas fa-robot mr-3"></i>챗봇 FAQ 관리
        </h1>
        <a href="${pageContext.request.contextPath}/admin/main" class="px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-main-color">
            <i class="fas fa-arrow-left mr-2"></i>대시보드로 돌아가기
        </a>
    </div>

    <!-- FAQ List Table -->
    <div class="bg-white shadow-md rounded-lg overflow-hidden mb-12">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
                <tr>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider w-2/5">키워드</th>
                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider w-2/5">답변</th>
                    <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider w-1/5">관리</th>
                </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
                <c:if test="${empty faqList}">
                    <tr>
                        <td colspan="3" class="text-center py-10">
                            <i class="fas fa-comment-slash text-4xl text-gray-400 mb-3"></i>
                            <p class="text-gray-600">등록된 FAQ가 없습니다.</p>
                        </td>
                    </tr>
                </c:if>
                <c:forEach var="faq" items="${faqList}">
                    <tr>
                        <form id="edit-form-${faq.id}" action="${pageContext.request.contextPath}/admin/faq/edit/${faq.id}" method="post"></form>
                        <form id="delete-form-${faq.id}" action="${pageContext.request.contextPath}/admin/faq/delete/${faq.id}" method="post" style="display: none;"></form>
                        
                        <td class="px-6 py-4">
                            <input type="text" name="keyword" value="${faq.keyword}" required class="w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm" form="edit-form-${faq.id}" />
                        </td>
                        <td class="px-6 py-4">
                            <input type="text" name="answer" value="${faq.answer}" required class="w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm" form="edit-form-${faq.id}"/>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-center">
                            <button type="submit" class="inline-flex items-center px-3 py-1.5 border border-transparent text-sm font-medium rounded-md text-white bg-main-color hover:bg-main-color-hover focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-main-color" form="edit-form-${faq.id}">수정</button>
                            <button type="button" class="inline-flex items-center px-3 py-1.5 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500" onclick="if(confirm('삭제할까요?')) document.getElementById('delete-form-${faq.id}').submit();">삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Add FAQ Form -->
    <div class="bg-white p-8 rounded-lg shadow-md">
        <h2 class="text-2xl font-bold text-gray-800 mb-6 border-b pb-4">새로운 FAQ 추가</h2>
        <form action="${pageContext.request.contextPath}/admin/faq/add" method="post">
            <div class="mb-4">
                <label for="keyword-add" class="block text-sm font-medium text-gray-700 mb-2">키워드</label>
                <input type="text" id="keyword-add" name="keyword" required class="w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm" />
            </div>
            <div class="mb-6">
                <label for="answer-add" class="block text-sm font-medium text-gray-700 mb-2">답변</label>
                <input type="text" id="answer-add" name="answer" required class="w-full px-3 py-2 bg-white border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-main-color focus:border-main-color sm:text-sm" />
            </div>
            <div class="flex justify-end">
                <button type="submit" class="px-6 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-main-color hover:bg-main-color-hover focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-main-color">
                    <i class="fas fa-plus mr-2"></i>등록
                </button>
            </div>
        </form>
    </div>
</div>
<%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>