<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/pjh/join.css">

</head>
<body>
<nav>
         <div id="usermenu" class="menu">
            <a href="/home"><img src="/logo/logo.png"></a>
            <div class="menulist">
               <a href="/home">도서관 홈</a>
               <a href="/search">도서 검색</a>
               <a href="/recomm">추천 도서</a>
               <a href="/board/search">게시판</a>
               <a href="/user/mypage">마이 페이지</a>
            </div>
            <div class="button-container">
               <c:choose>
                  <c:when test="${empty user or empty user.userID}">
                     <button id="joinbutton" onclick="location.href='/join';">회원 가입</button>
                     <button id="loginbutton" onclick="location.href='/login';">로그인</button>
                  </c:when>
                  <c:otherwise>
                     <p>${user.userID }님</p>
                     <form action="/logout" method="post">
                        <button id="logoutbutton">로그아웃</button>
                     </form>
                  </c:otherwise>
               </c:choose>
           </div>
         </div>
   <hr>
</nav>
<!-- 회원가입 h1 태그 -->
<h1 class="center-title">회원가입</h1>

<!-- 회원정보입력 h5 태그 -->
<h5 class="center-subtitle">회원정보입력</h5>

<form action="/user/register" method="post" onsubmit="return submitForm()">
    <table class="form-table">
        <tr>
    		<td>성 명</td>
			<td><input name="name" class="name-input" required></td>
   			 <td>생년월일</td>
   		 <td>
       		<div class="input-group">
            	<input type="text" name="year" placeholder="연도 (예: 1990)" required pattern="\d{4}" title="4자리 연도를 입력하세요">
           		<input type="text" name="month" placeholder="월 (예: 07)" required pattern="[0-1]?[0-9]" title="1에서 12 사이의 월을 입력하세요">
           		<input type="text" name="day" placeholder="일 (예: 15)" required pattern="[0-3]?[0-9]" title="1에서 31 사이의 일을 입력하세요">
     		 </div>
    		</td>
		</tr>

        <tr>
    	<td>아이디</td>
   		 <td colspan="3">
        <div class="input-group">
            <input type="text" name="userID" id="userID" required>
            <button type="button" id="checkID">중복확인</button>
            <span id="userIDCheckResult"></span>
        </div>       
    </td>
</tr>
      <tr>
    <td>비밀번호</td>
    <td colspan="3">
    	<div class="input-group">
        <input type="password" name="userPW" required>
        <small class="password-hint">* 영문자(대,소문자), 숫자, 특수문자를 모두 혼합하여 8자리 이상</small>
    	</div>   
    </td>
</tr>
<tr>
    <td>비밀번호 확인</td>
    <td colspan="3">
    <div class="input-group">
        <input type="password" name="confirm_password" required>
        <small class="password-hint">* 비밀번호 확인을 위해 다시 한번 입력하세요</small>
    </div>
    </td>
</tr>
       
 <tr>
    <td>휴대폰</td>
    <td colspan="3">
    <div class="input-group">
        <input type="text" name="phone" required>
        <small class="phone-hint">* 숫자만 입력하세요. 예: 01012345678</small>
  	</div>
    </td>
</tr>

        <tr>
    <td>이메일</td>
    <td colspan="3">
        <div class="input-group">
            <input type="text" name="email_user" required>
                @<select name="email_domain" required>
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
        </div>
    </td>
</tr>
        <tr>
    <td>인증번호</td>
    <td colspan="3">
        <div class="input-group">
            <input type="text" name="email_check" required id="numnum">
            <button type="button" onclick="memcheck()">확인</button>
        </div>
    </td>
</tr>
     <tr>
    <td>주소</td>
    <td colspan="3">
        <div class="input-group">
            <input type="text" name="address" required>
            <button type="button" onclick="searchAddress()">주소찾기</button>
            <label for="male" style="margin-left: 20px;">성별:</label>
            <input type="radio" id="male" name="gender" value="M" required>
            <label for="male">남성</label>
            <input type="radio" id="female" name="gender" value="F" required>
            <label for="female">여성</label>
        </div>
    </td>
