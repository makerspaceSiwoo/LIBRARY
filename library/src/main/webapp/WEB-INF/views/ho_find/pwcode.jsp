<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>인증 코드 확인</title>
</head>
<body>
    <h2>인증 코드 확인</h2>
    <form action="${pageContext.request.contextPath}/pwcode" method="post">
        <label for="verificationCode">인증 코드:</label>
        <input type="text" id="verificationCode" name="verificationCode" required><br><br>

        <button type="submit">인증 코드 확인</button>
    </form>

    <c:if test="${not empty message}">
        <p style="color:red;">${message}</p>
    </c:if>
</body>
</html>