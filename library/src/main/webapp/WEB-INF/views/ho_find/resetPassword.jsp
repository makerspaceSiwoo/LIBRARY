<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>비밀번호 변경</title>
    <link rel="stylesheet" type="text/css" href="/css/ho/login.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container">
    <h2>비밀번호 변경</h2>
    <form id="passwordChangeForm" action="${pageContext.request.contextPath}/find/pw" method="post">
        <label for="newPassword">새 비밀번호:</label>
        <input type="password" id="newPassword" name="newPassword" required><br><br>

        <button type="submit">비밀번호 변경</button>
    </form>

    <c:if test="${not empty message}">
        <p style="color:red;">${message}</p>
    </c:if>
</div>

<script>
    $(document).ready(function() {
        $("#passwordChangeForm").submit(function(event) {
            let password = $("#newPassword").val();

            // 비밀번호 유효성 검사
            var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
            if (!passwordPattern.test(password)) {
                alert("비밀번호는 최소 8자 이상이며, 대문자, 소문자, 숫자, 특수기호를 포함해야 합니다.");
                event.preventDefault(); // 폼 제출 중단
                return false;
            }
        });
    });
</script>

</body>
</html>