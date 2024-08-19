<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>사서 홈 페이지</title>

</head>
<body>
	<div>
		<a href="/admin/home">도서관 Home</a>
		<a href="/book/borrow">대출관리</a>
		<a href="/book/manage">도서추가</a>
		<a href="/admin/recomm">인기도서</a>
		<a href="">회원관리</a>
		<a href="board/list">나눔마당</a>
	</div>
	
	<div>
	<h2 id = "notice">공지사항 <button id="addnotice">+</button></h2>
	</div>
	
	
	<div>
        <h2 id="quantity">소장 도서 수</h2>
        <table>
            <thead>
                <tr>
                    <th>총류</th>
                    <th>철학</th>
                    <th>종교</th>
                    <th>사회과학</th>
                    <th>자연과학</th>
                    <th>기술과학</th>
                    <th>예술</th>
                    <th>언어</th>
                    <th>문학</th>
                    <th>역사</th>
                    <th>전체</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>${gunbook}</td>
                    <td>${chulbook}</td>
                    <td>${jongbook}</td>
                    <td>${sabook}</td>
                    <td>${zabook}</td>
                    <td>${gibook}</td>
                    <td>${artbook}</td>
                    <td>${unbook}</td>
                    <td>${munbook}</td>
                    <td>${yeokbook}</td>
                    <td>${allbook}</td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>