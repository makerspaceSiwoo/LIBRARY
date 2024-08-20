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
			<form id="lentform" action="" method="POST">
				<input type="hidden" name="bookno" value=${bookno}>
				<input id="userno" type="number" name="userno"><br>
				<button type="button" onclick="return lent();">대출</button>
				<%-- 책번호, 유저번호 입력 창 , 대출버튼 출력 --%>
			</form>	
		</td>
	</tr>

</table>

</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
let penaltyuser = ${loan};

function lent(){
	let userno =$("#userno").val();
	if(penaltyuser.includes(parseInt(userno))){
		alert("해당 유저는 대출 금지 상태입니다.")
		return false;
	}else {
		let form = document.getElementById("lentform");
		form.submit();
		return true;
	}<%-- 입력한 유저번호가 loan객체안 패널티가 1인경우 대출금지 알람 및 false값 리턴 --%>
}

</script>
</html>