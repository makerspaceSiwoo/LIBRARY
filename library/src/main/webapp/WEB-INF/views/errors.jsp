<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>오류 발생</title>
    <script type="text/javascript">
        function showErrorPopup() {
            alert('오류가 발생하였습니다. 다시 시도해주세요.');
            window.location.href = '/home';
        }
    </script>
</head>
<body onload="showErrorPopup()">
    <h1 th:text="${exception.message}"></h1>
</body>
</html>