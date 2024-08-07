<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Login</title>
</head>
<body>
    <form action="/login" method="post">
        <label for="userID">User ID:</label>
        <input type="text" id="userID" name="userID" required><br>

        <label for="userPW">Password:</label>
        <input type="password" id="userPW" name="userPW" required><br>

        <button type="submit">Login</button>
    </form>
    
    <h3>이메일 발송</h3>
    <form action="/admin/new" method="post">
        <label for="email">이메일을 입력하세요</label>
        <input type="email" id="email" name="email" required>
        <button type="submit">발송</button>
    </form>
</body>
</html>