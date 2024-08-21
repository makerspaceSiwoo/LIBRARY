<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
    // 게시글, 댓글, 블라인드 처리 등의 액션에 대해 확인 메시지를 띄우는 함수
    function confirmAction(message) {
        return confirm(message);
    }
</script>
</head>
<body>
<%-- 게시글 내용 표시, bcontent.state가 BLIND 상태면 게시글 신고 버튼을 표시하지 않음 --%>
<c:choose>
    <c:when test="${bcontent.state == 'BLIND'}">
        <p>이 글은 블라인드 처리되었습니다.</p>
    </c:when>
    <c:otherwise>
    	<p>글제목: ${bcontent.title }</p>
        <p>글내용: ${bcontent.contents}</p><p>userID : ${userId}</p>
        <!-- 게시글 신고 버튼 -->
        <form action="/board/report/${bcontent.boardno}" method="post" onsubmit="return confirmAction('게시글을 신고하시겠습니까?')">
            <input type="hidden" name="userno" value="${bcontent.userno}">
            <input type="hidden" name="contents" value="${bcontent.contents}">
            <textarea name="reason" placeholder="신고 사유를 입력하세요"></textarea>
            <button type="submit">게시글 신고하기</button>
        </form>
    </c:otherwise>
</c:choose>

<%-- 로그인된 userno와 게시판의 userno가 같을 때만 수정 및 삭제 버튼을 표시. 게시글 상태가 BLIND일 경우 버튼을 표시하지 않음 --%>
<c:if test="${ user.userno == bcontent.userno && bcontent.state != 'BLIND'}"> 
    <!-- 게시글 수정 버튼 -->
    <form action="/board/mod/${bcontent.boardno}" method="get" onsubmit="return confirmAction('게시글을 수정하시겠습니까?')">
        <button type="submit">게시글 수정</button>
    </form>
    
    <!-- 게시글 삭제 버튼 -->
    <form action="/board/delete/${bcontent.boardno}" method="get" onsubmit="return confirmAction('게시글을 삭제하시겠습니까?')">
        <button type="submit">게시글 삭제</button>
    </form>
</c:if>

<%-- 댓글 작성 기능 --%>
<h2>댓글 작성</h2>
<form action="/comm/write" method="post">
    <input type="hidden" name="boardno" value="${bcontent.boardno}">
    <input type="hidden" name="userno" value="${user.userno}">
    <textarea name="contents" placeholder="새로운 댓글 내용을 입력하세요." required></textarea><br>
    <button type="submit">댓글 작성</button>
</form>

<ul>
    <%-- 게시글에 달린 댓글 목록. 게시글이 BLIND 상태이면 댓글의 삭제, 수정, 신고 버튼을 표시하지 않음 --%>
    <c:forEach items="${commList}" var="comment">
        <li> 
            <c:choose>
                <c:when test="${comment.state == 'BLIND'}">
                    <p>이 글은 블라인드 처리되었습니다.</p>
                </c:when>
                <c:otherwise>
                    <p>유저번호: ${comment.userno} - 댓글내용: ${comment.contents} - 작성일: ${comment.write_date} - 작성자: ${comment.userId}</p>
                    
                    <%-- 로그인된 userno와 댓글 작성자의 userno가 같을 때만 수정 및 삭제 버튼을 표시 --%>
                    <c:if test="${ user.userno == comment.userno && comment.state != 'BLIND'}"> 
                        <!-- 댓글 수정 버튼 -->
                        <form action="/comm/update" method="post" style="display: inline;" onsubmit="return confirmAction('댓글을 수정하시겠습니까?')">
                            <textarea name="contents" placeholder="댓글 수정 내용 입력"></textarea>
                            <input type="hidden" name="commno" value="${comment.commno}">
                            <input type="hidden" name="boardno" value="${bcontent.boardno}">
                            <button type="submit">댓글수정</button>
                        </form>
                        
                        <!-- 댓글 삭제 버튼 -->
                        <form action="/comm/delete/${bcontent.boardno}/${comment.commno}" method="post" style="display: inline;" onsubmit="return confirmAction('댓글을 삭제하시겠습니까?')">
                            <button type="submit">댓글삭제</button>
                        </form>
                    </c:if>
                    
                    <!-- 댓글 신고 버튼 -->
                    <form action="/comm/report/${comment.commno}" method="post" onsubmit="return confirmAction('댓글을 신고하시겠습니까?')">
                        <input type="hidden" name="boardno" value="${bcontent.boardno}">
                        <input type="hidden" name="userno" value="${comment.userno}">
                        <input type="hidden" name="contents" value="${comment.contents}">
                        <textarea name="reason" placeholder="신고 사유를 입력하세요"></textarea>
                        <button type="submit">댓글 신고하기</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </li>
    </c:forEach>
</ul>

<a href="/board/search">게시글로 돌아가기</a>
</body>
</html>