</tr>
        
    </table>
    <button type="submit" name="lastjoin" class="primary" onclick="finish()">가입완료</button>
</form>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	let num = null;
	let isUserIDChecked = false;
	let isMemcheck=false;

$(document).ready(function() {
    const contextPath = "${pageContext.request.contextPath}";
    let originalUserID = "${originalUserID}";
   
    $("#checkID").click(function() {
        let userID = $("#userID").val();

        if (userID === "") {
            alert("아이디를 입력하세요.");
            return;
        }

        $.ajax({
        	url: "/checkID",
            type: "POST",
            data: { userID: userID },
            success: function(data) {
            	if (data == '1') {  
                    $("#userIDCheckResult").text("사용 가능한 아이디입니다.").css("color", "green");
                    isUserIDChecked = true;
                } else { 
                    $("#userIDCheckResult").text("이미 사용 중인 아이디입니다.").css("color", "red");
                    isUserIDChecked = false;
                }
            	console.log(isUserIDChecked)
            },
            error: function(xhr, status, error) {
                alert("아이디 중복 체크에 실패했습니다.");
                console.error("Error:", error);
                console.error("Status:", status);
                console.error("XHR:", xhr);
            }
        });
    });


});
    function searchAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.querySelector('input[name="address"]').value = data.address;
            }
        }).open();
    }
   
    function submitForm() {
    	console.log("submit"+isUserIDChecked)
    	var password = document.querySelector('input[name="userPW"]').value;
        var confirmPassword = document.querySelector('input[name="confirm_password"]').value;

        // 비밀번호 유효성 검사
        var passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
        if (!passwordPattern.test(password)) {
            alert("비밀번호는 최소 8자 이상이며, 대문자, 소문자, 숫자, 특수기호를 포함해야 합니다.");
            return false; // 폼 제출 중단
        }else if (password !== confirmPassword) {
            alert("비밀번호가 일치하지 않습니다.");
            return false; // 폼 제출 중단
        }else if(!isUserIDChecked){
        	 alert("사용할 수 없는 아이디입니다. 아이디 중복 확인 하세요.");
             return false; // 폼 제출 중단
        }else if(!isMemcheck){
       		 alert("이메일 인증이 되지 않았습니다.");
            return false; // 폼 제출 중단
       }else{
       		alert("회원가입이 완료되었습니다!");
        	return true; // 폼 제출 허용
       }
    }
    function requestVerificationCode() {
        // 이메일 입력 필드와 도메인 선택 필드의 값을 가져옴
        var emailUser = document.querySelector('input[name="email_user"]').value.trim();
        var emailDomain = document.querySelector('select[name="email_domain"]').value.trim();
        // 이메일 주소를 결합
        var email = emailUser + "@" + emailDomain;
        // 이메일 입력 필드와 도메인 선택 필드에 공백이 있거나 비어있는 경우
        if (emailUser === "" || emailDomain === "") {
            alert("이메일 주소를 올바르게 입력해 주세요.");
            return; // 입력이 잘못된 경우 함수 실행을 멈춤
        }
        
        // AJAX 요청을 통해 인증 코드를 발송
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
    	
    	if(num == null){
    		alert("먼저 인증 요청을 해 주십시오.");
    	}
    	
    	else if(num==numnum){
    		alert("인증 코드가 일치합니다.");
    		isMemcheck = true;
    		 // 입력 필드를 수정할 수 없도록 비활성화
            document.querySelector("#numnum").disabled = true;
    	}else if(num!=numnum) {
    		alert("인증코드를 다시 확인해 주세요.");
    	}else{
    		alert("먼저 인증 요청을 해 주십시오.");
    	}
   
    	
  
    }
    

  
</script>
<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>
</body>
</html>

