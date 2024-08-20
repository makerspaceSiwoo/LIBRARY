<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<c:choose>
		<c:when test="${user.admin == 1 }">
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
		</c:when>
		<c:otherwise>
			<div id="usermenu">
				<a href="/home"><img src="/logo/logo.png"></a>
				<a href="/home">도서관 홈</a>
				<a href="/search">도서 검색</a>
				<a href="/recomm">추천 도서</a>
				<a href="/board/search">게시판</a>
				<a href="/mypage">마이 페이지</a>
				<c:choose>
					<c:when test="${empty user }">
						<button onclick="location.href='/join';">회원 가입</button>
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
		</c:otherwise>
	</c:choose>
	
</body>
</html>