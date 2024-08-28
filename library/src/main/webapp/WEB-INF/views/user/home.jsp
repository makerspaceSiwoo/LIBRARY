<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>도서관 홈 페이지</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">  
    <link rel="stylesheet" type="text/css" href="/css/header.css">
    <link rel="stylesheet" type="text/css" href="/css/home2.css">

    <style>
    	.book-list {
		    display: grid;
		    grid-template-columns: repeat(3, 1fr);
		    gap: 2.4vw; /* 간격을 80%로 줄임 */
		    justify-items: center;
		    padding: 0 8vw; /* 좌우 공백을 80%로 줄임 */
		}
		
		.book-img {
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    width: 80%; /* 너비를 80%로 줄임 */
		    cursor: pointer;
		    padding: 0.24vw;
		    border-radius: 0.4vw;
		    box-shadow: 0px 0.8px 2.4px rgba(0, 0, 0, 0.1);
		    transition: transform 0.3s ease-in-out;
		}
		
		.book-img:hover {
		    transform: scale(1.05);
		}
		
		.book-img img {
		    width: 100%;
		    height: auto;
		    margin-bottom: 0.24vw;
		}
		.book-img .title,
		.book-img .author,
		.book-img .publisher {
		    font-size: 1vw; /* 텍스트 크기를 80%로 줄임 */
		    color: #333;
		    margin: 0.04vw 0;
		    text-align: center;
		    line-height: 1.1;
		}
		
		.book-img .title {
		    font-weight: bold;
		    font-size: 1.2vw; /* 제목 크기를 80%로 줄임 */
		}
    </style>
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
	<c:if test="${not empty message}">
    <script type="text/javascript">
        alert("${message}");
    </script>
</c:if>
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
	            <a href="/admin/mypage">사서 페이지</a>
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
	        <a href="#schedule">이용시간</a>
	        <a href="#notice">공지사항</a>
	        <a href="#quantity">소장자료 현황</a>
	    </div>
	</nav>
</aside>
<main>
<div style="white-space: nowrap; width:100%;">
	<section style="display: inline-block; vertical-align: top; width:50%; margin-bottom: 0;">
	    <div>
	        <h2 id ="locate" style="scroll-margin-top: 20vh;">Soldesk 도서관</h2>
	        <div id="map"></div>
	        <ul>
	        	<li>주소: 서울특별시 종로구 종로 12길 15 코아빌딩</li>
	        	<li>전화번호: 0507-1430-7001</li>
	        </ul>
	        
	        
	     </div>
     </section>
     <section id="newbook" style="display: inline-block;vertical-align: top; width:50%;">
     	<div style="padding:0;">
		<h2>신간 도서</h2>
     	<div class="book-list" style="padding:0; white-space:nowrap; width:100%;">
	        <c:forEach var="gen" items="${newbook}">
	            <div class="book-img" onclick="location.href='/search/no=${gen.callno}'" 
	            style="width:100%; padding:0; white-space:wrap; overflow: hidden; justify-content: space-between; ">
	                <img alt="표지사진" src="${gen.img}" style="border-radius: 0.3vw;">
	                <div style="padding-bottom: 1vw">
		                <div class="title">${gen.booktitle}</div><br>
		                <div class="author">${gen.author}</div><br>
		                <div class="publisher">${gen.publisher}</div>
	                </div>
	            </div>
	        </c:forEach>
	    </div>
	    </div>

     </section>
</div>
	
     <section>
     <div>
        <h2 id="schedule" style="scroll-margin-top: 20vh;">휴관일</h2>
        <ul>
        	<li>정기휴관일: 매주 월요일 및 법정 공휴일 휴관(일요일 제외)</li>
        	<li>공사일정 : 2024/08/20 ~ 2024/08/25</li>
        </ul>
	 </div>
	 </section>
	 
	 <section>
		<div>
			<table border="1">
            <thead>
                <tr>
                  <th>층별</th>
                  <th>구분</th>
                  <th>이용시간</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1층</td>
                    <td>아동/청소년 자료실</td>
                    <td>09:00~18:00</td>      
              
                </tr>
                <tr>
                	<td rowspan="2">2층</td>
                	<td>휴게실</td>
                	<td>09:00~18:00</td>
                	
   
                </tr>
                <tr>
                	<td>종합 자료실</td>
                	<td>09:00~20:00</td>
                	
       
                </tr>
                <tr>
                	<td>3층</td>
                	<td>외국어 자료실</td>
                	<td>09:00~20:00</td>
   
                </tr>
            </tbody>
        </table>
		</div>
	</section>
	
	 <section>
	<div class="notice-box" >
        <h2 id="notice" style="scroll-margin-top: 20vh;">공지사항</h2> <c:if test="${user.admin == '1' }"><button id="noticebutton" onclick="location.href='/board/write'">+</button></c:if>
        <div>
        <ul>
	       <c:forEach var="notice" items="${notice}">
	           <li style="; list-style: inside;">
	           	<div style="display: inline-flex;">
				    <a href="/board/no/${notice.boardno}" style=" flex-shrink: 0; margin-right: 10px;">${notice.title}</a>
				
				    <p style=" color: gray; font-size: 14px">
				        (<fmt:formatDate value="${notice.write_date}" pattern="yyyy-MM-dd" />)
				    </p>
				 </div>
				</li>
	        </c:forEach>
        </ul>
        </div>
	</div>
	</section>
	<section>
	<div>
        <h2 id="quantity" style="scroll-margin-top: 20vh;" >소장 도서 수</h2>
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
        <table border="1">
            <thead>
                <tr>
                    <th>아동/청소년 자료실</th>
                    <th>종합 자료실</th>
                    <th>외국어 자료실</th>
                    <th>전체</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>${childbook}</td>
                    <td>${commonbook}</td>
                    <td>${foreignbook}</td>
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