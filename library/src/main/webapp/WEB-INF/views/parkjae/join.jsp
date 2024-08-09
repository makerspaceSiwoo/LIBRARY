<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
    h2 {
        display: inline-block;
        border: 1px solid #ddd;
        padding: 8px;
    }
    .button {
        background-color: #4CAF50;
        color: white;
        cursor: pointer;
    }
    h1 {
        display: flex;
        align-items: center; /* 수직 중앙 정렬 */
        justify-content: center; /* 수평 중앙 정렬 */
    }
    #endinfo {
        display: flex;
        align-items: center; /* 수직 중앙 정렬 */
        justify-content: center; /* 수평 중앙 정렬 */
    }
    table {
        border-collapse: collapse;
        width: 100%;
    }
    table {
        border: 1px solid black;
    }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function() {
    function checkDuplicate() {
        // 아이디 입력 필드의 값을 가져옵니다.
        var userId = document.querySelector('input[name="userId"]').value;

        if (userId === "") {
            alert("아이디를 입력하세요.");
            return;
        }

        // AJAX를 사용하여 서버에 중복 체크 요청을 보냅니다.
        $.ajax({
            url: '/checkId', // 서버의 중복 체크 엔드포인트 URL
            type: 'POST',
            data: { userID: userId }, // userId 변수 전달
            success: function(response) {
                if (response.status === "duplicate") {
                    alert("아이디가 중복되었습니다.");
                } else {
                    alert("사용 가능한 아이디입니다.");
                }
            },
            error: function() {
                alert("중복 확인 중 오류가 발생했습니다.");
            }
        });
    }

    // 이벤트 핸들러 등록
    $('button[onclick="checkDuplicate()"]').on('click', checkDuplicate);
});
    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                // 예제를 참고하여 다양한 활용법을 확인해 보세요.
                document.querySelector('input[name="address"]').value = data.address;
            }
        }).open();
    }
    function submitForm() {
        var password = document.querySelector('input[name="userPW"]').value;
        var confirmPassword = document.querySelector('input[name="confirm_password"]').value;

        if (password !== confirmPassword) {
            alert("비밀번호가 일치하지 않습니다.");
            return false; // 폼 제출 중단
        }

        return true; // 폼 제출 허용
    }
    function submitForm() {
        var password = document.querySelector('input[name="userPW"]').value;
        var confirmPassword = document.querySelector('input[name="confirm_password"]').value;

        // 비밀번호 유효성 검사
        var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
        if (!passwordPattern.test(password)) {
            alert("비밀번호는 최소 8자 이상이며, 대문자, 소문자, 숫자, 특수기호를 포함해야 합니다.");
            return false; // 폼 제출 중단
        }

        if (password !== confirmPassword) {
            alert("비밀번호가 일치하지 않습니다.");
            return false; // 폼 제출 중단
        }

        return true; // 폼 제출 허용
    }
    function requestVerificationCode() {
        var email = document.querySelector('input[name="email_user"]').value + "@" +
                    document.querySelector('select[name="email_domain"]').value;

        $.ajax({
            url: '/send',
            type: 'POST',
            data: { "emailAddress": email },
            success: function(response) {
            	num = response[0];
                alert("인증 코드가 발송되었습니다.");
            },
            error: function() {
                alert("인증 코드 발송에 실패했습니다.");
            }
        });
    }
    function memcheck(){
    	let numnum = document.querySelector("#numnum").value;
    	if(num==numnum){
    		alert("인증 코드가 일치합니다.");
    	}else {
    		alert("인증코드를 다시 확인해 주세요");
    	}
    }
  
</script>
</head>
<body>
<div>
    <h2>(사진)솔데스크 도서관</h2>
    <h2>도서관 HOME</h2>
    <h2>도서 검색</h2>
    <h2>인기 도서</h2>
    <h2>MY 페이지</h2>
    <h2>나눔 마당</h2>
    <button class="button" onclick="">로그인</button>
    <button class="button" onclick="">회원가입</button>
</div>
<h1>회원가입</h1>
<h5>회원정보입력</h5>
<form action="/user/register" method="post" onsubmit="return submitForm()">
    <table>
        <tr>
            <td>성 명</td>
            <td><input type="text" name="name" required></td>
            <td>생년월일</td>
            <td>
                 <input type="text" name="year" placeholder="연도 (예: 1990)" required pattern="\d{4}" title="4자리 연도를 입력하세요">
       			 <input type="text" name="month" placeholder="월 (예: 07)" required pattern="[0-1]?[0-9]" title="1에서 12 사이의 월을 입력하세요">
        		 <input type="text" name="day" placeholder="일 (예: 15)" required pattern="[0-3]?[0-9]" title="1에서 31 사이의 일을 입력하세요">
            </td>
        </tr>
        <tr>
            <td>아이디</td>
            <td colspan="3">
                <input type="text" name="userId" required> 
                <button type="button" onclick="checkDuplicate()">중복확인</button>
            </td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td colspan="3"><input type="password" name="userPW" required></td>
        </tr>
        <tr>
            <td>비밀번호 확인</td>
            <td colspan="3"><input type="password" name="confirm_password" required></td>
        </tr>
        <tr>
            <td>휴대폰</td>
            <td colspan="3"><input type="text" name="phone" required></td>
        </tr>
        <tr>
            <td>이메일</td>
            <td colspan="3">
                <input type="text" name="email_user" required>
                <select name="email_domain" required>
                    <option value="">선택</option>
                    <option value="naver.com">naver.com</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="daum.net">daum.net</option>
                    <option value="hanmail.net">hanmail.net</option>
                    <option value="nate.com">nate.com</option>
                    <option value="kakao.com">kakao.com</option>
                    <option value="yahoo.com">yahoo.com</option>
                    <option value="hotmail.com">hotmail.com</option>
                    <option value="outlook.com">outlook.com</option>
                    <option value="icloud.com">icloud.com</option>
                </select>
                <button type="button" onclick="requestVerificationCode()">인증요청</button>
            </td>
        </tr>
        <tr>
        	<td>인증번호</td>
        	<td><input type="text" name="email_check" required id = "numnum">
        	<button type="button" onclick="memcheck()">확인</button></td>
        </tr>
        <tr>
            <td>주소</td>
            <td colspan="3">
                <input type="text" name="address" required> <button type="button" onclick="searchAddress()">주소찾기</button>
             
            </td>
        </tr>
        <tr>
            <td>성별</td>
            <td colspan="3">
                <select name="gender" required>
                    <option value="M">남성</option>
                    <option value="F">여성</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <button type="submit" class="btn btn-primary">가입완료</button>
                <button type="reset">초기화</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>

