<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    table {
        border-collapse: collapse;
        width: 50%;
        text-align: center;
        height: 500px; /* 테이블 전체 높이 설정 */
    }
    td {
        padding: 10px;
        vertical-align: middle; /* 테이블 셀 내부에서의 상하 정렬 */
        border: 1px solid black; /* 테이블 셀 구분선 추가 */
        font-size: 26px; /* 텍스트 크기 설정 */
        font-weight: bold; /* 글씨 굵게 설정 */
    }
    #lentform {
        display: flex;
        flex-direction: column;
        align-items: center; /* 폼 전체를 중앙 정렬 */
        justify-content: center; /* 수직 중앙 정렬 */
        width: 100%; /* 폼의 너비를 테이블 셀에 맞춤 */
    }
    .input-container {
        display: flex;
        width: 100%; /* 컨테이너의 전체 너비 */
        justify-content: center; /* 입력 필드를 중앙에 정렬 */
        align-items: center;
        position: relative; /* 버튼을 절대 위치로 조정하기 위해 사용 */
    }
    #userno {
        width: 50%; /* 입력 필드의 너비를 50%로 설정 */
        text-align: center; /* 입력 텍스트도 가운데 정렬 */
        font-size: 24px; /* 입력 필드 텍스트 크기 설정 */
        height: 50px; /* 입력 필드 높이 설정 */
    }
    #button-container {
        position: absolute; /* 버튼을 입력 필드의 오른쪽에 배치 */
        right: 0; /* 오른쪽 끝에 정렬 */
        height: 50px; /* 버튼 높이 설정 */
        display: flex;
        align-items: center;
    }
    #returnbutton {
        height: 100%; /* 버튼 높이를 컨테이너에 맞춤 */
        width: 100px; /* 버튼의 너비 설정 */
        font-size: 24px; /* 버튼 텍스트 크기 설정 */
        background-color: #5E5DF0;
        color: white;
        border: none;
        padding: 0.5vw 1vw;
        border-radius: 0.5vw;
        cursor: pointer;
        box-sizing: border-box; /* 패딩과 테두리를 포함한 전체 너비 계산 */
        overflow: hidden; /* 버튼 내부 텍스트가 넘칠 경우 숨김 */
        text-overflow: ellipsis; /* 버튼 텍스트 넘침 시 말줄임 표시 (...) */
        white-space: nowrap; /* 버튼 텍스트 줄바꿈 방지 */
    }
    #returnbutton:hover {
        background-color: #3B3B98;
    }
</style>
</head>
<body>
    <!-- 하나의 테이블로 bookno와 유저번호 구분 -->
    <table>
        <tr>
            <td>도서 정보</td>
            <td>${bookno} : ${booktitle }</td>
        </tr>
        <tr>
            <td>유저ID</td>
            <td>
                <form id="lentform" action="" method="POST">
                    <input type="hidden" name="bookno" value=${bookno}>
                     
                    <!-- 에러 메시지 표시 -->
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">${errorMessage}</div>
                    </c:if>
                    
                    <!-- 대출 버튼 -->
                    <div class="input-container">
                        <input id="userID" type="text" name="userID">
                        <div id="button-container">
                            <button id="returnbutton" type="submit">대출</button>
                        </div>
                    </div>
                </form>    
            </td>
        </tr>
    </table>
<script></script>
</body>

</html>
