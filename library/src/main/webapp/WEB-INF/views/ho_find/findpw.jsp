<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>비밀번호 찾기</title>
</head>
<body>
    <h2>비밀번호 찾기</h2>
    <form action="${pageContext.request.contextPath}/findpwform" method="post">
        <label for="userID">User ID:</label>
        <input type="text" id="userID" name="userID" required><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br><br>

        <button type="submit">인증 코드 발송</button>
    </form>

    <c:if test="${not empty message}">
        <p style="color:red;">${message}</p>
    </c:if>
</body>
</html>