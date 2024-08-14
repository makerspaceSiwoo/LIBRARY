<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>도서 추천페이지</title>
</head>
<body>
	<h2>추천을 해보까용??</h2>
	<div>
	<h4>전체 대여량</h4>
		<c:forEach var="all" items="${allrcbook}">
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
		<h4>분야별 대여량</h4>
		<c:forEach var="cate" items="${catercbook}">
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
	<h4>성별 대여량</h4>
		<c:forEach var="gen" items="${genrcbook}">
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
	<h4>연령별 대여량</h4>
		<c:forEach var="age" items="${agercbook}">
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