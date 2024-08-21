<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
.pagination {
    display: flex;
    justify-content: center; /* 가운데 정렬 */
    padding-left: 0;
    list-style: none;
}

.pagination .page-item {
    display: inline; /* 가로로 배치 */
    margin: 0 5px; /* 각 페이지 링크 간격 조정 */
}

.pagination .page-link {
    text-decoration: none;
    color: #007bff;
}

.pagination .page-item.disabled .page-link {
    color: #6c757d;
}

.pagination .page-item.active .page-link {
    color: white;
    background-color: #007bff;
    border-color: #007bff;
}
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    width: 100%;
}
nav, header, aside, main, footer {
    width: 100%;
    margin: 0 auto;
    padding: 0;
    box-sizing: border-box;
}
main{
   margin-left: 3vw;
   margin-bottom: 5vw;
}
#adminmenu {
   position: relative;
   width: 100%;
    height: 30px; /* 헤더의 높이를 40%로 설정 */

    display: flex;
    align-items: center;
    justify-content: space-between; /* 요소들이 좌우로 배치되도록 설정 */
    padding: 1vw 0vw; /* 상하 10px, 좌우 20px의 여백 */
    background-color: white; /* 배경색을 흰색으로 설정 */
    
    margin-right: 10%;
}
#adminmenu a,p {
   flex-shrink: 1; /* 창 크기가 작아지면 크기를 줄임 */
   display: inline-block;
    margin: 0 0.5vw; /* 각 링크 사이에 좌우 15px의 여백 */
    text-decoration: none;
    color: black; /* 글자 색을 검정으로 설정 */
    font-size: 1.6vw; /* 뷰포트 너비에 따라 유연하게 크기 조정 */
    font-weight: 500; /* 글자 두께를 중간으로 설정 */
    white-space: nowrap; /* 텍스트가 줄바꿈 되지 않도록 설정 */
}

#adminmenu a img {
    height: 6vw; /* 로고 이미지의 높이를 40px로 설정 */
    margin-right: 0px; /* 로고 이미지 오른쪽에 여백 추가 */
}

#joinbutton {
   flex-shrink: 1; /* 창 크기가 작아지면 크기를 줄임 */
    padding: 1vw 1.5vw; /* 버튼의 안쪽 여백 설정 */
    font-size: 1.6vw; /* 뷰포트 너비에 따라 유연하게 크기 조정 */
    border-radius: 0.8vw; /* 버튼의 모서리를 둥글게 설정 */
    border: 1px solid #ccc; /* 버튼의 테두리 설정 */
    background-color: #f2f2f2; /* 버튼의 배경색을 연한 회색으로 설정 */
    cursor: pointer;
    margin-left: 0.5vw; /* 버튼 간의 간격 설정 */
    white-space: nowrap; /* 텍스트가 줄바꿈 되지 않도록 설정 */
}

#loginbutton {
   flex-shrink: 1; /* 창 크기가 작아지면 크기를 줄임 */
    padding: 1vw 1.5vw; /* 버튼의 안쪽 여백 설정 */
    font-size: 1.6vw; /* 뷰포트 너비에 따라 유연하게 크기 조정 */
    border-radius: 0.8vw; /* 버튼의 모서리를 둥글게 설정 */
    border: 1px solid #ccc; /* 버튼의 테두리 설정 */
    cursor: pointer;
    margin-left: 0.5vw; /* 버튼 간의 간격 설정 */
    white-space: nowrap; /* 텍스트가 줄바꿈 되지 않도록 설정 */
    background-color: #4CAF50; /* 예: 버튼 배경색을 초록색으로 설정 */
    color: white;
    margin-right: 1vw; /* 버튼 간의 간격 설정 */
    
}

#loginbutton:hover {
    background-color: #45a049; /* 초록색 로그인 버튼에 마우스를 올렸을 때 색 변경 */
    font-weight: bold; /* hover 시 폰트를 굵게 설정 */
}

#logoutbutton {
   flex-shrink: 1; /* 창 크기가 작아지면 크기를 줄임 */
    padding: 1vw 1.5vw; /* 버튼의 안쪽 여백 설정 */
    font-size: 1.6vw; /* 뷰포트 너비에 따라 유연하게 크기 조정 */
    border-radius: 0.8vw; /* 버튼의 모서리를 둥글게 설정 */
    border: 1px solid #ccc; /* 버튼의 테두리 설정 */
    cursor: pointer;
    margin-left: 0.5vw; /* 버튼 간의 간격 설정 */
    white-space: nowrap; /* 텍스트가 줄바꿈 되지 않도록 설정 */
    background-color: red; /* 예: 버튼 배경색을 초록색으로 설정 */
    color: white;
    margin-right: 1vw; /* 버튼 간의 간격 설정 */
    
}

#logoutbutton:hover {
    background-color: #cc0000; /* 초록색 로그인 버튼에 마우스를 올렸을 때 색 변경 */
    font-weight: bold; /* hover 시 폰트를 굵게 설정 */
}

/* 페이지를 부드럽게 스크롤 */
html {
    scroll-behavior: smooth;
}


