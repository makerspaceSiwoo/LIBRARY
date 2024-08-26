<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>도서관 홈 페이지</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <link rel="stylesheet" type="text/css" href="/css/header.css">
    <link rel="stylesheet" type="text/css" href="/css/home2.css">

    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=75bada73f8c74910c3c69014a4957dd1"></script>
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
	<style>
    #map { /*지도*/
        width: 40vw;
        height: 30vw; /* 원하는 크기로 설정 */
        margin-left: 0vw;
        margin-bottom: 2vh; /* 지도 아래 여백 */
    	border: 0.2vw solid #BBB; /* 지도의 테두리 설정 */
    	border-radius: 1vw; /* 둥근 테두리 */
    	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
    }
	</style>
</head>
<body>
<nav>

   <c:choose>
      <c:when test="${user.admin == 1 }">
         <div id="adminmenu" class="menu">
            <a href="/home"><img src="/logo/logo.png"></a>
            <div class="menulist">
	            <a href="/home">도서관 홈</a>
	            <a href="/book/record">대출/반납</a>
	            <a href="/book/add">도서 추가</a>
	            <a href="/book/manage">도서 수정/삭제</a>
	            <a href="/board/search">게시판</a>
	            <a href="/mypage">마이 페이지</a>
	            <a href="/admin/blacklist">유저 관리</a>
            </div>
            <div class="button-container">
	            <c:choose>
	               <c:when test="${empty user or empty user.userID}">
	                  <button id="loginbutton" onclick="location.href='/login';">로그인</button>
	               </c:when>
	               <c:otherwise>
	                  <p>${user.userID }님</p>
	                  <form action="/logout" method="post">
	                     <button id="logoutbutton" >로그아웃</button>
	                  </form>
	               </c:otherwise>
	            </c:choose>
	        </div>
         </div>
      </c:when>
      <c:otherwise>
         <div id="usermenu" class="menu">
            <a href="/home"><img src="/logo/logo.png"></a>
            <div class="menulist">
	            <a href="/home">도서관 홈</a>
	            <a href="/search">도서 검색</a>
	            <a href="/recomm">추천 도서</a>
	            <a href="/board/search">게시판</a>
	            <a href="/mypage">마이 페이지</a>
            </div>
            <div class="button-container">
	            <c:choose>
	               <c:when test="${empty user or empty user.userID}">
	                  <button id="joinbutton" onclick="location.href='/join';">회원 가입</button>
	                  <button id="loginbutton" onclick="location.href='/login';">로그인</button>
	               </c:when>
	               <c:otherwise>
	                  <p>${user.userID }님</p>
	                  <form action="/logout" method="post">
	                     <button id="logoutbutton">로그아웃</button>
	                  </form>
	               </c:otherwise>
	            </c:choose>
	        </div>
         </div>
      </c:otherwise>
   </c:choose>
   <hr>
</nav>

<header>
    <div class="slider-container">
        <div class="under">
            <img src="/logo/headerImg1.jpg" alt="Image 1">
            <img src="/logo/headerImg2.jpg" alt="Image 2">
            <img src="/logo/headerImg3.jpg" alt="Image 3">
            <img src="/logo/headerImg4.jpg" alt="Image 4">
            <img src="/logo/headerImg1.jpg" alt="Image 1">
            <img src="/logo/headerImg2.jpg" alt="Image 2">
        </div>
    </div>
	<span class="upper">
		<img src="/logo/logo.png">
	</span>
	<span class="upper">
		<form action="/search">
			<input id="search" name="search" type="text" placeholder="도서 검색">
			<button type="submit">검색</button>
		</form>
	</span>
</header>
<hr>
<aside>
	<nav>
	    <div class="navbar">
	        <a href="#locate">도서관 위치</a>
	        <a href="#schedule">도서관 일정</a>
	        <a href="#notice">공지사항</a>
	        <a href="#quantity">소장자료 현황</a>
	    </div>
	</nav>
</aside>
<main>
	<section>
	    <div>
	        <h2 id ="locate">Soldesk 도서관</h2>
	        <div id="map"></div>
	        <p>주소: 서울특별시 종로구 종로 12길 15 코아빌딩</p><br>
	        <p>전화번호: 0507-1430-7001</p>
	     </div>
     </section>
     <section>
     <div>
        <h2 id="schedule">매주 월요일 및 법정 공휴일 휴관(일요일 제외)</h2>
	 </div>
	 </section>
	 <section>
	<div class="notice-box">
        <h2 id="notice">공지사항</h2> <c:if test="${user.admin == '1' }"><button id="noticebutton" onclick="location.href='/board/write'">+</button></c:if>
        <div>
       <c:forEach var="notice" items="${notice}">
            <a href="/board/no/${notice.boardno}">${notice.title}</a><br>
        </c:forEach>
        </div>
	</div>
	</section>
	<section>
	<div>
        <h2 id="quantity">소장 도서 수</h2>
        <table border="1">
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
    </section>
</main>
<footer>
<p>© 2024. Soldesk도서관. all rights reserved.</p>
</footer>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

$(document).ready(function() {
    console.log("Document is ready.");

    let currentIndex = 0;
    const totalSlides = $('.under img').length;  // 총 슬라이드 수

    console.log("Total slides:", totalSlides);

    function slideImages() {
        currentIndex++;
        $('.under').css('transform', `translateX(-\${currentIndex * 50}vw)`); // 슬라이드 이동을 vw 단위로 설정
        $('.under').css('transition', 'transform 0.5s ease-in-out');
        
        if (currentIndex >= totalSlides - 2 ) { // 마지막 이미지로 슬라이드 완료 후
            setTimeout(() => {
                $('.under').css('transform', `translateX(0)`); // 첫 번째 이미지로 리셋
                $('.under').css('transition', 'none'); // 애니메이션 없이 즉시 이동
                currentIndex = 0;
            }, 500); // 슬라이드가 완료된 후 실행
        }
    }

    setInterval(slideImages, 2000); // 3초마다 슬라이드
});


</script>



</body>
</html>