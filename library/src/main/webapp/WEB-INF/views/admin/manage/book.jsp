<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<form action="/book/add" method="post">
		<input name="booktitle" placeholder="책 이름을 입력하세요" required>
		<input name="author" placeholder="저자" required>
		<input name="callno" placeholder="청구기호" required>
		<input name="publisher" placeholder="출판사" required>
		<input type="number" name="pubyear" placeholder="출판연도" required>
		<input name="loc" placeholder="서가 위치">
		
	</form>
</body>
</html>