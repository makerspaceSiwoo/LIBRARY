<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/css/admin/book/add.css">
<style>
/* 회원가입 h1 태그 중앙 정렬 */
.center-title {
    text-align: center; /* 중앙 정렬 */
    margin-bottom: 10px; /* 아래쪽 여백을 줄임 */
}

.center-subtitle {
    text-align: left; /* 왼쪽 정렬 */
    margin-left: 26.5vw; /* 테이블과 일치하는 위치로 이동 */
    margin-bottom: 5px; /* 아래쪽 여백 추가 */
}

/* 회원정보입력 h5 태그 테이블 왼쪽 위로 이동 */
.table-title {
    text-align: left; /* 왼쪽 정렬 */
    margin-bottom: 10px; /* 테이블과의 간격 조정 */
    margin-left: auto; /* 자동 왼쪽 마진 */
    margin-right: auto; /* 자동 오른쪽 마진 */
    width: 80%; /* 테이블과 같은 너비로 설정 */
    max-width: 800px; /* 테이블과 같은 최대 너비로 설정 */
    padding-left: 10px; /* 필요시 추가 여백 */
}

.container {
    width: 50%;
    margin: 0 auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center; /* 컨테이너 내부 요소 가운데 정렬 */
}
    .container h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
}

.form-table {
    width: 80%; /* 테이블 너비를 80%로 설정 */
    max-width: 800px; /* 테이블 최대 너비 설정 */
    border-collapse: collapse; /* 테두리 겹치기 설정 */
    margin: 0 auto 20px auto; /* 테이블을 가운데 정렬 */
    border: 1px solid #ccc; /* 테이블 전체 테두리 */
}

form th {
    text-align: left; /* 헤더 텍스트를 왼쪽 정렬 */
    padding: 10px;
    background-color: #f2f2f2; /* 헤더 셀에 배경색 추가 */
    border: 1px solid #ccc; /* 헤더 셀 테두리 */
}

form td {
    text-align: left; /* 모든 텍스트를 왼쪽 정렬 */
    vertical-align: middle; /* 수직 정렬을 가운데로 */
}

/* 공통 입력 필드 스타일 */
form td input[type="text"],
form td input[type="password"] {
    width: calc(50% - 10px); /* 입력 필드의 너비를 설정하여 셀을 거의 꽉 채우지 않도록 조정 */
    display: inline-block; /* 인풋 필드를 인라인 블록으로 설정하여 옆에 다른 요소 배치 가능 */
    margin-left: 0; /* 왼쪽 여백 제거 */
    text-align: left; /* 입력된 텍스트를 왼쪽 정렬 */
    padding: 8px 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box; /* 패딩 포함하여 너비 계산 */
    font-size: 20px;
}

/* 성명 입력 필드 스타일 */
form input[name="name"] {
    width: 100%; /* 입력 필드 너비를 100%로 설정하여 테이블 셀을 완전히 채우도록 설정 */
    max-width: 100%; /* 최대 너비를 설정하여 완전히 채워지도록 설정 */
    padding: 8px 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    font-size: 20px;
}

/* 테이블 스타일 */
form table {
    width: 80%; /* 테이블 너비를 80%로 설정 */
    max-width: 800px; /* 테이블 최대 너비 설정 */
    border-collapse: collapse; /* 테두리 겹치기 설정 */
    margin: 0 auto 20px auto; /* 테이블을 가운데 정렬 */
    border: 1px solid #ccc; /* 테이블 전체 테두리 */
}

.table-title {
    position: absolute;
    top: -30px; /* 테이블 위로 이동 */
    left: 0; /* 테이블 왼쪽에 맞춤 */
    font-size: 18px; /* 글꼴 크기 조절 */
}

/* 테이블 행 스타일 */
form table tr {
    margin-bottom: 15px;
    border-bottom: 1px solid #ccc; /* 행 사이에 테두리 추가 */
}


/* 기본적으로 모든 td에 배경색을 적용 */
form table td {
    padding: 10px;
    vertical-align: middle;
    text-align: center; /* 텍스트를 왼쪽 정렬 */
    border: 1px solid #bbb; 
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    font-weight: bold;
}

