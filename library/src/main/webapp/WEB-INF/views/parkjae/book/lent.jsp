<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/css/pjh/lent.css">

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
                        <button id="returnbutton" type="submit" onclick="alert('대출되었습니다.')">대출</button>
                    </form>
                </td>
            </tr>
        </table>
        <a href="/book/record" class="back-link">관리 페이지 되돌아가기</a>
    </div>
</body>
</html>
