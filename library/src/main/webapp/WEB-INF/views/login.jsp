<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 300px;
            margin: 0 auto;
            padding: 50px;
            text-align: center;
        }
        .error-message {
            color: red;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>로그인</h2>
        
        <!-- 에러 메시지가 있을 경우 출력 -->
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
            <c:remove var="errorMessage" scope="session"/> <!-- 메시지 출력 후 삭제 -->
        </c:if>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div>
                <label for="userID">아이디:</label>
                <input type="text" id="userID" name="userID" required>
            </div>
            <div>
                <label for="userPW">비밀번호:</label>
                <input type="password" id="userPW" name="userPW" required>
            </div>
            <div>
                <button type="submit">로그인</button>
            </div>
        </form>
    
    <form action="/find/search/id" method="get">
    
    <button>아이디 찾기</button>
    
    </form>
    
    <form action="/find/search/pw" method="get">
    
    <button>비밀번호 찾기</button>
    
    </form>
    
    <!--  my페이지 아직 안만들어서 임시로 넣어놓음, -->
    
    <h3>이메일 발송(임시)</h3>
    <form action="/admin/new" method="post">
        <label for="email">이메일을 입력하세요</label>
        <input type="email" id="email" name="email" required>
        <button type="submit">발송</button>
    </form>
    </div>
</body>
</html>