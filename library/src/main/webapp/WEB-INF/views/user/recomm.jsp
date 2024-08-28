<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>도서 추천 페이지</title>
    <link rel="stylesheet" type="text/css" href="/css/header.css">
    <link rel="stylesheet" type="text/css" href="/css/mo/recomm.css">
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
	            <a href="/mypage">마이 페이지</a>
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

	<aside>
		<nav>
			<div class="navbar">
			    <a href="#all">전체</a>
			    <a href="#category">카테고리별 맞춤 추천 도서</a>
			    <a href="#gender">
			        <c:if test="${user.gender == 'M'}">남성 추천 도서</c:if>
			        <c:if test="${user.gender == 'F'}">여성 추천 도서</c:if></a>
			    <a href="#agegroup">${agerc[0].agegroup}대 추천 도서</a>
			</div>
		</nav>
	</aside>

	
	<h3 class="title">${user.userID}님 추천 도서</h3>
	
	<div class="section">
	    <h3 class= "tit" id="all">전체</h3>
	    <hr id= "smallline">
	    <div class="book-list">
	    <table>
	        <c:forEach var="all" items="${allrc}" varStatus="status">
	            <div class="book-img" onclick="location.href='/search/no=${all.callno}'">
	                <span class="rank">
		         		<p>${status.index+1 }</p>
		         	</span>
	                <img alt="표지사진" src="${all.img}">
			                <div class="title">${all.booktitle}</div><br>
			                <div class="author">${all.author}</div><br>
			                <div class="publisher">${all.publisher}</div>
		                </div>
		         
	        </c:forEach>
	        </table>
	    </div>
	</div>
	
	<div class="section">
	    <h3 class= "tit" id="category">${user.userID}님 맞춤 카테고리별 추천 도서</h3>
	    <hr id= "smallline">
	    <div class="book-list">
	        <c:forEach var="cate" items="${caterc}" varStatus="status">
	            <div class="book-img" onclick="location.href='/search/no=${cate.callno}'">
	                <span class="rank">
		         		<p>${status.index+1 }</p>
		         	</span>
	                <img alt="표지사진" src="${cate.img}">
	                <div class="title">${cate.booktitle}</div><br>
	                <div class="author">${cate.author}</div><br>
	                <div class="publisher">${cate.publisher}</div>
	            </div>
	        </c:forEach>
	    </div>
	</div>
	
	<div class="section">
	    <h3 class= "tit" id="gender">
	        <c:if test="${user.gender == 'M'}">남성 추천 도서</c:if>
	        <c:if test="${user.gender == 'F'}">여성 추천 도서</c:if>
	    </h3>
	    <hr id= "smallline">
	    <div class="book-list">
	        <c:forEach var="gen" items="${genrc}" varStatus="status">
	            <div class="book-img" onclick="location.href='/search/no=${gen.callno}'">
	                <span class="rank">
		         		<p>${status.index+1 }</p>
		         	</span>
	                <img alt="표지사진" src="${gen.img}">
	                <div class="title">${gen.booktitle}</div><br>
	                <div class="author">${gen.author}</div><br>
	                <div class="publisher">${gen.publisher}</div>
	            </div>
	        </c:forEach>
	    </div>
	</div>
	
	<div class="section">
	    <h3 class= "tit" id="agegroup">${agerc[0].agegroup}대 추천 도서</h3>
	    <hr id= "smallline">
	    <div class="book-list">
	        <c:forEach var="age" items="${agerc}" varStatus="status">
	            <div class="book-img" onclick="location.href='/search/no=${age.callno}'">
	                <span class="rank">
		         		<p>${status.index+1 }</p>
		         	</span>
	                <img alt="표지사진" src="${age.img}">
	                <div class="title">${age.booktitle}</div><br>
	                <div class="author">${age.author}</div><br>
	                <div class="publisher">${age.publisher}</div>
	            </div>
	        </c:forEach>
	    </div>
	</div>
<br><br><br><br>
<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>

</body>
</html>