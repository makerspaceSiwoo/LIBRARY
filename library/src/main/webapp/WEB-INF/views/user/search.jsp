<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 검색</title>
    <link rel="stylesheet" type="text/css" href="/css/header.css">
	<link rel="stylesheet" type="text/css" href="/css/mo/search.css">
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
      <c:otherwise>
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
      </c:otherwise>
   </c:choose>
   <hr>
</nav>
	<h3 class="title">도서 검색</h3>
	
	
    <form action="search">
        <!-- 검색 분류 -->
        <select name="searchn" id="searchn">
            <option value="0">제목+분류 검색</option>
            <option value="1">저자+분류 검색</option>
        </select>
        <span id="cateSelect">
      	<select id="cate" name="cate">
        		<option value="">전체</option>
        		<option value="총류">총류</option>
        		<option value="철학">철학</option>
        		<option value="종교">종교</option>
        		<option value="사회과학">사회과학</option>
        		<option value="자연과학">자연과학</option>
        		<option value="기술과학">기술과학</option>
        		<option value="예술">예술</option>
        		<option value="언어">언어</option>
        		<option value="문학">문학</option>
        		<option value="역사">역사</option>
        	</select>
        </span>
        <!-- 검색어 입력 필드 -->
        <input type="text" id="search" name="search" placeholder="검색어를 입력하세요" >
        <!-- 검색 버튼 -->
        <input type="submit" value="검색"/>
    </form>
    
    <h3 id = "result">검색결과</h3>
    
    <hr id = "gubunsun">
    
    <div id="searchresult">
    	<div id ="searchlist">
    	<c:if test="${count == 0}"><h3 id ="noresult">검색 결과가 없습니다.</h3></c:if>
    	<c:if test="${count > 0}">
    		<table>
    			<c:forEach var="book" items="${bList }">
    			<div id="bookresult" onclick="location.href='/search/no=${book.callno}'">
				    <img alt="표지사진" src="${book.img}">
				    <div class="book-info">
				        <div class="book-row">
				            <span class="label">제목</span>
				            <span class="value">${book.booktitle}</span>
				        </div>
				        <div class="book-row">
				            <span class="label">저자</span>
				            <span class="value">${book.author}</span>
				        </div>
				        <div class="book-row">
				            <span class="label">출판사</span>
				            <span class="value">${book.publisher}</span>
				        </div>
				        <div class="book-row">
				            <span class="label">출판 연도</span>
				            <span class="value">${book.pubyear}</span>
		      </div>
    </div>
</div>

    		</c:forEach>
    		</table>	
    	</c:if>
    	</div>
    <div id="page">
				<c:if test="${begin > pageNum }">
					<a href="/search?searchn=${searchn }&search=${search }&p=${begin-1 }" class="page prv">&lt;</a>
				</c:if>
				<c:forEach begin="${begin }" end="${end}" var="i">
					<a href="/search?searchn=${searchn }&search=${search }&p=${i}">${i}</a>
				</c:forEach>
				<c:if test="${end < totalPages }">
					<a href="/search?searchn=${searchn }&search=${search }&p=${end+1}" class="page next">&gt;</a>
				</c:if>
			</div>
    </div>

<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>

 <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script>
        $(function(){
            // searchn 값을 이용하여 select 박스에서 해당 값을 선택
            $("#searchn").val("${searchn}");
			
            $("#search").val("${search}");
            
            // cate의 값을 설정하여 선택값을 유지
            $("#cate").val("${cate}");
        });
    </script>
</body>
</html>
