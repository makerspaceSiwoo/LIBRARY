<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/header.css">
<meta charset="UTF-8">
<title>블랙리스트 관리</title>
<style>

     body {
        font-family: 'Arial', sans-serif;
        background-color: #f9f9f9;
        margin: 0;
        padding: 0;
        color: #333;
        
    }

    .container {
        display: flex;
        justify-content: center;
        padding: 40px 20px;
        gap: 20px;
    }

    .column {
        width: 40%;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }

    .column-header {
        font-size: 22px;
        font-weight: bold;
        color: #1a1a2e;
        margin-bottom: 20px;
        text-align: center;
        background-color: #3b82f6;
        color: #ffffff;
        padding: 10px;
        border-radius: 5px;
    }

    .blacklist-item {
        background-color: #f1f5f9;
        margin-bottom: 20px;
        padding: 20px;
        border-radius: 10px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border-left: 5px solid #3b82f6;
        text-align: center; /* 중앙 정렬 추가 */
    }

    .blacklist-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }

    .blacklist-item h4 {
        font-size: 18px;
        color: #1a1a2e;
        margin-top: 0; 
        margin-bottom: 15px;
    }

    .blacklist-item .item-details {
        display: grid;
        grid-template-columns: 1fr;
        gap: 10px;
        margin-bottom: 20px;
        justify-items: center; /* 중앙 정렬 추가 */
    }

    .blacklist-item .item-details span.label {
        font-weight: bold;
        color: #1a1a2e;
        font-size: 12.6px; /* 기존 크기의 70%로 줄임 */
    }

    .blacklist-item .item-details span.value {
        color: #4b5563;
        font-size: 18px; /* 글씨 크기 조정 */
    }

    .button-container {
        display: flex;
        gap: 10px;
        justify-content: center;
        margin-top: 15px;
        flex-wrap: wrap; /* 필요 시 줄바꿈 */
    }

    .blacklist-item button {
        background-color: #e74c3c;
        color: white;
        border: none;
        padding: 6px 10px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        font-weight: bold;
        transition: background-color 0.3s ease;
    }

    .blacklist-item button:hover {
        background-color: #c0392b;
    }

    .blacklist-item button.view-btn {
        background-color: #10b981;
    }

    .blacklist-item button.view-btn:hover {
        background-color: #059669;
    }

    .blacklist-item button.delete-btn {
        background-color: #f59e0b;
        color: #1a1a2e;
    }

    .blacklist-item button.delete-btn:hover {
        background-color: #d97706;
    }

    .blacklist-item button.forbid-btn {
        background-color: #3b82f6;
    }

    .blacklist-item button.forbid-btn:hover {
        background-color: #2563eb;
    }

