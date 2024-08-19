<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
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
    
    <form action="/find/search/id" method="get">
    
    <button>아이디 찾기</button>
    
    </form>
    
    <form action="/find/search/pw" method="get">
    
    <button>비밀번호 찾기</button>
    
    </form>
    
    <form action="/admin/mod" method="get">
    
    <button>정보 수정(임시) </button>
    
    </form>
    
    <!--  my페이지 아직 안만들어서 임시로 넣어놓음, -->
    
    <h3>이메일 발송(임시)</h3>
    <form action="/admin/new" method="post">
        <label for="email">이메일을 입력하세요</label>
        <input type="email" id="email" name="email" required>
        <button type="submit">발송</button>
    </form>
</body>
</html>