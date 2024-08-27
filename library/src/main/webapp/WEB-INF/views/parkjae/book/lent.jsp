<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #f0f0f5;
        margin: 0;
        font-family: Arial, sans-serif;
    }
    .loan-container {
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        padding: 40px;
        width: 400px;
        text-align: center;
    }
    .loan-container h1 {
        margin-bottom: 20px;
        font-size: 24px;
        font-weight: bold;
    }
    .loan-container table {
        width: 100%; /* 테이블 너비를 100%로 설정하여 중앙 정렬 */
        margin-bottom: 20px;
        border-collapse: collapse;
    }
    .loan-container td {
        padding-top: 15px;
        padding-bottom: 20px;
        text-align: center;
        vertical-align: middle;
        font-size: 16px;
    }
    .loan-container td.label-cell {
        font-weight: bold;
        vertical-align: middle;
    }
    .loan-container input[type="text"] {
        width: 100%;
        padding: 10px;
        margin-top: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
    }
    .loan-container button {
        width: 50%; /* 버튼 너비를 50%로 설정 */
        padding: 10px;
        background-color: #3C33A4;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
        margin-top: 20px;
    }
    .loan-container button:hover {
        background-color: #3C33A4;
    }
    .loan-container .error-message {
        color: red;
        margin-bottom: 20px;
        font-size: 14px;
    }
    .loan-container .with-border {
        border-bottom: 1px solid #ddd;
        width: 90%;
        margin: 0 auto; /* 가운데 정렬을 위해 추가 */
        text-align: center;
    }
    .loan-container .back-link {
        display: block;
        margin-top: 20px;
        font-size: 12px;
        color: #777;
        text-decoration: none;
    }
    .loan-container .back-link:hover {
        color: #5E5DF0;
    }
</style>
</head>
<body>
    <div class="loan-container">
        <h1>도서 대출</h1>
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>
        <table>
            <tr>
                <td class="label-cell with-border">도서 정보</td>
            </tr>
            <tr>
                <td class="with-border">${bookno} : ${booktitle}</td>
            </tr>
            <tr>
                <td>
                    <form id="lentform" action="" method="POST">
                        <input id="userID" type="text" name="userID" placeholder="유저ID를 입력하세요">
                        <button id="returnbutton" type="submit">대출</button>
                    </form>
                </td>
            </tr>
        </table>
        <a href="/book/record" class="back-link">관리 페이지 되돌아가기</a>
    </div>
<script></script>
</body>
</html>
