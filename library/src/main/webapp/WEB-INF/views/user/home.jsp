<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>도서관 홈 페이지</title>
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=75bada73f8c74910c3c69014a4957dd1"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        div {
            margin: 20px;
        }
        a {
            margin-right: 15px;
            text-decoration: none;
            color: #333;
        }
        a:hover {
            text-decoration: underline;
        }
        #map {
            width: 500px;
            height: 400px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        body {
    margin: 0;
    font-family: Arial, sans-serif;
    padding-right: 220px; /* 네비게이션 바 공간 확보 */
}

.navbar {
    position: fixed; /* 페이지 스크롤과 관계없이 고정 */
    right: 0; /* 화면 오른쪽에 붙이기 */
    top: 0; /* 화면 상단에 붙이기 */
    width: 200px; /* 네비게이션 바의 너비 */
    background-color: rgba(255, 255, 255, 0.8); /* 배경을 흰색에 80% 투명도로 설정 */
    color: black; /* 글자 색상을 검은색으로 설정 */
    height: 100vh; /* 화면 높이와 동일하게 설정 */
    overflow-y: auto; /* 스크롤이 필요할 경우 스크롤바 표시 */
    padding: 20px;
    box-sizing: border-box; /* 패딩을 포함한 너비 계산 */
    border-left: 1px solid #ddd; /* 왼쪽 경계선 추가 */
}

.navbar table {
    width: 100%; /* 테이블을 네비게이션 바의 전체 너비로 설정 */
    border-collapse: collapse; /* 테이블 셀 사이의 공백 제거 */
}

.navbar th, .navbar td {
    text-align: left;
    padding: 10px;
    border-bottom: 1px solid #ddd;
}

.navbar th {
    background-color: #f4f4f4; /* 헤더 배경색 */
}

.navbar a {
    color: black; /* 링크의 텍스트 색상을 검은색으로 설정 */
    text-decoration: none; /* 링크의 기본 밑줄 제거 */
    display: block; /* 링크를 블록 요소로 설정 */
    padding: 10px; /* 링크의 내부 여백 설정 */
    margin-bottom: 5px; /* 각 링크 사이의 여백 설정 */
    border-radius: 4px; /* 링크의 모서리를 둥글게 설정 */
}

.navbar a:hover {
    background-color: rgba(0, 0, 0, 0.1); /* 링크에 마우스를 올렸을 때 배경색을 연한 검정색으로 변경 */
}

.content {
    margin-right: 220px; /* 네비게이션 바 너비에 따라 조정 */
    padding: 20px;
}

        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var container = document.getElementById('map');
            var options = {
                center: new kakao.maps.LatLng(37.5693402, 126.9859964),
                level: 3
            };

            var map = new kakao.maps.Map(container, options);
            var markerPosition  = new kakao.maps.LatLng(37.5693402, 126.9859964);
            var marker = new kakao.maps.Marker({
                position: markerPosition
            });
            marker.setMap(map);
        });
    </script>
</head>
<body>
   <c:choose>
      <c:when test="${user.admin == 1 }">
         <div id="adminmenu">
            <a href="/home"><img src="/logo/logo.png"></a>
            <a href="/home">도서관 홈</a>
            <a href="/book/record">대출/반납</a>
            <a href="/book/add">도서 추가</a>
            <a href="/book/manage">도서 수정/삭제</a>
            <a href="/board/search">게시판</a>
            <a href="/admin/mypage">마이 페이지</a>
            <a href="/admin/blacklist">유저 관리</a>
            <c:choose>
               <c:when test="${empty user }">
                  <button onclick="location.href='/login';">로그인</button>
               </c:when>
               <c:otherwise>
                  <p>${user.userID }</p>
                  <form action="/logout" method="post">
                     <button>로그아웃</button>
                  </form>
               </c:otherwise>
            </c:choose>
         </div>
      </c:when>
      <c:otherwise>
         <div id="usermenu">
            <a href="/home"><img src="/logo/logo.png"></a>
            <a href="/home">도서관 홈</a>
            <a href="/search">도서 검색</a>
            <a href="/recomm">추천 도서</a>
            <a href="/board/search">게시판</a>
            <a href="/mypage">마이 페이지</a>
            <c:choose>
               <c:when test="${empty user }">
                  <button onclick="location.href='/join';">회원 가입</button>
                  <button onclick="location.href='/login';">로그인</button>
               </c:when>
               <c:otherwise>
                  <p>${user.userID }</p>
                  <form action="/logout" method="post">
                     <button>로그아웃</button>
                  </form>
               </c:otherwise>
            </c:choose>
         </div>
      </c:otherwise>
   </c:choose>
    <div class="navbar">
        <a href="#locate">도서관 위치</a>
        <a href="#schedule">도서관 일정</a>
        <a href="#notice">공지사항</a>
        <a href="#quantity">소장자료 현황</a>
    </div>
  
    <div>
        <h2 id = "locate">Soldesk 도서관</h2>
        <div id="map"></div>
        <p>서울특별시 종로구 종로 12길 15 코아빌딩</p>
        <p>0507-1430-7001</p>
     </div>
     <div>
        <h3 id="schedule">매주 월요일 및 법정 공휴일 휴관(일요일 제외)</h3>
	 </div>
	 <div>
        <h2 id="notice">공지사항</h2>
       <c:forEach var="notice" items="${notice}">
            <a href="/board/no/${notice.boardno}">${notice.title}</a><br>
        </c:forEach>
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
                    <td>${chongbook}</td>
                    <td>${chulbook}</td>
                    <td>${jongbook}</td>
                    <td>${sabook}</td>
                    <td>${zabook}</td>
                    <td>${gibook}</td>
                    <td>${yeabook}</td>
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