main {
    width: 90%; /* 화면의 90%만 차지하도록 설정 */
    margin: 0 auto; /* 중앙 정렬 */
    padding: 2vh 0; /* 위아래 여백 설정 */
}

section {
    margin-bottom: 4vh; /* 각 섹션 간의 여백 설정 */
}

section h2, section h3 {
    font-size: 2vw; /* 반응형 텍스트 크기 */
    margin-bottom: 2vh; /* 제목 아래 여백 */
    color: #333;
}

section p {
    font-size: 1.5vw; /* 반응형 텍스트 크기 */
    margin-bottom: 2vh; /* 텍스트 아래 여백 */
    color: #555;
}

/* 도서 추가 페이지 스타일 */
h1 {
    font-size: 2.5vw; /* 큰 제목의 크기 */
    color: #333;
    margin-bottom: 2vh; /* 제목 아래 여백 */
}

h3 {
    font-size: 2vw; /* 소제목의 크기 */
    color: #333;
    margin-bottom: 1.5vh; /* 소제목 아래 여백 */
}



</style>

</head>
<body>
         <div id="adminmenu">
            <a href="/home"><img src="/logo/logo.png"></a>
            <a href="/home">도서관 홈</a>
            <a href="/book/record">대출/반납</a>
            <a href="/book/add">도서 추가</a>
            <a href="/book/manage">도서 수정/삭제</a>
            <a href="/board/search">게시판</a>
            <a href="/admin/mypage">마이 페이지</a>
            <a href="/admin/blacklist">유저 관리</a>
            <c:choose>
               <c:when test="${empty user }">
                  <button onclick="location.href='/login';">로그인</button>
               </c:when>
               <c:otherwise>
                  <p>${user.userID }</p>
                  <form action="/logout" method="post">
                     <button>로그아웃</button>
                  </form>
               </c:otherwise>
            </c:choose>
         </div>
  
<h1>대출관리</h1>
<form action="/book/record" method="GET">
<input type="text" name="booktitle">
<button type="submit" >검색</button>
</form>
<table border="1">   
	<tr>
		<td>"제목"검색결과</td><br>
	</tr>
	<tr> 
		<c:forEach items="${unreturned}" var="borrow">
			<tr><td>${fn:substring(borrow.booktitle, 0, 10)}</td>
            <td>${fn:substring(borrow.author, 0, 10)}</td>
            <td>${fn:substring(borrow.callno, 0, 10)}</td>
            <%-- 검색결과 책이름, 저자, 주문번호 출력 --%>
			<c:if test="${borrow.userno != 0 }">
				<c:if test="${borrow.u_end.time <= now.time}">
					<c:set var="formattedDate">
					<fmt:formatDate value="${borrow.u_end}" pattern="yyyy-MM-dd"/>
					</c:set>
					<td style="color: red;">${formattedDate}</td>
					<td><button type="button" style="color: red;" onclick="location.href='/book/latereturn?userno=${borrow.userno}&formattedDate=${formattedDate}&bookno=${borrow.bookno}'">
					반납
					</button>
					<%-- 반납예정일자가 현재일자보다 낮다면(연체라면) 글자빨강에 반납시 컨트롤러 latereturn 호출 --%>
				</td>
				</c:if>
				<c:if test="${borrow.u_end.time > now.time}">		
					<td><fmt:formatDate value="${borrow.u_end}" pattern="yyyy-MM-dd"/></td>
					<td><button type="button" onclick="location.href='/book/return?userno=${borrow.userno}&bookno=${borrow.bookno}'">
					반납
					</button>
					<%-- 반납예정일자가 현재일자보다 크다면(정상대출이라면) 반납시 컨트롤러 return호출  --%>
				</td>
				</c:if>
			
			</c:if>
			
			
			<c:if test="${borrow.userno == 0 }">
				<td><button type="button" onclick="location.href='/book/lent?bookno=${borrow.bookno}'">대출</button></td>
			</c:if>
			<%-- 대출버튼 클릭시 컨트롤러 lent호출 (유저번호 입력페이지 생성 예정) --%>
		</tr>
		</c:forEach>
		</tr>
</table>
 <!-- 페이지 네비게이션 -->
  <nav aria-label="Page navigation">
    <ul class="pagination">
        <!-- 이전 10개 페이지로 이동 -->
        <li class="page-item <c:if test='${startPage == 1}'>disabled</c:if>">
            <a class="page-link" href="?booktitle=${param.booktitle}&page=${startPage - 10 > 0 ? startPage - 10 : 1}&size=${pageSize}" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>

        <!-- 페이지 번호 출력 -->
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
                <a class="page-link" href="?booktitle=${param.booktitle}&page=${i}&size=${pageSize}">${i}</a>
            </li>
        </c:forEach>

        <!-- 다음 10개 페이지로 이동 -->
        <li class="page-item <c:if test='${endPage == totalPages}'>disabled</c:if>">
            <a class="page-link" href="?booktitle=${param.booktitle}&page=${endPage + 1}&size=${pageSize}" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </ul>
</nav>
</body>
</html>

