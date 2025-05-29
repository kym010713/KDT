<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<h2>글 작성</h2>
<form:form action="/board/writePro" method="post" modelAttribute="boardDTO" enctype="multipart/form-data">
	작성자	<form:input type="text" path="boardWriter" required="required" /><br/>
			<form:errors path="boardWriter" cssClass="error" />
	
	제목		<form:input type="text" path="boardTitle" required="required" /><br/>
			<form:errors path="boardTitle" cssClass="error" />
			
	본문		<form:textarea rows="10" cols="40" path="boardContent" required="required"></form:textarea><br/>
			<form:errors path="boardContent" cssClass="error" />
			
			<input type="submit" value="글 작성">
</form:form>





