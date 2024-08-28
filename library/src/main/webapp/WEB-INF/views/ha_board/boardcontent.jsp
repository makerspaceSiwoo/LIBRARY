<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/header.css">
<meta charset="UTF-8">
<title>게시글 상세 보기</title>
<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f7f8fa;
    margin: 0;
    padding: 0;
}

.text-container {
    max-width: 800px;
    margin: 50px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    border: 1px solid #000; /* 검은색 테두리 추가 */
    
}

.post-header h2 {
    font-size: 28px;
    color: #333;
    margin-bottom: 10px;
}

.post-info {
    font-size: 14px;
    color: #888;
    margin-bottom: 20px;
}

.text-content2 {
    font-size: 18px;
    color: #555;
    line-height: 1.6;
    margin-bottom: 20px;
    border-bottom: 2px solid #ddd; /* 게시글 내용과 신고 버튼을 구분 */
    padding-bottom: 20px; /* 게시글 내용의 아래쪽 여백 */
}

.comment-section {
    border-top: 2px solid #ddd;
    padding-top: 20px;
    margin-top: 20px;
}

.comment-box {
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 5px;
    padding: 15px;
    margin-bottom: 20px;
    border: 1px solid #000; /* 검은색 테두리 추가 */
    
}

.text-content.comment-content {
    font-size: 16px;
    color: #444;
    background-color: #f1f1f1;
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 10px;
}

.comment {
    list-style: none;
    margin-bottom: 15px;
}
.comment-form textarea {
    width: 390%;  /* 너비 */
    height: 100px;  /* 높이 */
}
.comment-box textarea {
    width: 365%;  /* 너비 */
    height: 80px;  /* 높이 */
}
.comment-info {
    font-size: 14px;
    color: #888;
    margin-bottom: 10px;
}

ul {
    padding-left: 0;
}

hr {
    border: 0;
    height: 1px;
    background: #ddd;
    margin: 20px 0;
}

button {
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 5px;
    padding: 10px 15px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}


button:hover {
    background-color: #0056b3;
}

.comment-button {
    background-color: #28a745;
    margin-right: 10px;
}

.comment-button:hover {
    background-color: #218838;
}

.report-btn {
    background-color: #dc3545;
    margin-right: 10px; /* 버튼들 사이에 간격을 추가 */
    
    
}

.report-btn:hover {
    background-color: #c82333;
}
.report-form {
    text-align: right; /* 신고하기 버튼을 오른쪽으로 정렬 */
    margin-top: 10px; /* 위쪽 여백 추가 */
}

.report-post-btn {
    background-color: #dc3545; /* 빨간색 배경 */
    color: white; /* 텍스트 색상 */
    border: none;
    border-radius: 5px;
    padding: 10px 15px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}
.report-post-btn:hover {
    background-color: #b32d3a; /* 마우스를 올렸을 때 색상 */
}
.back-button {
    background-color: #007bff; /* 버튼 배경색 */
    color: white; /* 버튼 텍스트 색상 */
    border: none;
    border-radius: 5px;
    padding: 10px 15px;
    font-size: 14px;
    cursor: pointer;
    text-decoration: none; /* 링크 스타일 제거 */
    display: inline-block;
    transition: background-color 0.3s ease, color 0.3s ease; /* 색상 전환에 대한 부드러운 전환 */
}

.back-button:hover {
    background-color: #0056b3; /* 호버 시 색상 */
    color: white; /* 호버 시에도 텍스트 색상을 유지 */
    
}
textarea {
    width: 100%;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ddd;
    font-size: 16px;
    margin-bottom: 10px;
    transition: border-color 0.3s ease;
}

textarea:focus {
    border-color: #007bff;
}

.edit-delete-btns {
    display: flex;
    align-items: center;
    margin-top: 10px;
}



form {
    display: inline-block;
}

.comment-form {
    margin-top: 30px;
    padding-top: 20px;
    border-top: 2px solid #ddd;
}

