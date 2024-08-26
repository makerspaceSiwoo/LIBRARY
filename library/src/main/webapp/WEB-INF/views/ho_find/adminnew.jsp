<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사서계정 추가</title>
<style>	
h3 {
    font-size: 20px;
    color: #000000;
    margin-bottom: 15px;
    text-align: center;
}

.email-form {
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #f9f9f9;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    max-width: 400px;
    margin: 0 auto;
    margin-top: 250px;
}

.email-form label {
    font-size: 14px;
    color: #333;
    margin-bottom: 8px;
    text-align: center;
    width: 100%;
}

.email-form input[type="email"] {
    width: 80%; /* 너비를 80%로 설정하여 중앙 정렬 */
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
    font-size: 14px;
    text-align: center; /* 입력 텍스트도 중앙 정렬 */
}

.email-form button {
    background-color: #3C33A4;
    color: #fff;
    padding: 10px 15px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
    width: 80%; /* 버튼 너비를 80%로 설정하여 중앙 정렬 */
    text-align: center;
}

.email-form button:hover {
    background-color: #3C33A4;
    font-weight: bold;
}
</style>
</head>
<body>
<form action="${pageContext.request.contextPath}/admin/new" method="post" class="email-form">
    <h3>사서계정 전송</h3>
    <label for="email">계정을 전송할 이메일을 입력해주세요.</label>
    <input type="email" id="email" name="email" required>
    <button type="submit">전송</button>
    <a href="/admin/mypage">이전 페이지로 돌아가기</a>
</form>
</body>
</html>