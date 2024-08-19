<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/admin/book/manage.css">
</head>
<body>

<div id="header">
		<img src="/logo/logo.png">
		<a href="/admin/home">도서관 Home</a>
		<a href="/book/borrow">대출관리</a>
		<a href="/book/add">도서추가</a>
		<a href="/book/manage">도서정보 수정</a>
		<a href="/admin/recomm">인기도서</a>
		<a href="">회원관리</a>
		<a href="board/list">나눔마당</a>
		<!--<c:if test="${user }"></c:if>-->
	</div>
<div>
		<div>
			<h1>도서 정보 수정/삭제</h1>
		</div>
		<div>
			<form id="modform">
				<input type="text" name="callno" placeholder="청구 기호 입력...">
				<button>검색</button>
			</form>
		</div>
		<div>
		<table id="targetlist" border="1" >
			<tr>
				<td colspan="6" align="center">검색한 책 목록</td>
			</tr>
			<tr>
				<td>책 이름</td>
				<td>저자</td>
				<td>청구기호</td>
				<td>출판사</td>
				<td>출판연도</td>
				<td></td>
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
						<td>${book.booktitle }</td>
						<td>${book.booktitle }</td>
						<td>
							<button onclick="location.href='/book/mod?bookno=${book.bookno}'">수정/삭제</button>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		</div>
	 <div id="page">
				<c:if test="${begin > pageNum }">
					<a href="/book/manage?callno=${callno }&p=${begin-1 }" class="page prv">&lt;</a>
				</c:if>
				<c:forEach begin="${begin }" end="${end}" var="i">
					<a href="/book/manage?callno=${callno }&p=${i}">${i}</a>
				</c:forEach>
				<c:if test="${end < totalPages }">
					<a href="/book/manage?callno=${callno }&p=${end+1}" class="page next">&gt;</a>
				</c:if>
			</div>
    </div>	
</div>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

</script>
</html>