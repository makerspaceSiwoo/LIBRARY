<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>


<link rel="stylesheet" type="text/css" href="/css/mo/searchresult.css">
<link rel="stylesheet" type="text/css" href="/css/header.css">
<style>
/* 테이블 스타일 */
.content-container table {
    width: 100%;
    margin-bottom: 20px; /* 테이블과 버튼 사이의 여백 */
}

.button-container2 {
	display: flex;
    justify-content: center;
    align-items: center;
}

/* 버튼 컨테이너 스타일 */
.button-container2 button {
	
    margin: 5px;
    padding: 10px 20px;
    font-size: 16px;
    background-color: #3C33A4;; /* 버튼 배경색 */
    color: white; /* 버튼 글자색 */
    border: none; /* 버튼 테두리 제거 */
    border-radius: 5px; /* 버튼 테두리 둥글게 */
    cursor: pointer;
    transition: background-color 0.3s ease;
    min-width: 150px; /* 가장 긴 버튼을 기준으로 최소 너비 설정 */
}

/* 버튼 크기를 같게 하기 위해 최장 버튼의 너비에 맞춰 조정 */
.button-container2 button {
    width: auto; /* 내용에 따라 버튼 크기 조정 */
    display: inline-block; /* 버튼들이 나란히 배치되도록 설정 */
}

/* 버튼 호버 스타일 */
.button-container2 button:hover {
	font-weight: bold;
    background-color: #2c2578;
}

/* readonly input field 기본 스타일 */
input[readonly] {
    background-color: #f0f0f0; /* 배경 색상을 수정 */
    color: #333; /* 텍스트 색상 */
    border: 1px solid #ccc; /* 테두리 */
    cursor: default; /* 기본 커서로 변경 */
}


</style>
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


<section>
<div>
		<div>
			<h2 id ="title">도서 정보 수정/삭제</h2>
		</div>
		<div>
			<form action="/book/manage" id="modform">
				<input type="text" name="booktitle" placeholder="제목 입력...">
				<input type="submit" value="검색"/>
			</form>
		</div>
</div>
</section>


<div class="content-container">
		<span id="bookimg">
			<img alt="표지사진" src="${book.img }" width="200">
		</span>
		<span id="bookinfo">
			<table border="1">
				<tr>
					<td colspan="3" align="center">제목</td>
				</tr>
				<tr>
					<td colspan="3" align="center">${book.booktitle }</td>
				</tr>
				<tr>
					<td align="center">저자</td > <td align="center">출판사</td> <td align="center">출판연도</td>
				</tr>
				<tr>
					<td align="center">${book.author}</td> <td align="center">${book.publisher}</td> <td align="center">${book.pubyear }</td>
				</tr>
			</table>
		</span>
	<hr>
</div>

<div class="content-container">
<form id="modifyForm" method="post">
	<table border="1">
		<tr>
			<td>관리 번호</td>
			<td>책 이름</td>
			<td>저자</td>
			<td>청구기호</td>
			<td>출판사</td>
			<td>출판연도</td>
			<td>표지사진</td>
		</tr>
		<tr>
			<td>
				
				<input id="bookno" name="bookno" value="${book.bookno }" readonly>
			</td>
			<td>
				<input id="booktitle" name="booktitle" value="<c:out value='${book.booktitle}'/>">
			</td>
			<td>
				<input id="author" name="author" value="<c:out value='${book.author}'/>">
			</td>
			<td>
				<input id="callno" name="callno" value="<c:out value='${book.callno}'/>">
			</td>
			<td>
				<input id="publisher" name="publisher" value="<c:out value='${book.publisher}'/>">
			</td>
			<td>
				<input id="pubyear" type="number" name="pubyear" value="<c:out value='${book.pubyear}'/>">
			</td>
			<td>
				<input id="img" name="img" value="<c:out value='${book.img}'/>">
			</td>
		</tr>
		<tr>
		<td colspan="7">
			<div class="button-container2">
            	<button type="button" onclick="modify2();">수정</button>
            	<button type="button" onclick="return del1();">삭제</button>
            	<button type="button" onclick="return history.back();">목록으로 돌아가기</button>
        	</div>
        </td>
		</tr>
	</table>		
</form>
</div>

<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>

</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

function del1() {
	let result = confirm("DB에서 삭제하시겠습니까?");
	if(result){
		 $.ajax({
		        url: "/book/del",
		        method: "delete",
		        data : {bookno : ${book.bookno}}
		    }).done(function (data) {
					alert("삭제되었습니다.");
			    	location.href="/book/manage";
		    });
	}else{
	    alert("취소되었습니다.");
	}
};

function modify2(){
	let updatedBookDTO = {
			bookno: $('#bookno').val(), // 기존 객체를 복사
		    booktitle: $('#booktitle').val(),
		    author: $('#author').val(),
		    callno: $('#callno').val(),
		    publisher: $('#publisher').val(),
		    pubyear: $('#pubyear').val(),
		    img: $('#img').val(),
		    
		};
	
	$.ajax({
        url: "/book/mod",
        method: "post",
        data: JSON.stringify(updatedBookDTO),
        contentType: 'application/json; charset=utf-8'
    }).done(function (data) {
	    	alert("수정되었습니다.");
	    	location.replace("/book/mod?bookno="+${book.bookno});
    	
    });
	
}


</script>
</html>