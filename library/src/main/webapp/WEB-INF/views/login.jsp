<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 페이지</title>
<link rel="stylesheet" type="text/css" href="/css/ho/login.css">
    
    <script>
        window.onload = function() {
            const loginMessage = "<c:out value='${loginMessage}'/>";
            if (loginMessage) {
                alert(loginMessage);
            }
        };
    </script>
    
</head>
<body>
<c:if test="${not empty popupMessage}">
        <script>
            alert("${popupMessage}");
        </script>
    </c:if>
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
        
    <div class="link-container">
    <a id="searchid" href="/find/search/id">아이디 찾기</a>
    <a id="searchpw" href="/find/search/pw">비밀번호 찾기</a>
    <a id="join" href="/join">회원가입</a>
	</div>
	</div>
</body>
</html>