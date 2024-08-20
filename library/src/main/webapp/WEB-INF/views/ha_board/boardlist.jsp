<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>
<%-- boardlist.jsp 지금 사용 안하는중 JController의 public String boardList 도 주석처리중  --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
<h1>게시판</h1> 
<%-- 게시판 상세 페이지 링크 --%>
<c:forEach items="${blist}" var="b">
    <p>${b.type} <a href="/board/no/${b.boardno}"> ${b.title}</a> ${b.write_date}</p>
</c:forEach>
<%-- 게시판 페이징 기능  --%>
<div>
    <c:if test="${currentPage > 1}">
        <a href="/board/list?p=${currentPage - 1}">이전</a>
    </c:if>

    <c:set var="startPage" value="${currentPage - 2}" />
    <c:set var="endPage" value="${currentPage + 2}" />

    <!-- startPage가 1보다 작거나 endPage가 totalPages보다 클 경우 조정 -->
    <c:if test="${startPage < 1}">
        <c:set var="startPage" value="1" />
    </c:if>
    <c:if test="${endPage > totalPages}">
        <c:set var="endPage" value="${totalPages}" />
    </c:if>

    <!-- 첫 페이지에서 항상 5개 페이지를 보여주도록 설정 -->
    <c:if test="${endPage - startPage < 4}">
        <c:set var="endPage" value="${startPage + 4}" />
        <c:if test="${endPage > totalPages}">
            <c:set var="endPage" value="${totalPages}" />
        </c:if>
    </c:if>

    <c:forEach var="i" begin="${startPage}" end="${endPage}">
        <c:if test="${i >= 1}">
            <a href="/board/list?p=${i}">${i}</a>
        </c:if>
    </c:forEach>

    <c:if test="${currentPage < totalPages}">
        <a href="/board/list?p=${currentPage + 1}">다음</a>
    </c:if>
</div>
</body>
</html>