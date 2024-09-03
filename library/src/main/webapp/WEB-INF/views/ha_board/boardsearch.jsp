<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet" type="text/css" href="/css/header.css">
    <meta charset="UTF-8">
    <title>게시판 검색</title>
    <style>
        /* 전체 페이지 스타일 */
        
html {
   height: 100vh;
}

body {
   min-height:100vh;
   height: auto;
   position: relative;
}

footer {

   bottom: 0;
}
main {
	min-height:68vh;
    flex: 1; /* 남은 공간을 차지하도록 설정 */
    display: flex;
    flex-direction: column;
    margin-left: 0;
}
        
        
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
        }

        nav a {
            color: #333;
            margin: 0 15px;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        nav a:hover {
            color: #555;
        }

        h1 {
            margin-bottom: 30px;
            color: #343a40;
            font-size: 32px;
            font-weight: 700;
            text-align: center;
        }

        .search-form {
            display: flex;
            gap: 15px;
            justify-content: center;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .search-form label {
            font-weight: bold;
            color: #495057;
        }

        .search-form select, 
        .search-form input[type="text"],
        .search-form button {
            padding: 10px 15px;
            border-radius: 8px;
            border: 1px solid #ced4da;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .search-form select, 
        .search-form input[type="text"] {
            width: 220px;
            background-color: #fff;
        }

        .search-form button {
            background-color: #3C33A4; /* 하늘색 진하게 */
            color: white;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .search-form button:hover {
            background-color: #2D2489; /* 하늘색 진하게 */
        }

        .results {
            margin-top: 40px;
            text-align: center;
        }

        .results h2 {
            font-size: 24px;
            color: #495057;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
            margin-top: 20px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            background-color: #ffffff;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed; /* 고정된 테이블 레이아웃을 사용하여 크기 변화 방지 */
            background-color: white;
        }

        .table th, .table td {
            padding: 16px;
            text-align: center;
            white-space: nowrap; /* 텍스트 줄 바꿈 방지 */
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .table th {
            background-color: #3C33A4; /* 하늘색으로 변경 */
            color: white;
            font-weight: 600;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        .table td {
            background-color: #f9f9f9;
            border-bottom: 1px solid #e0e0e0;
            color: #333;
            transition: background-color 0.3s ease;
        }

        .table td a {
            color: #333;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .table td:hover {
            background-color: #f1f1f1;
        }

        .table td a:hover {
            color: #2D2489; /* 하늘색 진하게 */
        }

        .pagination {
            display: flex;
            list-style-type: none;
            padding: 0;
            margin-top: 30px;
            justify-content: center;
        }

        .pagination li {
            margin: 0 5px;
        }

        .pagination a {
            text-decoration: none;
            padding: 10px 20px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            color: #333;
            transition: background-color 0.3s ease, color 0.3s ease;
            background-color: #ffffff;
        }

        .pagination li.active a {
            background-color: #3C33A4; /* 하늘색으로 변경 */
            color: white;
            border: 1px solid #333;
        }

        .pagination li.disabled a {
            color: #adb5bd;
            pointer-events: none;
            background-color: #f1f1f1;
        }

        .pagination a:hover {
            background-color: #CCF2FF;
            color: #555;
        }

        .write-button {
            background-color: #3C33A4; /* 하늘색으로 변경 */
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
            display: inline-block;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .write-button:hover {
            background-color: #2D2489; /* 하늘색 진하게 */
        }
    </style>
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
                        <button id="logoutbutton">로그아웃</button>
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
<main>
<section>
<div id="menu">
    <h1>게시판 검색</h1>

    <form action="/board/search" method="get" class="search-form">
        <label for="type">분류:</label>
        <select name="type" id="type">
            <option value="" <c:if test="${type == ''}">selected</c:if>>전체</option>
            <option value="announcement" <c:if test="${type == 'announcement'}">selected</c:if>>공지사항</option>
            <option value="free" <c:if test="${type == 'free'}">selected</c:if>>자유</option>
            <option value="recommend" <c:if test="${type == 'recommend'}">selected</c:if>>추천</option>
            <option value="review" <c:if test="${type == 'review'}">selected</c:if>>리뷰</option>
        </select>
        <label for="title">제목:</label>
        <input type="text" name="title" id="title" value="${title}" />
        <button type="submit">검색</button>
    </form>

    <div class="results">
    <c:choose>
        <c:when test="${totalCount > 0}">
            <h2>검색 결과</h2>
            <div class="table-wrapper">
                <table class="table">
                    <thead>
                        <tr>
                            <th>분류</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${searchResults}" var="result">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${result.type == 'announcement'}">공지사항</c:when>
                                        <c:when test="${result.type == 'free'}">자유</c:when>
                                        <c:when test="${result.type == 'recommend'}">추천</c:when>
                                        <c:when test="${result.type == 'review'}">리뷰</c:when>
                                        <c:otherwise>기타</c:otherwise> 
                                    </c:choose>
                                </td>
                                <td><a href="/board/no/${result.boardno}">${result.title}</a></td>
                                <td>${result.userID}</td>
                                <td><fmt:formatDate value="${result.write_date}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td>${result.view}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <ul class="pagination">
                <li class="${currentPage <= 1 ? 'disabled' : ''}">
                    <a href="/board/search?type=${type}&title=${title}&p=${currentPage - 1}" onclick="return prepage(event)">이전</a>
                </li>
                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <li class="active"><strong>${i}</strong></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="/board/search?type=${type}&title=${title}&p=${i}">${i}</a></li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <li class="${currentPage >= totalPages ? 'disabled' : ''}">
                    <a href="/board/search?type=${type}&title=${title}&p=${currentPage + 1}" onclick="return postpage(event)">다음</a>
                </li>
            </ul>

            <!-- 글작성 버튼을 이전/다음 버튼 아래로 이동 -->
            <form action="/board/write" method="get" style="text-align: center;">
                <button type="submit" class="write-button">글작성</button>
            </form>

        </c:when>
        <c:otherwise>
            <h2>검색 결과가 없습니다.</h2>
        </c:otherwise>
    </c:choose>
</div>

</div>
</section>
</main>
<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
    $(function(){
        $("#type").val("${type}");
        $("#title").val("${title}");
    });

    function prepage(e){
        if(${currentPage} <= 1){
            e.preventDefault();
            return false;
        }
    }

    function postpage(e){
        if(${currentPage} >= ${totalPages} ){
            e.preventDefault();
            return false;
        }
    }
</script>
</body>
</html>
