<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서 검색</title>
</head>
<body>
    <h1>도서 검색</h1>

    <form action="search">
        <!-- 검색 분류 -->
        <select name="searchn" id="searchn">
            <option value="0">제목+분류 검색</option>
            <option value="1">저자+분류 검색</option>
        </select>
        <span id="cateSelect">
      	<select id="cate" name="cate">
        		<option value="">전체</option>
        		<option value="총류">총류</option>
        		<option value="철학">철학</option>
        		<option value="종교">종교</option>
        		<option value="사회과학">사회과학</option>
        		<option value="자연과학">자연과학</option>
        		<option value="기술과학">기술과학</option>
        		<option value="예술">예술</option>
        		<option value="언어">언어</option>
        		<option value="문학">문학</option>
        		<option value="역사">역사</option>
        	</select>
        </span>
        <!-- 검색어 입력 필드 -->
        <input type="text" id="search" name="search" placeholder="검색어를 입력하세요" >
        <!-- 검색 버튼 -->
        <input type="submit" value="검색"/>

    </form>
    
    <div id="searchlist">
    	<h3>검색결과</h3>
    	<c:if test="${count == 0}">검색 결과 없음</c:if>
    	<c:if test="${count > 0}">
    		<table>
    			<c:forEach var="book" items="${bList }">
    			<div onclick="location.href='/search/no=${book.callno}'" style="cursor:pointer;">
    			<hr>
	    			<img alt="표지사진" src="${book.img}" width="80">
	    			${book.booktitle}
	    			${book.author}
	    			${book.publisher}
	    			${book.pubyear}
	    		<hr>
    			</div>
    		</c:forEach>
    		</table>
    		
    	</c:if>
    <div id="page">
				<c:if test="${begin > pageNum }">
					<a href="/search?searchn=${searchn }&search=${search }&p=${begin-1 }" class="page prv">&lt;</a>
				</c:if>
				<c:forEach begin="${begin }" end="${end}" var="i">
					<a href="/search?searchn=${searchn }&search=${search }&p=${i}">${i}</a>
				</c:forEach>
				<c:if test="${end < totalPages }">
					<a href="/search?searchn=${searchn }&search=${search }&p=${end+1}" class="page next">&gt;</a>
				</c:if>
			</div>
    </div>
 <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script>
        $(function(){
            // searchn 값을 이용하여 select 박스에서 해당 값을 선택
            $("#searchn").val("${searchn}");
			
            $("#search").val("${search}");
            
            // cate의 값을 설정하여 선택값을 유지
            $("#cate").val("${cate}");
        });
    </script>
</body>
</html>
