<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
$(function(){ // 페이지 로딩시 즉시 사용할 메소드
	alert("유저 접근이 제한된 페이지 입니다.");
	location.href="/home";
});
</script>
</body>
</html>