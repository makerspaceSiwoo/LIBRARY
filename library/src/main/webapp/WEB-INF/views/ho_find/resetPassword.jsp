<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>비밀번호 변경</title>
    <link rel="stylesheet" type="text/css" href="/css/ho/login.css">
</head>
<body>
<div class="container">
    <h2>비밀번호 변경</h2>
    <form action="${pageContext.request.contextPath}/find/pw" method="post">
        <label for="newPassword">새 비밀번호:</label>
        <input type="password" id="newPassword" name="newPassword" required><br><br>

        <button type="submit">비밀번호 변경</button>
    </form>

    <c:if test="${not empty message}">
        <p style="color:red;">${message}</p>
    </c:if>
</div>
</body>
</html>