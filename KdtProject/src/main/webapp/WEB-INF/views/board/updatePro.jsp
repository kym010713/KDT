<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${result > 0}">
    <script>
        location.href = '/board/listDetail?id=${dto.boardId}&page=${page}';
    </script>
</c:if>

<c:if test="${result <= 0}">
    <script>
        alert("수정에 실패했습니다.");
        history.go(-1);
    </script>
</c:if>
