<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <script>
        function validateForm() {
            var userID = document.getElementById("userID").value;
            var userPW = document.getElementById("userPW").value;
            var email = document.getElementById("email").value;
            var name = document.getElementById("name").value;
            var gender = document.getElementById("gender").value;
            var birth = document.getElementById("birth").value;
            var phone = document.getElementById("phone").value;
            var address = document.getElementById("address").value;
            
            var datePattern = /^\d{4}-\d{2}-\d{2}$/;

            if (userID === "" || userPW === "" || email === "" || name === "" ||
                gender === "" || birth === "" || phone === "" || address === "") {
                alert("모든 정보를 입력해 주세요.");
                return false;
            }
            
            if (!datePattern.test(birth)) {
                alert("Birth 필드는 yyyy-MM-dd 형식이어야 합니다.");
                return false; // 폼 제출을 막습니다.
            }
            
            return true;
        }
        </script>
</head>
<body>
<h1><font color="blueviolet">사서 정보 변경</font></h1>
<form action="${pageContext.request.contextPath}/admin/id_check" method="post" onsubmit="return validateForm()">
    <input type="hidden" name="userno" value="${user.userno}" />
    <label for="userID">User ID:</label>
    <input type="text" id="userID" name="userID" value="" required /><br />
    <label for="userPW">Password:</label>
    <input type="password" id="userPW" name="userPW" value="" /><br />
    <label for="email">Email:</label>
    <input type="text" id="email" name="email" value="" /><br />
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" value="" /><br />
    <label for="gender">Gender:</label>
    <input type="text" id="gender" name="gender" value="" /><br />
    <label for="birth">Birth (yyyy-MM-dd):</label>
    <input type="text" id="birth" name="birth" value="반드시 형식에 맞춰주세요." required /><br />
    <label for="phone">Phone:</label>
    <input type="text" id="phone" name="phone" value="" /><br />
    <label for="address">Address:</label>
    <input type="text" id="address" name="address" value="" /><br />
    <button type="submit">정보 변경</button>
</form>
</body>
</html>