a {
    color: #007bff;
    text-decoration: none;
    font-size: 14px;
    margin-top: 20px;
    display: inline-block;
    transition: color 0.3s ease;
}

a:hover {
    color: #0056b3;
}

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
            alert('신고 사유를 입력해주세요!!');
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
        const textarea = document.getElementById(`commentTextarea_\${commno}`);
        const editForm = document.getElementById(`editForm_\${commno}`);

        // 수정 가능하게 변경
        textarea.removeAttribute('readOnly'); // readOnly 속성 제거
        textarea.style.pointerEvents = "auto"; // 수정 가능
        textarea.style.border = "2px solid #000"; // 수정 중 테두리 추가
        textarea.style.background = "white"; // 수정 중 배경색 변경

        // 버튼 텍스트를 '확인'으로 변경
        button.innerText = '확인';

        // '확인' 버튼을 클릭했을 때의 동작 정의
        button.onclick = function() {
            // 수정된 내용을 서버로 전송
            editForm.style.display = 'block'; // 수정 폼을 보이게 함
            textarea.setAttribute('readOnly', true); // 다시 읽기 전용으로 설정
            textarea.style.pointerEvents = "none"; // 다시 읽기 전용으로 설정
            textarea.style.border = "none"; // 테두리 제거
            textarea.style.background = "transparent"; // 배경색 제거
            button.innerText = '댓글수정'; // 버튼 텍스트 원래대로 복원
            editForm.submit(); 
        };
    }
</script>
</head>
<body>
<nav>

   <c:choose>
      <c:when test="${user.admin == 1 }">
         <div id="adminmenu" class="menu">
            <a href="/home"><img src="/logo/logo.png"></a>
            <div class="menulist">
               <a href="/home">도서관 홈</a>
               <a href="/book/record">대출/반납</a>
               <a href="/book/add">도서 추가</a>
               <a href="/book/manage">도서 수정/삭제</a>
               <a href="/board/search">게시판</a>
               <a href="/admin/mypage">사서 페이지</a>
               <a href="/admin/blacklist">유저 관리</a>
            </div>
            <div class="button-container">
               <c:choose>
                  <c:when test="${empty user or empty user.userID}">
                     <button id="loginbutton" onclick="location.href='/login';">로그인</button>
                  </c:when>
                  <c:otherwise>
                     <p>${user.userID }님</p>
                     <form action="/logout" method="post">
                        <button style= "color: black;" "id="logoutbutton" >로그아웃</button>
                     </form>
                  </c:otherwise>
               </c:choose>
           </div>
         </div>
      </c:when>
      <c:otherwise>
         <div id="usermenu" class="menu">
            <a href="/home"><img src="/logo/logo.png"></a>
            <div class="menulist">
               <a href="/home">도서관 홈</a>
               <a href="/search">도서 검색</a>
               <a href="/recomm">추천 도서</a>
               <a href="/board/search">게시판</a>
               <a href="/mypage">마이 페이지</a>
            </div>
            <div class="button-container">
               <c:choose>
                  <c:when test="${empty user or empty user.userID}">
                     <button id="joinbutton" onclick="location.href='/join';">회원 가입</button>
                     <button id="loginbutton" onclick="location.href='/login';">로그인</button>
                  </c:when>
                  <c:otherwise>
                     <p>${user.userID }님</p>
                     <form action="/logout" method="post">
                        <button style= "color: black;"  id="logoutbutton">로그아웃</button>
                     </form>
                  </c:otherwise>
               </c:choose>
           </div>
         </div>
      </c:otherwise>
   </c:choose>
   <hr>
