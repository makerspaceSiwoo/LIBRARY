<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" type="text/css" href="/css/ho/login.css">
</head>
<body>
<div class="container">
    <h2>비밀번호 찾기</h2>
    <form action="${pageContext.request.contextPath}/findpwform" method="post">
        <label for="userID">User ID:</label>
        <input type="text" id="userID" name="userID" required><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br><br>

        <button type="submit">인증 코드 발송</button>
    </form>
    <a href="/login">이전 페이지로 이동</a>

    <c:if test="${not empty message}">
        <p style="color:red;">${message}</p>
    </c:if>
</div>
</body>
</html>