<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script>
function withdrawUser() {
	if(${user.userno == 1}){
		alert("해당 계정은 마스터 계정이므로 탈퇴가 불가합니다.");
	}else{
	    if (confirm("정말로 탈퇴하시겠습니까?")) {
	        fetch('<c:url value="/user/del" />', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded'
	            },
	            body: new URLSearchParams({
	                userno: ${user.userno}
	            })
	        }).then(response => {
	            if (response.ok) {
	                alert('회원 탈퇴가 완료되었습니다.');
	                window.location.href = '<c:url value="/login" />'; // 로그인 페이지로 리다이렉트
	            } else {
	                alert('회원 탈퇴에 실패했습니다. 상태 코드: ' + response.status);
	            }
	        }).catch(error => {
	            alert('오류가 발생했습니다.');
	            console.error('Error:', error);
	        });
	    }
	}
}
</script>
<title>사서 페이지</title>
<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/ho/adminpage.css">
</head>
<body>
	<nav>

      <c:choose>
      <c:when test="${user.admin == 1 }">
         <div id="adminmenu" class="menu">
            <a href="/home"><img src="/logo/logo.png"></a>
            <div class="menulist">
	            <a href="/home">도서관 홈</a>
	            <a href="/book/record">대출/반납</a>
	            <a href="/book/add">도서 추가</a>
	            <a href="/book/manage">도서 수정/삭제</a>
	            <a href="/board/search">게시판</a>
	            <a href="/admin/mypage">사서 페이지</a>
	            <a href="/admin/blacklist">유저 관리</a>
            </div>
            <div class="button-container">
	            <c:choose>
	               <c:when test="${empty user or empty user.userID}">
	                  <button id="loginbutton" onclick="location.href='/login';">로그인</button>
	               </c:when>
	               <c:otherwise>
	                  <p>${user.userID }님</p>
	                  <form action="/logout" method="post">
	                     <button id="logoutbutton" >로그아웃</button>
	                  </form>
	               </c:otherwise>
	            </c:choose>
	        </div>
         </div>
      </c:when>
      </c:choose>
      <hr>
</nav>
	<h3 class="tit" id="all">최근 6개월 대여 상위 도서</h3>
	<div class="section">
    <hr id="smallline">
    <div class="book-list">
        <c:forEach var="all" items="${allrc}" varStatus="status">
            <div class="book-item">
                <span class="rank" style="width:2%;">
                    <p>${status.index+1 }</p>
                </span>
                <img alt="표지사진" src="${all.img}" class="book-cover">
                <div class="book-info">
                    <div class="title">${all.booktitle}</div>
                    <div class="author">${all.author}</div>
                    <div class="publisher">${all.publisher}</div>
                    
                </div>
                <div class="ct">대여 횟수<br>
                    ${all.ct}회</div>
            </div>
        </c:forEach>
    </div>
</div>
<div class="button-containers">
    <form action="/user/mod" method="get">
        <button style="color:#fff">계정정보 수정</button>
    </form>
    <form action="/admin/new/form">
        <button style="color:#fff">사서계정 추가</button>
    </form>
    <button style="color:#fff" class="deldel" onclick="withdrawUser()">사서 탈퇴</button>
</div>
<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>
</body>
</html>