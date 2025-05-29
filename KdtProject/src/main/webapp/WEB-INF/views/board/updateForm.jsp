<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<h2>공지사항 수정</h2>

<form action="/board/updatePro" method="post">
    <p>제목: <input type="text" name="boardTitle" value="${dto.boardTitle}" /></p>
    <p>내용:<br/>
    <textarea name="boardContent" rows="10" cols="60">${dto.boardContent}</textarea></p>

    <input type="hidden" name="boardId" value="${dto.boardId}" />
    <input type="hidden" name="page" value="${page}" />

    <button type="submit">수정 완료</button>
</form>
