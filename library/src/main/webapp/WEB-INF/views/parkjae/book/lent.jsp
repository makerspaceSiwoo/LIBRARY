<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

</head>
<body>
<table border="1">
	<tr>
		<td>${bookno}</td>
		<td>
			<form action="" method="POST">
				<input type="hidden" name="bookno" value=${bookno}>
				<input type="text" name="userno" ><br>
				<button trpe="submit">대출</button>
			</form>	
		</td>
	</tr>

</table>

</body>
</html>