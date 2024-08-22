<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .error-message {
            color: #e74c3c;
            background-color: #f8d7da;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            font-size: 14px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            text-align: left;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #3498db;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin-bottom: 10px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #2980b9;
        }

        .additional-options {
            margin-top: 20px;
        }

        .additional-options button {
            width: 48%;
            background-color: #95a5a6;
            margin: 5px 1%;
        }

        .additional-options button:hover {
            background-color: #7f8c8d;
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
    
    <!-- <h3>이메일 발송(임시)</h3>
    <form action="/admin/new" method="post">
        <label for="email">이메일을 입력하세요</label>
        <input type="email" id="email" name="email" required>
        <button type="submit">발송</button>
    </form>
    </div> !-->
</body>
</html>