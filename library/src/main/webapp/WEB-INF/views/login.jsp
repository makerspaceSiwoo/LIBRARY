<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<html>
<head>
    <title>로그인</title>
    <meta charset="UTF-8">
</head>
<body>
    <h2>로그인</h2>
    <form action="adminhome.jsp" method="post">
        <label for="id">아이디:</label>
        <input type="text" id="id" name="id" required><br><br>
        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password" required><br><br>
        <input type="submit" value="로그인">
    </form>
</body>
</html>
