<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>회원 정보</title>
    <script>
function withdrawUser() {
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
</script>
<link rel="stylesheet" type="text/css" href="/css/header.css">
<link rel="stylesheet" type="text/css" href="/css/ho/mypage.css">
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
	                     <button style="margin-top: 15px;" id="logoutbutton">로그아웃</button>
	                  </form>
	               </c:otherwise>
	            </c:choose>
	        </div>
         </div>

   <hr>
</nav>
	
    <h1>${user.userID}님의 대출 현황</h1>

<div>
    <h3>현재 대출중인 도서</h3>
    <c:choose>
        <c:when test="${empty unretbook}">
            <p style="text-align: center;">현재 대출중인 도서가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>제목</th>
                        <th>저자</th>
                        <th>출판사</th>
                        <th>분류</th>
                        <th>반납예정일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${unretbook}" var="book">
                        <tr>
                            <td>${book.booktitle}</td>
                            <td>${book.author}</td>
                            <td>${book.publisher}</td>
                            <td>${book.category}</td>
                            <td>${book.end}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<div>
    <h3>최근 대출 목록</h3>
    <c:choose>
        <c:when test="${empty recode}">
             <p style="text-align: center;">최근 대출 내역이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>제목</th>
                        <th>저자</th>
                        <th>출판사</th>
                        <th>분류</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${recode}" var="code">
                        <tr>
                            <td onclick="location.href='/search/no=${code.callno}'" style="cursor:pointer; font-weight: bold;">
  							${code.booktitle}
							</td>
                            <td>${code.author}</td>
                            <td>${code.publisher}</td>
                            <td style="white-space: nowrap;">${code.category}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
        
       <div class="button-containers">
    <form action="/user/mod" method="get">
        <button class="change" >회원정보 수정</button>
    </form>
    	<button class="deldel" onclick="withdrawUser()">회원 탈퇴</button>
	</div>
	<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>
</body>
</html>