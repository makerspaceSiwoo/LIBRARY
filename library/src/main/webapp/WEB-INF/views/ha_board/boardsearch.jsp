<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 검색</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        
        .pagination {
            display: flex;
            list-style-type: none;
            padding: 0;
            margin-top: 20px;
        }
        
        .pagination li {
            margin: 0 2px;
        }
        
        .pagination li a {
            text-decoration: none;
            padding: 8px 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            color: #007bff; /* 링크 색상 */
        }
        
        .pagination li a:hover {
            background-color: #ddd; /* 호버 시 배경색 */
        }
        
        .pagination li.active a {
            background-color: #007bff; /* 현재 페이지 색상 */
            color: white; /* 현재 페이지 텍스트 색상 */
        }

        .pagination li.disabled a {
            color: #ccc; /* 비활성화된 링크 색상 */
            pointer-events: none; /* 클릭 불가 */
        }

        h2 {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<h1>게시판 검색</h1>

<!-- 검색 폼 -->
<form action="/board/search" method="get">
    <label for="type">분류:</label> 
    <select name="type" id="type">
        <option value="" <c:if test="${type == ''}">selected</c:if> >전체</option>
        <option value="announcement" <c:if test="${type == 'announcement'}">selected</c:if>>공지사항</option>
        <option value="free" <c:if test="${type == 'free'}">selected</c:if>>자유</option>
        <option value="recommend" <c:if test="${type == 'recommend'}">selected</c:if>>추천</option>
        <option value="review" <c:if test="${type == 'review'}">selected</c:if>>리뷰</option>
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

        <!-- 페이징 네비게이션 -->
        <ul class="pagination">
            
                <li><a href="/board/search?type=${type}&title=${title}&p=${currentPage - 1}" onclick="prepage(event)">이전</a></li>
            
            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <li class="active"><strong>${i}</strong></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/board/search?type=${type}&title=${title}&p=${i}">${i}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            
                <li><a href="/board/search?type=${type}&title=${title}&p=${currentPage + 1}" onclick="postpage(event)">다음</a></li>
            
        </ul>
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
</html>

