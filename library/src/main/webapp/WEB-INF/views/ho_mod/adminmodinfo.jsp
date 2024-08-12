<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            let idAvailable = false; // ID 중복 여부를 저장할 변수
            let verificationCode = ""; // 인증 코드 저장 변수
            let isCodeVerified = false; // 인증 코드 확인 여부
            const isAdmin = '${user.admin}' === '1'; // 세션의 admin 값 확인

            function showAlert(message) {
                alert(message);
            }

            function validateForm() {
                const requiredFields = ["#userID", "#userPW", "#email", "#name", "#gender", "#birth", "#phone", "#address"];
                const datePattern = /^\d{4}-\d{2}-\d{2}$/;

                if (requiredFields.some(id => $(id).val() === "")) {
                    showAlert("모든 정보를 입력해 주세요.");
                    return false;
                }

                if (!datePattern.test($("#birth").val())) {
                    showAlert("Birth 필드는 yyyy-MM-dd 형식이어야 합니다.");
                    return false;
                }

                if (!idAvailable) {
                    showAlert("ID가 중복되었습니다. 다른 ID를 입력해 주세요.");
                    return false;
                }

                if (!isAdmin && !isCodeVerified) {
                    showAlert("인증 코드를 확인해 주세요.");
                    return false;
                }

                return true;
            }

            function ajaxPost(url, data, onSuccess, onError) {
                $.ajax({ url, type: 'POST', data, success: onSuccess, error: onError });
            }

            $('#checkIdButton').click(function(e) {
                e.preventDefault();
                const userId = $("#userID").val();
                if (!userId) return showAlert("아이디를 입력하세요.");

                ajaxPost('${pageContext.request.contextPath}/checkId', { userID: userId }, function(response) {
                    idAvailable = response.status !== "duplicate";
                    showAlert(idAvailable ? "사용 가능한 아이디입니다." : "아이디가 중복되었습니다.");
                }, function() {
                    showAlert("중복 확인 중 오류가 발생했습니다.");
                });
            });

            $('#requestCodeForm').submit(function(e) {
                e.preventDefault();
                ajaxPost('${pageContext.request.contextPath}/send/code', { email: $('#email').val() }, function(response) {
                    verificationCode = response;
                    showAlert("인증 코드가 발송되었습니다.");
                }, function() {
                    showAlert("인증 코드 발송에 실패했습니다.");
                });
            });

            $('#verifyCodeForm').submit(function(e) {
                e.preventDefault();
                isCodeVerified = $('#verificationCode').val() === verificationCode;
                showAlert(isCodeVerified ? "인증이 완료되었습니다." : "인증 코드가 잘못되었습니다.");
            });

            $('form').submit(function(e) {
                if (!validateForm()) e.preventDefault();
            });
        });
    </script>
</head>
<body>
    <h1><font color="blueviolet">정보 변경</font></h1>

    <c:if test="${user.admin == 0}">
        <form id="requestCodeForm">
            <label for="email">이메일:</label>
            <input type="email" id="email" name="email" required />
            <button type="submit">인증 코드 요청</button>
        </form>

        <form id="verifyCodeForm" style="margin-top: 20px;">
            <label for="verificationCode">인증 코드:</label>
            <input type="text" id="verificationCode" name="verificationCode" required />
            <button type="submit">확인</button>
        </form>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/mod/info" method="post">
        <input type="hidden" name="userno" value="${user.userno}" />
        <label for="userID">아이디:</label>
        <input type="text" id="userID" name="userID" value="" required />
        <button type="button" id="checkIdButton">ID 중복 확인</button><br />
        
        <label for="userPW">비밀번호:</label>
        <input type="password" id="userPW" name="userPW" value="" /><br />
        
        <label for="name">닉네임:</label>
        <input type="text" id="name" name="name" value="" /><br />
        
        <label for="gender">성별 (남/여):</label>
        <input type="text" id="gender" name="gender" value="" /><br />
        
        <label for="birth">생년월일 (yyyy-MM-dd):</label>
        <input type="text" id="birth" name="birth" value="반드시 형식에 맞춰주세요." required /><br />
        
        <label for="phone">번호:</label>
        <input type="text" id="phone" name="phone" value="" /><br />
        
        <label for="address">주소:</label>
        <input type="text" id="address" name="address" value="" /><br />
        
        <button type="submit">정보 변경</button>
    </form>
</body>
</html>