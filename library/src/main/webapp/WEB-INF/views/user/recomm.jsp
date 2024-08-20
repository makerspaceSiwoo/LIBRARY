<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>도서 추천 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding-right: 220px; /* navbar 공간 확보를 위한 오른쪽 여백 */
        }
        .topmenu {
            padding: 10px;
            text-align: center;
            border-bottom: 10px solid #3C33A4; /* 어두운 파란색 구분선 */
        }
        .topmenu a {
            margin: 0 15px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        .navbar {
            position: fixed;
            top: 0;
            right: 0;
            width: 200px;
            height: 100%; /* 화면 전체 높이에 맞춤 */
            background-color: #f4f4f4; /* 밝은 회색 배경 */
            padding-top: 20px;
            border-left: 1px solid #ddd;
            box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1); /* 살짝 그림자 효과 */
        }
        .navbar a {
            color: black; /* 링크의 텍스트 색상을 검은색으로 설정 */
            text-decoration: none; /* 링크의 기본 밑줄 제거 */
            display: block; /* 링크를 블록 요소로 설정 */
            padding: 10px; /* 링크의 내부 여백 설정 */
            margin: 10px 0; /* 각 링크 사이의 여백 설정 */
            border-radius: 4px; /* 링크의 모서리를 둥글게 설정 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }

        .navbar a:hover {
            background-color: rgba(0, 0, 0, 0.1); /* 링크에 마우스를 올렸을 때 배경색을 연한 검정색으로 변경 */
        }
        h2 {
            margin-top: 0; /* 상단 여백 제거 */
            text-align: center;
        }
        .section {
            margin-bottom: 100px;
        }
        .section h3 {
            margin-bottom: 10px; /* 간격 조정 */
            text-align: center;
        }
        hr {
            margin-top: 0; /* 상단 여백 제거 */
            margin-bottom: 0; /* 하단 여백 제거 */
            padding: 0;
        }
        .book-list {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
        }
        .book-item {
            cursor: pointer;
            text-align: center;
            width: 18%;
        }
        .book-item img {
            width: 40%;
            height: auto;
        }
        .book-item .title {
            font-weight: bold;
            margin-top: 10px;
        }
        .book-item .author, .book-item .publisher {
            margin-top: 5px;
            color: #555;
        }
    </style>
</head>
<body>

<div class="topmenu">
    <a href="/home">도서관 홈</a>
    <a href="/search">도서 검색</a>
    <a href="/recomm">인기도서</a>
    <a href="/mypage">마이 페이지</a>
    <a href="/board/list">나눔마당</a>
    <a href="/login">로그인</a>
    <a href="/join">회원가입</a>
</div>

<div class="navbar">
    <a href="#all">전체</a>
    <a href="#category">${user.userID}님 맞춤 카테고리별 추천 도서</a>
    <a href="#gender">
        <c:if test="${user.gender == 'M'}">남성 추천 도서</c:if>
        <c:if test="${user.gender == 'F'}">여성 추천 도서</c:if>
    </a>
    <a href="#agegroup">${agerc[0].agegroup} 추천 도서</a>
</div>

<hr>
<h2>${user.userID}님 추천 도서</h2>

<div class="section">
    <hr>
    <h3 id="all">전체</h3>
    <hr>
    <div class="book-list">
        <c:forEach var="all" items="${allrc}">
            <div class="book-item" onclick="location.href='/search/no=${all.callno}'">
                <img alt="표지사진" src="${all.img}">
                <div class="title">${all.booktitle}</div>
                <div class="author">${all.author}</div>
                <div class="publisher">${all.publisher}</div>
            </div>
        </c:forEach>
    </div>
</div>
<hr>

<div class="section">
    <h3 id="category">${user.userID}님 맞춤 카테고리별 추천 도서</h3>
    <hr>
    <div class="book-list">
        <c:forEach var="cate" items="${caterc}">
            <div class="book-item" onclick="location.href='/search/no=${cate.callno}'">
                <img alt="표지사진" src="${cate.img}">
                <div class="title">${cate.booktitle}</div>
                <div class="author">${cate.author}</div>
                <div class="publisher">${cate.publisher}</div>
            </div>
        </c:forEach>
    </div>
</div>
<hr>

<div class="section">
    <h3 id="gender">
        <c:if test="${user.gender == 'M'}">남성 추천 도서</c:if>
        <c:if test="${user.gender == 'F'}">여성 추천 도서</c:if>
    </h3>
    <hr>
    <div class="book-list">
        <c:forEach var="gen" items="${genrc}">
            <div class="book-item" onclick="location.href='/search/no=${gen.callno}'">
                <img alt="표지사진" src="${gen.img}">
                <div class="title">${gen.booktitle}</div>
                <div class="author">${gen.author}</div>
                <div class="publisher">${gen.publisher}</div>
            </div>
        </c:forEach>
    </div>
</div>
<hr>

<div class="section">
    <h3 id="agegroup">${agerc[0].agegroup} 추천 도서</h3>
    <hr>
    <div class="book-list">
        <c:forEach var="age" items="${agerc}">
            <div class="book-item" onclick="location.href='/search/no=${age.callno}'">
                <img alt="표지사진" src="${age.img}">
                <div class="title">${age.booktitle}</div>
                <div class="author">${age.author}</div>
                <div class="publisher">${age.publisher}</div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>
