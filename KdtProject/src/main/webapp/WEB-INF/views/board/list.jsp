<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
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
                            'hover': '#111827' // Darker shade for hover
                        }
                    }
                },
            },
        }
    </script>
</head>
<body class="bg-gray-50 min-h-screen font-pretendard">

    <%@ include file="/WEB-INF/views/buyer/nav.jsp" %>

    <div class="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <div class="bg-white shadow-lg rounded-xl overflow-hidden">
            <div class="flex items-center justify-between px-6 py-5 border-b border-gray-200">
                <h2 class="text-xl font-bold text-gray-800 flex items-center">
                    <i class="fas fa-bullhorn mr-3 text-main-color"></i>
                    <span>공지사항</span>
                </h2>
                <div class="flex items-center gap-x-3">
                    <!-- Search Bar -->
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                            <i class="fas fa-search text-gray-400"></i>
                        </div>
                        <input type="text" id="table-search" class="block w-56 lg:w-64 pl-10 pr-3 py-2 border border-gray-300 rounded-lg leading-5 bg-gray-50 placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-1 focus:ring-main-color focus:border-main-color sm:text-sm transition" placeholder="게시글 검색...">
                    </div>
                    <c:if test="${sessionScope.loginUser.role == 'ADMIN'}">
                        <a href="/board/writeForm" class="inline-flex items-center justify-center gap-2 px-4 py-2 text-sm font-semibold text-white bg-main-color rounded-lg hover:bg-main-color-hover transition-colors shadow-sm">
                            <i class="fas fa-pencil-alt"></i>
                            <span>글작성</span>
                        </a>
                    </c:if>
                </div>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-sm text-left text-gray-600">
                    <thead class="bg-gray-100 text-xs text-gray-700 uppercase tracking-wider">
                        <tr>
                            <th scope="col" class="py-3 px-6 w-[10%] text-center">글번호</th>
                            <th scope="col" class="py-3 px-6 w-[15%]">작성자</th>
                            <th scope="col" class="py-3 px-6 w-[40%]">제목</th>
                            <th scope="col" class="py-3 px-6 w-[20%] text-center">작성일</th>
                            <th scope="col" class="py-3 px-6 w-[15%] text-center">조회수</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty boardList.content}">
                            <tr>
                                <td colspan="5" class="py-16 text-center text-gray-500">
                                    <div class="flex flex-col items-center">
                                        <i class="fas fa-box-open text-4xl text-gray-300 mb-4"></i>
                                        <p>게시글이 없습니다.</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                        <c:forEach var="dto" items="${boardList.content}">
                            <tr class="bg-white border-b hover:bg-gray-50 transition-colors">
                                <td class="py-4 px-6 text-center text-gray-500">${dto.boardId}</td>
                                <td class="py-4 px-6 font-medium text-gray-900">${dto.boardWriter}</td>
                                <td class="py-4 px-6">
                                    <a href="listDetail?id=${dto.boardId}&page=${currentPage}" class="hover:underline text-main-color font-semibold">${dto.boardTitle}</a>
                                </td>
                                <td class="py-4 px-6 text-center">${dto.formattedDate}</td>
                                <td class="py-4 px-6 text-center font-medium">${dto.boardCount}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${!empty boardList.content && totalPage > 1}">
                <div class="py-4 px-6 border-t border-gray-200 bg-white">
                    <nav class="flex items-center justify-center space-x-1">
                        <a href="?page=${startPage - 10}" 
                           class="inline-flex items-center px-3 py-2 rounded-lg border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 transition-colors <c:if test='${startPage == 0}'>opacity-50 cursor-not-allowed</c:if>">
                           <i class="fas fa-chevron-left mr-1"></i> 이전
                        </a>

                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                           <a href="?page=${i}" 
                              class="inline-flex items-center px-4 py-2 border text-sm font-medium transition-colors 
                                     <c:if test='${i == currentPage}'>bg-main-color border-main-color text-white rounded-lg shadow-sm</c:if>
                                     <c:if test='${i != currentPage}'>bg-white border-gray-300 text-gray-700 hover:bg-gray-100 rounded-lg</c:if>">
                              ${i + 1}
                           </a>
                        </c:forEach>

                        <a href="?page=${startPage + 10}" 
                           class="inline-flex items-center px-3 py-2 rounded-lg border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 transition-colors <c:if test='${endPage + 1 >= totalPage}'>opacity-50 cursor-not-allowed</c:if>">
                           다음 <i class="fas fa-chevron-right ml-1"></i>
                        </a>
                    </nav>
                </div>
            </c:if>
        </div>
    </div>
    <%@ include file="/WEB-INF/views/buyer/footer.jsp" %>
</body>
</html>
