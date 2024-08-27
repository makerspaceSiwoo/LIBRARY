<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>book info</title>
<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/mo/searchresult.css">

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
<div>
	<h2 id ="title">도서 검색</h2>
    <form action="/search">
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
</div>


<div class="content-container">
		<span id="bookimg">
			<img alt="표지사진" src="${blist[0].img }" width="200">
		</span>
		<span id="bookinfo">
			<table border="1">
				<tr>
					<td colspan="3" align="center">제목</td>
				</tr>
				<tr>
					<td colspan="3" align="center">${blist[0].booktitle }</td>
				</tr>
				<tr>
					<td align="center">저자</td > <td align="center">출판사</td> <td align="center">출판연도</td>
				</tr>
				<tr>
					<td align="center">${blist[0].author}</td> <td align="center">${blist[0].publisher}</td> <td align="center">${blist[0].pubyear }</td>
				</tr>
			</table>
		</span>
	<hr>
</div>

<div class="content-container">
	<table border="1">
		<tr>
			<td colspan="5" align="center">소장정보</td>
		</tr>
		<tr>
			<td align="center">서가 위치</td> <td align="center">관리 번호</td> <td align="center">청구기호</td> <td align="center">대출상태</td>  <td align="center">반납예정일</td>
		</tr>
		<c:forEach var="b" items="${blist }" >
			<tr>
				<td align="center">${b.loc}</td> 
				<td align="center">${b.bookno }</td>
				<td align="center">${b.callno}</td> 
				<c:choose>
					<c:when test="${b.userno == null || b.userno == '' }">
						<td align="center">대출 가능</td>
						<td align="center">-</td>
					</c:when>
					<c:otherwise>
						<td align="center">대출 중</td>
						<td align="center">${b.end }</td>
					</c:otherwise>
				</c:choose>
			</tr>
		</c:forEach>
	</table>
</div>





<c:choose>
<c:when test="${otherbooks.size() != 0 }">
<div id="searchresult">
	<div id ="searchlist">
		<hr>
		<h2>작가의 다른 책</h2>
		<hr>
    		<table>
    			<c:forEach var="book" items="${otherbooks }">
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

    	</div>
</div>
</c:when>
<c:otherwise>
<div id="searchresult">
	<div id ="searchlist">
	<hr>
	<h2>작가의 다른 책</h2>
	<hr>
	<p>소장 중인 작가의 다른 작품이 없습니다.</p>
	</div>
	</div>
</c:otherwise>
</c:choose>
<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>
</body>
</html>