</style>
<script>
    function confirmBan() {
        return confirm("이 사용자를 블라인드 처리하시겠습니까?");
    }

    function confirmDelete() {
        return confirm("블랙리스트를 삭제하겠습니까?");
    }

    function confirmForbid1() {
        return confirm("게시물 작성 3일 정지를 시키겠습니까?");
    }
    function confirmForbid2() {
        return confirm("게시물 작성 정지 -3일 시키겠습니까?");
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
                        <button id="logoutbutton" >로그아웃</button>
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
                        <button id="logoutbutton">로그아웃</button>
                     </form>
                  </c:otherwise>
               </c:choose>
           </div>
         </div>
      </c:otherwise>
   </c:choose>
   <hr>
</nav>

    <div class="container">
        <!-- Left column: black.forbid_end == null -->
        <div class="column">
            <div class="column-header">신고된 유저</div>
            <c:set var="currentTime" value="<%= new java.util.Date() %>" />
            <c:forEach items="${blacklistdto}" var="black">
                <c:if test="${black.forbid_end == null || black.forbid_end < currentTime}">
                    <div class="blacklist-item">
                        <h4>블랙리스트 번호: ${black.blacklistno}</h4>
                    
                        <div class="item-details">
                            <span class="label">(게시글,댓글로인한)밴 기한:</span>
                            <span class="value"><fmt:formatDate value="${black.forbid_end}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" /></span>
                            <span class="label">신고 이유:</span>
                            <span class="value">${black.reason}</span>
                            <span class="label">유저 번호:</span>
                            <span class="value">${black.userno}</span>
                            <span class="label">게시글 번호:</span>
                            <span class="value">${black.boardno}</span>
                            <span class="label">댓글 번호:</span>
                            <span class="value">${black.commno}</span>
                            <span class="label">신고당한 글 내용:</span>
                            <span class="value">${black.contents}</span>
                        </div>
                        
                        <div class="button-container">
                            <form action="/board/no/${black.boardno}">
                                <button type="submit" class="view-btn">신고게시글보기</button>
                            </form>
                    
                            <form id="banForm_${black.boardno}_${black.commno}" action="/admin/ban" method="post" onsubmit="return confirmBan()">
                                <input type="hidden" name="boardno" value="${black.boardno}"/>
                                <input type="hidden" name="commno" value="${black.commno}"/>
                                <button type="submit">블라인드처리</button> 
                            </form>

                            <form action="/admin/ban/forbid_end" method="post" onsubmit="return confirmForbid1()">
                                <input type="hidden" name="blacklistno" value="${black.blacklistno}"/>
                                <input type="hidden" name="userno" value="${black.userno}"/>
                                <input type="hidden" name="boardno" value="${black.boardno}"/>
                                <input type="hidden" name="deadline" value="+3"/>
                                <input type="hidden" name="forbid_end" value="${black.forbid_end}"/>
                                <button type="submit" class="forbid-btn">벤(+3일)</button>
                            </form>
                             <form action="/admin/ban/forbid_end" method="post" onsubmit="return confirmForbid2()">
                                <input type="hidden" name="blacklistno" value="${black.blacklistno}"/>
                                <input type="hidden" name="userno" value="${black.userno}"/>
                                <input type="hidden" name="boardno" value="${black.boardno}"/>
                                <input type="hidden" name="deadline" value="-3"/>
                                <input type="hidden" name="forbid_end" value="${black.forbid_end}"/>
                                <button type="submit" class="forbid-btn">밴(-3일)</button>
                             </form>
                             <form action="/admin/ban/delete" method="post" onsubmit="return confirmDelete()">
                                <input type="hidden" name="blacklistno" value="${black.blacklistno}"/>
                                <button type="submit" class="delete-btn">블랙리스트삭제</button>
                            </form>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <!-- Right column: black.forbid_end != null -->
        <div class="column">
            <div class="column-header">제재당한 유저(밴 기한)</div>
            <c:set var="currentTime" value="<%= new java.util.Date() %>" />
            <c:forEach items="${blacklistdto}" var="black">
                <c:if test="${black.forbid_end != null && black.forbid_end > currentTime}">
                    <div class="blacklist-item">
                        <h4>블랙리스트 번호: ${black.blacklistno}</h4>
                        <div class="item-details">
                            <span class="label">(게시글,댓글로인한)밴 기한:</span>
                            <span class="value"><fmt:formatDate value="${black.forbid_end}" pattern="yyyy년 MM월 dd일 HH시 mm분 ss초" /></span>
                            <span class="label">신고 이유:</span>
                            <span class="value">${black.reason}</span>
                            <span class="label">유저 번호:</span>
                            <span class="value">${black.userno}</span>
                            <span class="label">게시글 번호:</span>
                            <span class="value">${black.boardno}</span>
                            <span class="label">댓글 번호:</span>
                            <span class="value">${black.commno}</span>
                            <span class="label">신고당한 글 내용:</span>
                            <span class="value">${black.contents}</span>
                        </div>
                        
                        <div class="button-container">
                            <form action="/board/no/${black.boardno}">
                                <button type="submit" class="view-btn">신고게시글보기</button>
                            </form>
                    
                            <form id="banForm_${black.boardno}_${black.commno}" action="/admin/ban" method="post" onsubmit="return confirmBan()">
                                <input type="hidden" name="boardno" value="${black.boardno}"/>
                                <input type="hidden" name="commno" value="${black.commno}"/>
                                <button type="submit">블라인드처리</button> 
                            </form>

                            <form action="/admin/ban/forbid_end" method="post" onsubmit="return confirmForbid1()">
                                <input type="hidden" name="blacklistno" value="${black.blacklistno}"/>
                                <input type="hidden" name="userno" value="${black.userno}"/>
                                <input type="hidden" name="boardno" value="${black.boardno}"/>
                                <input type="hidden" name="deadline" value="+3"/>
                                <input type="hidden" name="forbid_end" value="${black.forbid_end}"/>
                                <button type="submit" class="forbid-btn">밴(+3일)</button>
                            </form>
                             <form action="/admin/ban/forbid_end" method="post" onsubmit="return confirmForbid2()">
                                <input type="hidden" name="blacklistno" value="${black.blacklistno}"/>
                                <input type="hidden" name="userno" value="${black.userno}"/>
                                <input type="hidden" name="boardno" value="${black.boardno}"/>
                                <input type="hidden" name="deadline" value="-3"/>
                                <input type="hidden" name="forbid_end" value="${black.forbid_end}"/>
                                <button type="submit" class="forbid-btn">밴(-3일)</button>
                             </form>
                             
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
<footer>
<p>© 2024. Soldesk도서관. all rights reserved..</p>
</footer>
</body>
</html>
