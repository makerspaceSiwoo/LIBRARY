<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	function confirmBan() {
   		if (confirm("이 사용자를 블라인드 처리하시겠습니까?")) {
            return true; // 확인을 선택한 경우
        } else {
            alert("취소되었습니다."); // 취소를 선택한 경우
            return false; // 폼 제출을 막음
        }
	}
   
    function confirmDelete() {
        if (confirm("블랙리스트를 삭제하겠습니까?")) {
            return true; // 확인을 선택한 경우
        } else {
            alert("취소되었습니다."); // 취소를 선택한 경우
            return false; // 폼 제출을 막음
        }
    }
    
    function confirmForbid() {
        if (confirm("게시물 작성 3일 정지를 시키겠습니까?")) {
            return true; // 확인을 선택한 경우
        } else {
            alert("취소되었습니다."); // 취소를 선택한 경우
            return false; // 폼 제출을 막음
        }
    }
</script>
</head>
<body>

<c:forEach items="${blacklistdto }" var="black">
    blacklistno: ${black.blacklistno }  forbid_end: ${black.forbid_end } reason: ${black.reason } userno: ${black.userno } boardno: ${black.boardno } commno: ${black.commno } contents :${black.contents} <br>
    
    
	<form id="banForm_${black.boardno}_${black.commno}" action="/admin/ban" method="post" onsubmit="return confirmBan()">
    	<input type="hidden" name="boardno" value="${black.boardno }"/>
    	<input type="hidden" name="commno" value="${black.commno }"/>
   	 	<button type="submit">블라인드처리</button> 
	</form>
    
    <form action="/board/no/${black.boardno}">
        <button type="submit">신고게시글보기</button>
    </form>
    <form action="/admin/ban/delete" method="post" onsubmit="return confirmDelete()">
        <input type="hidden" name="blacklistno" value="${black.blacklistno }"/>
        <button type="submit">블랙리스트삭제</button>
    </form>
    <form action="/admin/ban/forbid_end" method="post" onsubmit="return confirmForbid()">
    	<input type="hidden" name="blacklistno" value="${black.blacklistno }"/>
    	<input type="hidden" name="userno" value="${black.userno }"/>
    	<input type="hidden" name="boardno" value="${black.boardno }"/>
    	<button type="submit">forbid_end(3일추가)</button>
    </form>
    
    
</c:forEach>

</body>
</html>