<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>회원 정보</title>
    <script>
function withdrawUser() {
    if (confirm("정말로 탈퇴하시겠습니까?")) {
        fetch('<c:url value="/user/del" />', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: new URLSearchParams({
                userno: ${user.userno}
            })
        }).then(response => {
            if (response.ok) {
                alert('회원 탈퇴가 완료되었습니다.');
                window.location.href = '<c:url value="/login" />'; // 로그인 페이지로 리다이렉트
            } else {
                alert('회원 탈퇴에 실패했습니다. 상태 코드: ' + response.status);
            }
        }).catch(error => {
            alert('오류가 발생했습니다.');
            console.error('Error:', error);
        });
    }
}
</script>
</head>
<body>
	my 페이지(임시)
	
	<form action="/admin/mod" method="get">
    
    <button>정보 수정</button>
    
	</form>
    <h1>사용자 정보</h1>
    <p>안녕하세요, ${user.name}님!</p>
    <p><button onclick="withdrawUser()">회원 탈퇴</button></p>
</body>
</html>