<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>회원가입</title>
    <script>
const contextPath = '${pageContext.request.contextPath}';

function sendVerificationCode() {
    const email = document.getElementById("email").value.trim();
    if (!email) {
        alert("이메일을 먼저 입력해주세요.");
        return;
    }

    fetch(contextPath + '/join/send-code', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'email=' + encodeURIComponent(email)
    })
    .then(response => response.text())
    .then(data => {
        if (data === 'success') {
            alert('인증번호가 이메일로 전송되었습니다.');
        } else if (data === 'duplicate') {
            alert('이미 가입된 이메일입니다. 다른 이메일을 입력해주세요.');
        } else {
            alert('인증번호 전송 실패: ' + data);
        }
    })
    .catch(() => alert('서버 오류 발생'));
}

function verifyCode() {
    const email = document.getElementById("email").value.trim();
    const code = document.getElementById("verificationCode").value.trim();
    if (!code) {
        alert("인증번호를 입력해주세요.");
        return;
    }

    fetch(contextPath + '/join/verify-code', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'email=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(code)
    })
    .then(response => response.text())
    .then(data => {
        if (data === 'verified') {
            alert('이메일 인증이 완료되었습니다.');
            // 인증 완료 메시지 표시
            document.getElementById("emailVerifiedMsg").textContent = "인증완료";
        } else {
            alert('인증번호가 올바르지 않습니다.');
        }
    })
    .catch(() => alert('서버 오류 발생'));
}
</script>

</head>
<body>

<h2>회원가입</h2>

<form action="${pageContext.request.contextPath}/join" method="post">
    <label for="id">아이디:</label><br>
    <input type="text" id="id" name="id" value="${userDto.id}" /><br>
    <c:if test="${not empty errors['id']}">
        <span style="color:red;">${errors['id']}</span><br>
    </c:if><br>

    <label for="passwd">비밀번호:</label><br>
    <input type="password" id="passwd" name="passwd" value="${userDto.passwd}" /><br>
    <c:if test="${not empty errors['passwd']}">
        <span style="color:red;">${errors['passwd']}</span><br>
    </c:if><br>

    <label for="name">이름:</label><br>
    <input type="text" id="name" name="name" value="${userDto.name}" /><br>
    <c:if test="${not empty errors['name']}">
        <span style="color:red;">${errors['name']}</span><br>
    </c:if><br>

	<label for="email">이메일:</label><br>
	<input type="email" id="email" name="email" value="${userDto.email}" />
	<button type="button" onclick="sendVerificationCode()">인증번호 받기</button><br>
	
	<!-- 이메일 중복 오류 메시지 -->
	<span id="emailErrorMsg" style="color:red;">
	    <c:if test="${not empty errors['email']}">${errors['email']}</c:if>
	    <c:if test="${not empty emailError}">${emailError}</c:if>
	</span><br>
	
	<label for="verificationCode">인증번호 입력:</label><br>
	<input type="text" id="verificationCode" name="verificationCode" />
	<button type="button" onclick="verifyCode()">인증번호 확인</button><br>
	
	<!-- 인증 완료 메시지 -->
	<span id="emailVerifiedMsg" style="color:green;">
	    <c:if test="${emailVerified != null && emailVerified == userDto.email}">
    			인증완료
		</c:if>
	</span><br>

    <label for="phoneNumber">전화번호:</label><br>
    <input type="text" id="phoneNumber" name="phoneNumber" value="${userDto.phoneNumber}" /><br>
    <c:if test="${not empty errors['phoneNumber']}">
        <span style="color:red;">${errors['phoneNumber']}</span><br>
    </c:if><br>

    <label for="address">주소:</label><br>
    <input type="text" id="address" name="address" value="${userDto.address}" /><br>
    <c:if test="${not empty errors['address']}">
        <span style="color:red;">${errors['address']}</span><br>
    </c:if><br>

    <button type="submit">회원가입</button>
</form>

<p>이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/login">로그인</a></p>

</body>
</html>
