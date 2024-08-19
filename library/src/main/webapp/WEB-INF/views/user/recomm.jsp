<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>도서 추천페이지</title>
</head>
<body>
	<h2>${user.userID}님 추천 도서</h2>
	<div>
	<h4>전체</h4>
		<c:forEach var="all" items="${allrc}">
		<div onclick="location.href='/search/no=${all.callno}'" style="cursor:pointer;">
			<hr>
			<img alt="표지사진" src="${all.img}" width="80">
			${all.booktitle}
			${all.author}
			${all.publisher}
		 <hr>
		 </div>
		</c:forEach>
	</div>
	<div>
		<h4>${user.userID}님 맞춤 카테고리별 추천 도서</h4>
		<c:forEach var="cate" items="${caterc}">
		<div onclick="location.href='/search/no=${cate.callno}'" style="cursor:pointer;">
		<hr>
		<img alt="표지사진" src="${cate.img}" width="80">
			${cate.booktitle}
			${cate.author}
			${cate.publisher}
		<hr>
		</div>
		</c:forEach>
	</div>
	<div>
	<c:if test="${user.gender == 'M'}"><h4>남성 추천 도서</h4></c:if>
	<c:if test="${user.gender == 'F'}"><h4>여성 추천 도서</h4></c:if>
		<c:forEach var="gen" items="${genrc}">
		<div onclick="location.href='/search/no=${gen.callno}'" style="cursor:pointer;">
		<hr>
		<img alt="표지사진" src="${gen.img}" width="80">
			${gen.booktitle}
			${gen.author}
			${gen.publisher}
		<hr>
		</div>
		</c:forEach>
	</div>
	<div>

		<h4>${agerc[0].agegroup} 추천 도서</h4>

		<c:forEach var="age" items="${agerc}">

		<div onclick="location.href='/search/no=${age.callno}'" style="cursor:pointer;">
		<hr>
		<img alt="표지사진" src="${age.img}" width="80">
			${age.booktitle}
			${age.author}
			${age.publisher}
		<hr>
		</div>
		</c:forEach>
	</div>
</body>
</html>