<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>검색 기능</title>
</head>
<body>
<h1>게시판 검색</h1>

<!-- 검색 폼 -->
<form action="/board/search" method="get">
    <label for="type">분류:</label>
    <select name="type" id="type">
        <option value="announcement">공지사항</option>
        <option value="free">자유</option>
        <option value="recommend">추천</option>
        <option value="review">리뷰</option>
    </select>
    
    <label for="title">제목:</label>
    <input type="text" name="title" id="title" />

    <button type="submit">검색</button>
</form>

<!-- 검색 결과 표시 -->
<c:choose>
    <c:when test="${not empty searchResults}">
        <h2>검색 결과</h2>
        <c:forEach items="${searchResults}" var="result">	
            <p>${result.type} <a href="/board/no/${result.boardno}">${result.title}</a> ${result.write_date}</p>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <h2>검색 결과가 없습니다.</h2>
    </c:otherwise>
</c:choose>

</body>
</html>