/* 인풋 태그를 포함하는 td의 배경색 제거 */
form table td input {
    background-color: transparent; /* 배경색을 투명으로 설정 */
}
/* 인풋 태그가 없는 td에만 배경색 적용 */
form table td:not(:has(input)) {
    background-color: #eee; /* 배경색을 #ccc로 설정 */
}


/* 버튼 스타일 */
form button {
    background-color:  #3C33A4;
    color: white;
    padding: 10px 40px; /* 세로 패딩을 10px로 늘려서 버튼의 세로 길이를 늘림 */
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 15px;
    transition: background-color 0.3s ease;
    margin: 0 auto; /* 가운데 정렬 */
    display: block; /* 버튼을 블록 요소로 변경 */
}

/* 버튼 호버 효과 */
form button:hover {
    background-color:  #3C33A4;
}

/* 입력 그룹 스타일 */
.input-group {
    display: flex;
    align-items: center;
}


.input-group select {
    height: 38px; /* 이메일 선택 부분의 높이를 늘리기 위해 설정 */
    padding: 8px 10px; /* padding을 조정하여 높이와 일관성 유지 */
    font-size: 16px; /* 텍스트 크기를 입력 필드와 일치 */
    border-radius: 4px;
    border: 1px solid #ccc;
    box-sizing: border-box; /* 패딩 포함 높이 계산 */
    
}

.input-group button {
    margin-left: 5px; /* 입력 필드와 버튼 간의 간격을 위해 왼쪽 마진 추가 */
    padding: 8px 10px; /* 버튼 패딩 조정 */
    font-size: 15px; /* 버튼 폰트 크기 조정 */
}

/* 생년월일 입력 필드의 플레이스홀더 스타일 */
.input-group input::placeholder {
    font-size: 14px; /* 플레이스홀더 글자 크기를 줄임 */
    color: #888; /* 필요한 경우, 플레이스홀더 색상도 변경할 수 있음 */
}

.input-group input[type="text"] {
    margin-right: 10px; /* 인풋 필드와 @ 선택 박스 사이의 간격을 10px로 설정 */
}

/* 에러 메시지 스타일 */
div[style*="color: red;"] {
    margin-bottom: 20px;
    font-weight: bold;
}

/* 인증 코드 결과 및 아이디 중복 체크 결과 스타일 */
#userIDCheckResult,
#emailVerificationResult {
    margin-top: 10px;
    font-size: 14px;
}

/* 인증 코드 입력 필드 스타일 */
#verificationCode {
    width: 100%; /* 입력 필드 너비를 100%로 설정 */
    padding: 8px 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    text-align: center; /* 입력 내용 가운데 정렬 */
}

.password-hint,
.phone-hint {
    font-size: 12px; /* 글씨 크기를 작게 설정 */
    color: #888; /* 연한 회색으로 설정 */
    vertical-align: middle; /* 설명 문구를 입력 필드와 수직으로 가운데 정렬 */
    margin-left: 5px; /* 인풋 필드와 설명 문구 사이에 여백 추가 */
}

</style>

</head>
<body>
<nav>
   <c:choose>
         <div id="adminmenu" class="menu">
            <a href="/home"><img src="/logo/logo.png"></a>
            <div class="menulist">
	            <a href="/home">도서관 홈</a>
	            <a href="/search">도서 검색</a>
	            <a href="/recomm">추천 도서</a>
	            <a href="/board/search">게시판</a>
	            <a href="/mypage">마이 페이지</a>
            </div>
            
         </div>
   </c:choose>
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
    <button type="submit" class="btn btn-primary">가입완료</button>
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
    /*    function submitForm() {
         var password = document.querySelector('input[name="userPW"]').value;
        var confirmPassword = document.querySelector('input[name="confirm_password"]').value;

        if (password !== confirmPassword) {
            alert("비밀번호가 일치하지 않습니다.");
            return false; // 폼 제출 중단
        }

        return true; // 폼 제출 허용
    } */
    function submitForm() {
    	console.log("submit"+isUserIDChecked)
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
        if(!isUserIDChecked){
        	 alert("사용할 수 없는 아이디입니다. 아이디 중복 확인 하세요.");
             return false; // 폼 제출 중단
        }
        if(!isMemcheck){
       	 alert("이메일 인증이 되지 않았습니다.");
            return false; // 폼 제출 중단
       }
        return true; // 폼 제출 허용
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
</body>
</html>

