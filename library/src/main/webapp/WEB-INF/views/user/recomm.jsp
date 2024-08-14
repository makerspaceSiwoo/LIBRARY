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
		<c:forEach var="all" items="${allrcbook}">
			<hr>
			<img alt="표지사진" src="${all.img}" width="80">
			${all.booktitle}
			${all.author}
			${all.publisher}
		 <hr>
		</c:forEach>
	</div>
	<div>
		<c:forEach var="cate" items="${catercbook}">
		<hr>
		<img alt="표지사진" src="${cate.img}" width="80">
			${cate.booktitle}
			${cate.author}
			${cate.publisher}
		<hr>
		</c:forEach>
	</div>
	<div>
		<c:forEach var="gen" items="${genrcbook}">
		<hr>
		<img alt="표지사진" src="${gen.img}" width="80">
			${gen.booktitle}
			${gen.author}
			${gen.publisher}
		<hr>
		</c:forEach>
	</div>
	<div>
		<c:forEach var="age" items="${agercbook}">
		<hr>
		<img alt="표지사진" src="${age.img}" width="80">
			${age.booktitle}
			${age.author}
			${age.publisher}
		<hr>
		</c:forEach>
	</div>
</body>
</html>