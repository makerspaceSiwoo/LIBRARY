<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/admin/book/manage.css">
<link rel="stylesheet" type="text/css" href="/css/header.css">
<style>
html {
   height: 100%;
}

body {
   min-height:100vh;
   height: auto;
   position: relative;
}

main {
    flex: 1; /* 남은 공간을 차지하도록 설정 */
    display: flex;
    flex-direction: column;
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
<main>
<section>

		<div style="margin-left: 2.1vw;">
			<h1>도서 정보 수정/삭제</h1>
		</div>
		<div>
			<form id="modform">
				<input type="text" name="booktitle" placeholder="제목 입력...">
				<button>검색</button>
			</form>
		</div>
</section>
<table id="targetlist" border="1"  style="width: 90%; margin: 0 auto; ">
			<tr>
				<td colspan="6" align="center">검색한 책 목록</td>
			</tr>
			<tr>
				<td>책 이름</td>
				<td>저자</td>
				<td>청구기호</td>
				<td>출판사</td>
				<td>출판연도</td>
				<td>수정/삭제</td>
			</tr>
			<c:if test="${fn:length(blist) == 0 }">
			<tr><td colspan="6" align="center">검색 결과가 없습니다.</td></tr>
			</c:if>
			<c:if test="${fn:length(blist) != 0 }">
				<c:forEach var="book" items="${blist }">
					<tr>
						<td>${book.booktitle }</td>
						<td>${book.author }</td>
						<td>${book.callno }</td>
						<td>${book.publisher }</td>
						<td>${book.pubyear}</td>
						<td>
							<button onclick="location.href='/book/mod?bookno=${book.bookno}'">수정/삭제</button>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>

	 <div id="page">
				<c:if test="${begin > pageNum }">
					<a href="/book/manage?booktitle=${booktitle }&p=${begin-1 }" class="page prv">&lt;</a>
				</c:if>
				<c:forEach begin="${begin }" end="${end}" var="i">
	       
					<c:choose>
            			<c:when test="${i == current}">
                		<a class="active" href="/book/manage?booktitle=${booktitle }&p=${i}">${i}</a>
            			</c:when>
            			<c:otherwise>
                 		<a href="/book/manage?booktitle=${booktitle }&p=${i}">${i}</a>
            			</c:otherwise>
        			</c:choose>

				</c:forEach>
				<c:if test="${end < totalPages }">
					<a href="/book/manage?callno=${callno }&p=${end+1}" class="page next">&gt;</a>
				</c:if>
	</div>

</main>
<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

</script>
</html>