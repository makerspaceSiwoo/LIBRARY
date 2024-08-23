<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>book info</title>
</head>
<body>

<div>
	<hr>
		<span id="bookimg">
			<img alt="표지사진" src="${blist[0].img }" width="200">
		</span>
		<span id="bookinfo">
			<table border="1">
				<tr>
					<td colspan="3" align="center">제목 : ${blist[0].booktitle }</td>
				</tr>
				<tr>
					<td align="center">저자</td > <td align="center">출판사</td> <td align="center">출판연도</td>
				</tr>
				<tr>
					<td align="center">${blist[0].author}</td> <td align="center">${blist[0].publisher}</td> <td align="center">${blist[0].pubyear }</td>
				</tr>
			</table>
		</span>
	<hr>
</div>

<div>
	<table border="1">
		<tr>
			<td colspan="5" align="center">소장정보</td>
		</tr>
		<tr>
			<td align="center">서가 위치</td> <td align="center">관리 번호</td> <td align="center">청구기호</td> <td align="center">대출상태</td>  <td align="center">반납예정일</td>
		</tr>
		<c:forEach var="b" items="${blist }" >
			<tr>
				<td align="center">${b.loc}</td> 
				<td align="center">${b.bookno }</td>
				<td align="center">${b.callno}</td> 
				<c:choose>
					<c:when test="${b.userno == null || b.userno == '' }">
						<td align="center">대출 가능</td>
						<td align="center">-</td>
					</c:when>
					<c:otherwise>
						<td align="center">대출 중</td>
						<td align="center">${b.end }</td>
					</c:otherwise>
				</c:choose>
			</tr>
		</c:forEach>
	</table>
</div>

<c:choose>
<c:when test="${otherbooks.size() != 0 }">
<div>
	<hr>
	<h2>작가의 다른 책</h2>
	<hr>
	<div class="section">    
    <div class="book-list">
        <c:forEach var="b" items="${otherbooks}">
            <div class="book-item" onclick="location.href='/search/no=${b.callno}'">
                <img alt="표지사진" src="${b.img}">
                <div class="title">${b.booktitle}</div>
                <div class="author">${b.author}</div>
                <div class="publisher">${b.publisher}</div>
            </div>
        </c:forEach>
    </div>
	</div>
	<hr>
</div>
</c:when>
<c:otherwise>
	<hr>
	<h2>작가의 다른 책</h2>
	<hr>
	<p>소장 중인 작가의 다른 작품이 없습니다.</p>
</c:otherwise>
</c:choose>

</body>
</html>