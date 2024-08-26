<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 보기</title>
<style>

</style>
<script>
    function confirmAction(message) {
        return confirm(message);
    }

    function handleReport(event, form) {
        event.preventDefault(); // 기본 폼 제출 방지

        const reason = prompt('신고 사유를 입력하세요:');
        if (reason) {
            const reasonInput = document.createElement('input');
            reasonInput.type = 'hidden';
            reasonInput.name = 'reason';
            reasonInput.value = reason;
            form.appendChild(reasonInput);

            form.submit(); // 폼 제출
        } else {
            alert('신고 사유를 입력해야 합니다.');
        }
    }

    function handleDelete(event) {
        const confirmed = confirm('댓글을 삭제하시겠습니까?');
        if (!confirmed) {
            event.preventDefault(); // 삭제를 취소
        }
    }

    function checkCommentInput() {
        const textarea = document.querySelector("textarea[name='contents']");
        const preview = document.getElementById("commentPreview");
        preview.innerText = textarea.value;
    }
    
    function editComment(button, commno) {
    	console.log(`commentTextarea_\${commno}`)
       	console.log(commno)
        const textarea = document.getElementById(`commentTextarea_\${commno}`);
        const editForm = document.getElementById(`editForm_\${commno}`);
        console.log(textarea)
        // 수정 가능하게 변경
        textarea.removeAttribute('readOnly'); // readOnly 속성 제거
        textarea.style.pointerEvents = "auto"; // 수정 가능
        textarea.style.border = "1px solid #ccc"; // 수정 중 테두리 추가
        textarea.style.background = "white"; // 수정 중 배경색 변경

        // 버튼 텍스트를 '확인'으로 변경
        button.innerText = '확인버튼';

        // '확인' 버튼을 클릭했을 때의 동작 정의
        button.onclick = function() {
        	
            // 수정된 내용을 서버로 전송
            editForm.style.display = 'block'; // 수정 폼을 보이게 함
            textarea.setAttribute('readOnly', true); // 다시 읽기 전용으로 설정
            textarea.style.pointerEvents = "none"; // 다시 읽기 전용으로 설정
            textarea.style.border = "none"; // 테두리 제거
            textarea.style.background = "transparent"; // 배경색 제거
            button.innerText = '댓글수정'; // 버튼 텍스트 원래대로 복원
            // 수정된 내용을 서버로 전송
            editForm.submit(); 
        };
    }
</script>
</head>
<body>
<div class="text-container">
    <div class="post-header">
        <h2>${bcontent.title}</h2>
        <div class="post-info">작성자: ${userId} | 작성일: ${bcontent.write_date}</div>
    </div>

    <c:choose>
        <c:when test="${bcontent.state == 'BLIND'}">
            <p>이 글은 블라인드 처리되었습니다.</p>
        </c:when>
        <c:otherwise>
            <div class="text-content2">
                <p>글내용: ${bcontent.contents}</p>
            </div>
            <form action="/board/report/${bcontent.boardno}" method="post" onsubmit="return handleReport(event, this)">
                <input type="hidden" name="userno" value="${bcontent.userno}">
                <input type="hidden" name="contents" value="${bcontent.contents}">
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

    <c:if test="${ user.userno == bcontent.userno && bcontent.state != 'BLIND'}"> 
        <!-- 게시글 수정 및 삭제 버튼 -->
    </c:if>

    <ul>
        <c:forEach items="${commList}" var="comment">
            <li class="comment"> 
                <c:choose>
                    <c:when test="${comment.state == 'BLIND'}">
                        <p>이 글은 블라인드 처리되었습니다.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="text-content comment-content">
                            <div>유저번호: ${comment.userno} - 작성일: ${comment.write_date} - 작성자: ${comment.userId}</div>
     						<form action="/comm/update" method="post" id="editForm_${comment.commno}">
                            <textarea id="commentTextarea_${comment.commno}" name ="contents" style="pointer-events: none; resize:none; background: transparent;" readonly="readonly" required>${comment.contents}</textarea>
                              <input type="hidden" name="commno" value="${comment.commno}">
                                <input type="hidden" name="boardno" value="${bcontent.boardno}">
                                   
                            </form>
                            <c:if test="${ user.userno == comment.userno && comment.state != 'BLIND'}"> 
                                <div class="edit-delete-btns">
                                    <button type="button" class="comment-button" onclick="editComment(this, ${comment.commno})">댓글수정</button>
                                    <form action="/comm/delete/${bcontent.boardno}/${comment.commno}" method="post"  onsubmit="handleDelete(event)">
                                        <button type="submit" class="report-btn comment-button">댓글삭제</button>
                                    </form>
                                </div>
                            </c:if>

                       

                            <form action="/comm/report/${comment.commno}" method="post" onsubmit="return handleReport(event, this)" style="margin-top: 10px;">
                                <input type="hidden" name="boardno" value="${bcontent.boardno}">
                                <input type="hidden" name="userno" value="${comment.userno}">
                                <input type="hidden" name="contents" value="${comment.contents}">
                                <button type="submit" class="report-btn">댓글 신고하기</button>
                            </form>
                        </div>
                    </c:otherwise>
                </c:choose>
            </li><hr>
        </c:forEach>
    </ul>

    <form action="/comm/write" method="post" onsubmit="checkCommentInput()">
        <input type="hidden" name="boardno" value="${bcontent.boardno}">
        <input type="hidden" name="userno" value="${user.userno}">
        <textarea name="contents" placeholder="새로운 댓글 내용을 입력하세요." required oninput="checkCommentInput()"></textarea>
        <button type="submit">댓글 작성</button>
    </form>

    <a href="/board/search">게시글로 돌아가기</a>
</div>
</body>
</html>