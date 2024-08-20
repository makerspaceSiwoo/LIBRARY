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
    <input type="text" name="title" id="title" value="${title}" />

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

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
    $(function(){
        // 이미 서버에서 전달된 값을 사용하여 select 박스와 input 값을 설정
        $("#type").val("${type}"); // 선택된 분류 유지
        $("#title").val("${title}"); // 이전 제목 유지
    });
</script>
</html>


