<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>회원 정보 수정</h2>

    <!-- 에러 메시지 표시 -->
    <c:if test="${not empty error}">
        <div style="color: red;">${error}</div>
    </c:if>
    
    <!-- <c:if test="${not empty successMessage}">
        <script>
            $(document).ready(function() {
                alert("${successMessage}");
            });
        </script>
    </c:if> -->
	
    <form id="editForm" action="${pageContext.request.contextPath}/admin/mod/info" method="post">
        <table>
            <tr>
                <td>아이디:</td>
                <td>
                    <input type="text" name="userID" id="userID" value="${user.userID}" required>
                    <button type="button" id="checkUserID">중복 체크</button>
                    <span id="userIDCheckResult"></span>
                </td>
            </tr>
            <tr>
                <td>비밀번호:</td>
                <td><input type="password" name="userPW" value="" required></td>
            </tr>
            <tr>
                <td>이름:</td>
                <td><input type="text" name="name" value="${user.name}" required></td>
            </tr>
            <tr>
                <td>생년월일:</td>
                <td><input type="date" name="birth" value="${user.birth}" required></td>
            </tr>
            <tr>
                <td>전화번호:</td>
                <td><input type="text" name="phone" value="${user.phone}" required></td>
            </tr>
            <tr>
                <td>이메일:</td>
                <td>
                    <input type="email" name="email" id="email" value="${user.email}" required>
                    <button type="button" id="sendCode">인증 코드 발송</button>
                    <span id="emailVerificationResult"></span>
                </td>
            </tr>
            <tr>
                <td>주소:</td>
                <td><input type="text" name="address" value="${user.address}" required></td>
            </tr>
            <tr>
                <td>인증 코드:</td>
                <td><input type="text" name="verificationCode" id="verificationCode" required></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit" id="submitBtn">수정</button>
                </td>
            </tr>
        </table>
    </form>

    <script>
        let isUserIDChecked = false;
        let isEmailVerified = false;

        $(document).ready(function() {
            // 아이디 중복 체크
            $("#checkUserID").click(function() {
                let userID = $("#userID").val();

                if (userID === "") {
                    alert("아이디를 입력하세요.");
                    return;
                }

                $.ajax({
                    url: "${pageContext.request.contextPath}/checkUserID",
                    type: "POST",
                    data: { userID: userID },
                    success: function(data) {
                        if (data === "사용 가능") {
                            $("#userIDCheckResult").text("사용 가능한 아이디입니다.").css("color", "green");
                            isUserIDChecked = true;
                        } else {
                            $("#userIDCheckResult").text("이미 사용 중인 아이디입니다.").css("color", "red");
                            isUserIDChecked = false;
                        }
                    },
                    error: function(xhr, status, error) {
                        alert("아이디 중복 체크에 실패했습니다.");
                        console.error("Error:", error);
                        console.error("Status:", status);
                        console.error("XHR:", xhr);
                    }
                });
            });

            // 이메일 인증 코드 발송
            $("#sendCode").click(function() {
                let email = $("#email").val();

                if (email === "") {
                    alert("이메일을 입력하세요.");
                    return;
                }

                $.ajax({
                    url: "${pageContext.request.contextPath}/send/code2",
                    type: "POST",
                    data: { email: email },
                    success: function(data) {
                        alert("인증 코드가 발송되었습니다.");
                        $("#emailVerificationResult").text("인증 코드가 발송되었습니다.").css("color", "green");
                        isEmailVerified = true;
                    },
                    error: function(xhr, status, error) {
                        alert("인증 코드 발송에 실패했습니다.");
                        console.error("Error:", error);
                        console.error("Status:", status);
                        console.error("XHR:", xhr);
                    }
                });
            });

            // 폼 제출 시 유효성 검사
            $("#editForm").submit(function(event) {
                if (!isUserIDChecked) {
                    alert("아이디 중복 체크를 완료해주세요.");
                    event.preventDefault(); // 폼 제출 방지
                }

                if (!isEmailVerified) {
                    alert("이메일 인증을 완료해주세요.");
                    event.preventDefault(); // 폼 제출 방지
                }
            });
        });
    </script>
</body>
</html>