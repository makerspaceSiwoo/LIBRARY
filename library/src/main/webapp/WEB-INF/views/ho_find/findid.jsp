<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>아이디 찾기</title>
    <link rel="stylesheet" type="text/css" href="/css/ho/login.css">
</head>
<body>
<div class="container">
    <h2>아이디 찾기</h2>
    
    <form action="/find/id" method="get">
        <label for="email">등록된 이메일:</label>
        <input type="text" id="email" name="email" required>
        <button type="submit">찾기</button>
    </form>
    

    <p>${message}</p>
    <div class="link-container">
    <a href="/login">로그인 페이지로 이동</a>
	</div>

</div>


    
    
    
</body>
</html>