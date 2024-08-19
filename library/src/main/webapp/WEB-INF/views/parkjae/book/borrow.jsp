<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


</head>
<body>
<h1>대출관리</h1>
<form action="/book/record" method="GET">
<input type="text" name="booktitle">
<button type="submit" >검색</button>
</form>
<table border="1">   
	<tr>
		<td>"제목"검색결과</td><br>
	</tr>
	<tr> 
		<c:forEach items="${unreturned}" var="borrow">
			<tr><td>${fn:substring(borrow.booktitle, 0, 10)}</td>
            <td>${fn:substring(borrow.author, 0, 10)}</td>
            <td>${fn:substring(borrow.callno, 0, 10)}</td>
			<c:if test="${borrow.userno != 0 }">
				<c:if test="${borrow.u_end.time <= now.time}">	
					<c:set var="formattedDate">
					<fmt:formatDate value="${borrow.u_end}" pattern="yyyy-MM-dd"/>
					</c:set>
					<td style="color: red;">${formattedDate}</td>
					<td><button type="button" style="color: red;" onclick="location.href='/book/latereturn?userno=${borrow.userno}&formattedDate=${formattedDate}&bookno=${borrow.bookno}'">
					반납
					</button>
				</td>
				</c:if>
				<c:if test="${borrow.u_end.time > now.time}">		
					<td><fmt:formatDate value="${borrow.u_end}" pattern="yyyy-MM-dd"/></td>
					<td><button type="button" onclick="location.href='/book/return?userno=${borrow.userno}&bookno=${borrow.bookno}'">
					반납
					</button>
				</td>
				</c:if>
				
			</c:if>
			
			
			<c:if test="${borrow.userno == 0 }">
				<td><button type="button" onclick="location.href='/book/lent?bookno=${borrow.bookno}'">대출</button></td>
			</c:if>
		</tr>
		</c:forEach>
		</tr>
</table>
</body>
</html>

