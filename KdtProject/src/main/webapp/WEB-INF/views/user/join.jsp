<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>회원가입</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/join.css" />
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
                document.querySelector('.verification-code-area').classList.add('show');
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
    <div class="join-box">
        <h2>회원가입</h2>

        <form action="${pageContext.request.contextPath}/join" method="post">
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" value="${userDto.id}" />
                <c:if test="${not empty errors['id']}">
                    <div class="error-message">${errors['id']}</div>
                </c:if>
            </div>

            <div class="form-group">
                <label for="passwd">비밀번호</label>
                <input type="password" id="passwd" name="passwd" value="${userDto.passwd}" />
                <c:if test="${not empty errors['passwd']}">
                    <div class="error-message">${errors['passwd']}</div>
                </c:if>
            </div>

            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" value="${userDto.name}" />
                <c:if test="${not empty errors['name']}">
                    <div class="error-message">${errors['name']}</div>
                </c:if>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <div class="verification-group">
                    <input type="email" id="email" name="email" value="${userDto.email}" />
                    <button type="button" onclick="sendVerificationCode()">인증번호 받기</button>
                </div>
                <div class="error-message">
                    <c:if test="${not empty errors['email']}">${errors['email']}</c:if>
                    <c:if test="${not empty emailError}">${emailError}</c:if>
                </div>
            </div>

            <div class="form-group verification-code-area">
                <label for="verificationCode">인증번호</label>
                <div class="verification-group">
                    <input type="text" id="verificationCode" name="verificationCode" />
                    <button type="button" onclick="verifyCode()">인증번호 확인</button>
                </div>
                <div class="success-message" id="emailVerifiedMsg">
                    <c:if test="${emailVerified != null && emailVerified == userDto.email}">
                        인증완료
                    </c:if>
                </div>
            </div>

            <div class="form-group">
                <label for="phoneNumber">전화번호</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value="${userDto.phoneNumber}" />
                <c:if test="${not empty errors['phoneNumber']}">
                    <div class="error-message">${errors['phoneNumber']}</div>
                </c:if>
            </div>

            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="address" name="address" value="${userDto.address}" />
                <c:if test="${not empty errors['address']}">
                    <div class="error-message">${errors['address']}</div>
                </c:if>
            </div>

            <button type="submit">회원가입</button>
        </form>

        <p class="login-link">이미 계정이 있으신가요? <a href="${pageContext.request.contextPath}/login">로그인</a></p>
    </div>
</body>
</html>
