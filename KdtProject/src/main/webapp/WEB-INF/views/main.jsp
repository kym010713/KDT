<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <script src="https://cdn.tailwindcss.com"></script>
  <title>쇼핑몰 메인</title>
</head>
<body>

  <%@ include file="/WEB-INF/views/nav.jsp" %>

  <h1>쇼핑몰에 오신 것을 환영합니다!</h1>

  <form action="${pageContext.request.contextPath}/mypage" method="get">
    <label for="id">아이디를 입력하세요:</label>
    <input type="text" name="id" id="id" required />
    <button type="submit">마이페이지로 이동</button>
  </form>

  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const button = document.getElementById("user-menu-button");
      const menu = button.parentElement.nextElementSibling;

      button.addEventListener("click", function (e) {
        e.stopPropagation();
        menu.classList.toggle("hidden");
      });

      document.addEventListener("click", function () {
        if (!menu.classList.contains("hidden")) {
          menu.classList.add("hidden");
        }
      });
    });
  </script>

</body>
</html>
