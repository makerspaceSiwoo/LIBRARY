<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>아이디 찾기</title>
</head>
<body>
    <h2>아이디 찾기</h2>
    
    <form action="/find/id" method="get">
        <label for="email">이메일:</label>
        <input type="text" id="email" name="email" required>
        <input type="submit" value="찾기">
    </form>
    
    <p>${message}</p>
</body>
</html>