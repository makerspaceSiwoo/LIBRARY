<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오류 발생</title>
    <style>
       	 body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #ffff; /* 통일된 배경색 */
        }

        .error-container {
            padding: 20px;
            border-radius: 8px;
        }

        h1 {
            font-size: 2rem;
            margin: 0;
            color: #ff6b6b;
            text-align: center;
        }

        p {
            font-size: 1rem;
            margin: 10px 0 20px;
            color: #555;
            text-align: center;
        }

        a {
            display: inline-block;
            padding: 5px 10px;
            font-size: 1rem;
            color: #fff;
            background-color: #3C33A4;
            text-decoration: none;
            border-radius: 20px;
            transition: background-color 0.3s ease;
            margin-bottom: 100px;
            margin-left: 200px;
        }

        a:hover {
            background-color: #3C33A4;
        }
        .error-image {
            max-width: 70%;
            height: auto;
            margin-left: 60px;
        }
    </style>
</head>
<body>
    <div class="error-container">
    	<img src="/logo/bookimg.png" alt="errors" class="error-image">
        <h1>찾을 수 없는 페이지입니다.</h1><br>
        <p>잘못된 요청입니다. 오타가 있는지 확인해주세요.</p>
        <p>Wrong request, please check if there is a typo.</p>
        <p th:text="${exception.message}"></p><br><br>
        <a href="/home">메인으로 돌아가기</a>
    </div>
</body>
</html>