</nav>
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
        <div style="text-align: right;">
            <%-- 로그인된 userno와 게시판의 userno가 같을 때만 수정 및 삭제 버튼을 표시. 게시글 상태가 BLIND일 경우 버튼을 표시하지 않음 --%>
			<c:if test="${ user.userno == bcontent.userno && bcontent.state != 'BLIND'}"> 
  		  <!-- 게시글 수정 버튼 -->
   		 	<form action="/board/mod/${bcontent.boardno}" method="get" onsubmit="return confirmAction('게시글을 수정하시겠습니까?')">
   		    	<button style= "color: white; "type="submit">게시글 수정</button>
  		  	</form>
  		  <!-- 게시글 삭제 버튼 -->
  		  	<form action="/board/delete/${bcontent.boardno}" method="get" onsubmit="return confirmAction('게시글을 삭제하시겠습니까?')">
  		     	 <button style= "color: white; type="submit">게시글 삭제</button>
   		 	</form>
			</c:if>	
			<c:if test="${ user.userno != bcontent.userno && bcontent.state != 'BLIND'}"> 
            <form action="/board/report/${bcontent.boardno}" method="post" onsubmit="return handleReport(event, this)">
                <input type="hidden" name="userno" value="${bcontent.userno}">
                <input type="hidden" name="contents" value="${bcontent.contents}">
                <button type="submit" class="report-post-btn">게시글 신고하기</button>
            </form>
            </c:if>
        </div>   
        </c:otherwise>
    </c:choose>

    <%-- 댓글 섹션 시작 --%>
    <div class="comment-section">
        <ul>
            <c:forEach items="${commList}" var="comment">
                <li class="comment"> 
                    <c:choose>
                        <c:when test="${comment.state == 'BLIND'}">
                            <p>이 글은 블라인드 처리되었습니다.</p>
                        </c:when>
                        <c:otherwise>
                            <div class="comment-box">
                                <div class="text-content comment-content">
                                    <div class="comment-info">작성자: ${comment.userId} | 작성일: ${comment.write_date} </div>
         							<form action="/comm/update" method="post" id="editForm_${comment.commno}">
                                    <textarea id="commentTextarea_${comment.commno}" name ="contents" style="pointer-events: none; resize:none; background: transparent;" readonly="readonly" required>${comment.contents}</textarea>
                                      <input type="hidden" name="commno" value="${comment.commno}">
                                        <input type="hidden" name="boardno" value="${bcontent.boardno}">
                                    </form>
                                    
                                    <c:if test="${ user.userno == comment.userno && comment.state != 'BLIND'}"> 
                                        <div class="edit-delete-btns">
                                            <button style ="background-color: #007bff; color: white;"type="button" class="comment-button" onclick="editComment(this, ${comment.commno})">댓글수정</button>
                                            <form action="/comm/delete/${bcontent.boardno}/${comment.commno}" method="post" onsubmit="handleDelete(event)">
                                                <button style="color: white;" type="submit" class="report-btn">댓글삭제</button>
                                            </form>
                                            
                                        </div>
                                    </c:if>
                                    <c:if test="${ user.userno != comment.userno && comment.state != 'BLIND'}">
                                        <div class="edit-delete-btns">
                                            <form action="/comm/report/${comment.commno}" method="post" onsubmit="return handleReport(event, this)">
                                                <input type="hidden" name="boardno" value="${bcontent.boardno}">
                        						<input type="hidden" name="userno" value="${comment.userno}">
                        						<input type="hidden" name="contents" value="${comment.contents}">
                                                <button type="submit" class="report-btn">댓글 신고하기</button>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </li>
            </c:forEach>
        </ul>
    </div>
    <%-- 댓글 섹션 끝 --%>

    <%-- 댓글 작성 섹션 시작 --%>
    <div class="comment-form">
        <form action="/comm/write" method="post" onsubmit="checkCommentInput()">
            <input type="hidden" name="boardno" value="${bcontent.boardno}">
            <input type="hidden" name="userno" value="${user.userno}">
            <textarea name="contents" placeholder="새로운 댓글 내용을 입력하세요." required oninput="checkCommentInput()"></textarea>
            <div style= margin-left:20px;><button type="submit" style= "color:white;">댓글 작성</button></div>
        </form>
    </div>
    <%-- 댓글 작성 섹션 끝 --%>

    <div style="text-align: right; margin-top: 20px;">
        <a href="/board/search" class="back-button">게시글로 돌아가기</a>
    </div>
</div>
<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>
</body>
</html>