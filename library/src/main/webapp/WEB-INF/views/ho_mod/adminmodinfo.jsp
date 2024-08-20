<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                    <input type="text" name="userID" id="userID" value="${user.userID}">
                    <button type="button" id="checkUserID">중복 체크</button>
                    <span id="userIDCheckResult"></span>
                </td>
            </tr>
            <tr>
                <td>비밀번호:</td>
                <td><input type="password" name="userPW" id="userPW" value="${user.userPW}"></td>
            </tr>
            <tr>
                <td>이름:</td>
                <td><input type="text" name="name" value="${user.name}"></td>
            </tr>
            <tr>
                <td>생년월일:</td>
                <td>
                    <fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" var="formattedBirth" />
                    <input type="date" name="birth" value="${formattedBirth}" />
                </td>
            </tr>
            <tr>
                <td>전화번호:</td>
                <td><input type="text" name="phone" value="${user.phone}"></td>
            </tr>
            <tr>
                <td>이메일:</td>
                <td>
                    <input type="email" name="email" id="email" value="${user.email}">
                    <button type="button" id="sendCode">인증 코드 발송</button>
                    <span id="emailVerificationResult"></span>
                </td>
            </tr>
            <tr>
                <td>주소:</td>
                <td><input type="text" name="address" value="${user.address}"></td>
            </tr>
            <tr>
                <td>인증 코드:</td>
                <td><input type="text" name="verificationCode" id="verificationCode"></td>
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
        let originalUserID = "${user.userID}"; // 초기 아이디 값 저장
        let originalEmail = "${user.email}"; // 초기 이메일 값 저장
        let isEmailChanged = false;

        $(document).ready(function() {
            // admin 값을 JSP에서 가져옴
            let admin = ${user.admin};  // 서버에서 전달된 admin 값 사용

            // admin이 0이면 아이디와 비밀번호 필드를 비활성화
            if (admin === 0) {
                $("#userID").prop("disabled", true);
                $("#userPW").prop("disabled", true);
            }

            // 아이디 변경 시 중복 체크 상태 초기화
            $("#userID").on('change', function() {
                isUserIDChecked = false;
                $("#userIDCheckResult").text("");
            });

            // 이메일 변경 시 인증 확인 초기화
            $("#email").on('change', function() {
                isEmailChanged = true;
                isEmailVerified = false; // 이메일 변경 시 인증을 요구하도록 설정
                $("#emailVerificationResult").text("");
            });

            // 아이디 중복 체크
            $("#checkUserID").click(function() {
                let userID = $("#userID").val();

                if (userID === "") {
                    alert("아이디를 입력하세요.");
                    return;
                }

                if (userID === originalUserID) {
                    alert("아이디가 변경되지 않았습니다.");
                    isUserIDChecked = true;
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
                        isEmailVerified = true; // 인증 코드 발송 후 확인
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
                // 아이디가 변경되었으면 중복 체크를 통과해야 함
                if ($("#userID").val() !== originalUserID && !isUserIDChecked) {
                    alert("아이디 중복 체크를 완료해주세요.");
                    event.preventDefault(); // 폼 제출 방지
                    return;
                }

                // 이메일 필드가 변경되었으면 이메일 인증 확인
                if (isEmailChanged && !isEmailVerified) {
                    alert("이메일 인증을 완료해주세요.");
                    event.preventDefault(); // 폼 제출 방지
                    return;
                }
            });
        });
    </script>
</body>
</html>