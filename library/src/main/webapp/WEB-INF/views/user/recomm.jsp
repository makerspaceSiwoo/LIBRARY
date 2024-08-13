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
		<c:forEach var="recomm" item="${recomm}">
			<hr>
			<img alt="표지사진" src="${recomm.img}" width="80">
			${recomm.booktitle}
			${recomm.author}
			${recomm.publisher}
			${recomm.pubyer}
		 <hr>
		</c:forEach>
	</div>
</body>
</html>