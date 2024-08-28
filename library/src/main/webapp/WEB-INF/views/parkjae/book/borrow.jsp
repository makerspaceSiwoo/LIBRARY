<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="/css/header.css">
	<link rel="stylesheet" type="text/css" href="/css/admin/book/manage.css">
	<link rel="stylesheet" type="text/css" href="/css/admin/book/add.css">
	<link rel="stylesheet" type="text/css" href="/css/pjh/borrow.css">
	
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
<h1>대출관리</h1>
<form action="/book/record" method="GET">
<input type="text" name="booktitle" placeholder="제목을 입력하세요...">
<button type="submit" >검색</button>
</form>

<table border="1">   
	<tr>
		<td colspan="5">"제목"검색결과</td><br>
	</tr>
	<tr>
		 <td style="font-weight: bold;">책 이름</td>
  		 <td style="font-weight: bold;">저자</td>
    	 <td style="font-weight: bold;">청구기호</td>
    	 <td style="font-weight: bold;">반납예정</td>
    	 <td style="font-weight: bold;">반납/대출</td>
	</tr>

	 	<c:if test="${count == 0 }">
			<tr><td colspan="5" align="center">검색 결과가 없습니다.</td></tr>
		</c:if>
		
<c:if test="${count != 0 }">	
		<c:forEach items="${unreturned}" var="borrow">
			<tr><td>${fn:substring(borrow.booktitle, 0, 20)}</td>
            <td>${fn:substring(borrow.author, 0, 20)}</td>
            <td>${fn:substring(borrow.callno, 0, 20)}</td>
            <%-- 검색결과 책이름, 저자, 주문번호 출력 --%>
			<c:if test="${borrow.userno != 0 }">
				<%----------------------------------------------------------------%>
				<c:if test="${borrow.u_end.time <= now.time}">
					<c:set var="formattedDate">
					<fmt:formatDate value="${borrow.u_end}" pattern="yyyy-MM-dd"/>
					</c:set>
					<td style="color: red;"><strong>${formattedDate}</strong></td>
					<td><button type="button" id="returnbutton" onclick="alert('연체되었습니다'); location.href='/book/latereturn?userno=${borrow.userno}&formattedDate=${formattedDate}&bookno=${borrow.bookno}'">
					연체반납
					</button>
					<%-- 반납예정일자가 현재일자보다 낮다면(연체라면) 글자빨간색에 반납시 컨트롤러 latereturn 호출 --%>
					</td>
				</c:if>
				<%----------------------------------------------------------------%>
				<c:if test="${borrow.u_end.time > now.time}">		
					<c:set var="formattedDate">
					<fmt:formatDate value="${borrow.u_end}" pattern="yyyy-MM-dd"/>
					</c:set>
					<td style="color: green;"><strong>${formattedDate}</strong></td>
					<td><button id="returnbutton" type="button" onclick="alert('반납되었습니다'); location.href='/book/return?userno=${borrow.userno}&bookno=${borrow.bookno}'">
					반납
					</button>
					<%-- 반납예정일자가 현재일자보다 크다면(정상대출이라면) 반납시 컨트롤러 return호출  --%>
					</td>
				</c:if>
			    <%----------------------------------------------------------------%>
			</c:if>
			
			<c:if test="${borrow.userno == 0 }">
			<td>대출 가능</td>
				<td>
				<button type="button" onclick=" location.href='/book/lent?bookno=${borrow.bookno}&booktitle=${borrow.booktitle }'">대출</button>
				</td>
			</c:if>
			<%-- 대출버튼 클릭시 컨트롤러 lent호출 (유저번호 입력페이지 생성 예정) --%>
			</tr>
		</c:forEach>
</c:if>
</table>

 <!-- 페이지 네비게이션 -->
 <div id="page">
  <nav aria-label="Page navigation">
        <!-- 이전 5개 페이지로 이동 -->
        <c:if test='${startPage != 1 && count!=0}'>

        	<a class="page-link" href="?booktitle=${param.booktitle}&page=${startPage - 10 > 0 ? startPage - 10 : 1}&size=${pageSize}" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </c:if>
        
        <!-- 페이지 번호 출력 -->
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
			<c:choose>
            <c:when test="${i == currentPage}">
                <a class="active" href="?booktitle=${param.booktitle}&page=${i}&size=${pageSize}">${i}</a>
            </c:when>
            <c:otherwise>
                 <a href="?booktitle=${param.booktitle}&page=${i}&size=${pageSize}">${i}</a>
            </c:otherwise>
        </c:choose>
        
        </c:forEach>

        <!-- 다음 5개 페이지로 이동 -->
        <c:if test='${endPage != totalPages}'>

	        	<a class="page-link" href="?booktitle=${param.booktitle}&page=${endPage + 1}&size=${pageSize}" aria-label="Next">
	                <span aria-hidden="true">&raquo;</span>
	            </a>

        </c:if>

	</nav>
</div>

</section>
</main>

<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>

</body>
</html>

