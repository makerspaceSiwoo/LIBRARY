<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판 검색</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f6f9;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
        }

        header {
            padding: 20px;
            width: 100%;
            position: fixed;
            top: 0;
            background-color: #343a40;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        #logo {
            display: flex;
            align-items: center;
        }

        #logo img {
            max-width: 120px;
            height: auto;
        }

        nav a {
            color: white;
            margin: 0 15px;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        nav a:hover {
            color: #adb5bd;
        }

        #menu {
            background-color: white;
            padding: 100px 30px 30px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 80%;
            margin-top: 80px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            margin-bottom: 30px;
            color: #343a40;
            font-size: 28px;
            font-weight: bold;
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
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ced4da;
            font-size: 16px;
        }

        .search-form select, 
        .search-form input[type="text"] {
            width: 200px;
        }

        .search-form button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .search-form button:hover {
            background-color: #0056b3;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .table th, .table td {
            padding: 12px;
            border: 1px solid #dee2e6;
            text-align: center;
        }

        .table th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #495057;
        }

        .table td a {
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .table td a:hover {
            color: #0056b3;
        }

        .results h2 {
            font-size: 22px;
            color: #495057;
            margin-bottom: 20px;
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
            padding: 8px 16px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            color: #6c757d;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .pagination li.active a {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }

        .pagination li.disabled a {
            color: #adb5bd;
            pointer-events: none;
        }

        .pagination a:hover {
            background-color: #e9ecef;
            color: #007bff;
        }

        .write-button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
            display: inline-block;
            text-align: center;
        }

        .write-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<header>
    <div id="logo">
        <a href="/home"><img src="/logo/logo.png" alt="Logo"></a>
        <span>도서관</span>
    </div>
    <nav>
        <a href="/home">도서관 홈</a>
        <a href="/search">도서 검색</a>
        <a href="/recomm">추천 도서</a>
        <a href="/board/search">게시판</a>
        <a href="/mypage">마이 페이지</a>
        <c:choose>
            <c:when test="${empty user}">
                <a href="/login">로그인</a>
                <a href="/join">회원 가입</a>
            </c:when>
            <c:otherwise>
                <span>${user.userID}</span>
                <form action="/logout" method="post" style="display:inline;">
                    <button type="submit" style="background-color: #dc3545; color: white; border: none; border-radius: 4px; padding: 5px 10px;">로그아웃</button>
                </form>
            </c:otherwise>
        </c:choose>
    </nav>
</header>

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
            <c:when test="${not empty searchResults}">
                <h2>검색 결과</h2>
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
