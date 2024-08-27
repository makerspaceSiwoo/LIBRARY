<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #ececec;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: white;
            border: 1px solid #bbb; /* 더 진한 회색 테두리 */
            border-radius: 12px; /* 더 둥근 모서리 */
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 700px; /* 컨테이너 너비를 조금 더 키움 */
            width: 100%;
        }
        .form-group {
            margin-bottom: 25px;
        }
        label {
            display: block;
            font-weight: 600; /* 더 두껍게 */
            margin-bottom: 10px;
            color: #555; /* 진한 회색 텍스트 */
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 14px; /* 패딩 증가 */
            border: 1px solid #bbb; /* 더 진한 회색 테두리 */
            border-radius: 8px; /* 더 둥근 모서리 */
            font-size: 16px;
            color: #333;
            background-color: #f9f9f9; /* 약간의 배경색 추가 */
        }
        textarea {
            resize: none;
            height: 200px; /* 텍스트 영역 크기 증가 */
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 14px 20px;
            border-radius: 8px; /* 버튼 모서리도 둥글게 */
            cursor: pointer;
            font-size: 18px; /* 더 큰 글꼴 크기 */
            width: 100%;
            margin-top: 15px;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <form method="post" id="writeform" action="/board/mod/complete">
        <input type="hidden" name="boardno" value="${boardcontent.boardno}">
        <input type="hidden" name="userno" value="${boardcontent.userno}">
        
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" name="title" id="title" placeholder="제목을 입력해 주세요" value="${boardcontent.title}" required>
        </div>

        <div class="form-group">
            <label for="contents">내용</label>
            <textarea name="contents" id="contents" placeholder="내용을 입력해 주세요" required>${boardcontent.contents}</textarea>
        </div>
        
        <div class="form-group">
            <input type="submit" id="save" value="수정 하기">
        </div>
    </form>
</div>

</body>
</html>
