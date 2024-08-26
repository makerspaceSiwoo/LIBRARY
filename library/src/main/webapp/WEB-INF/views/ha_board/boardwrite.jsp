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
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 700px;
            width: 100%;
            margin: 20px;
            box-sizing: border-box;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 10px;
            color: #555;
        }

        input[type="text"], select, textarea {
            width: 100%;
            padding: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            color: #333;
            background-color: #f9f9f9;
            box-sizing: border-box;
        }

        textarea {
            resize: none;
        }

        input[type="text"].title-input {
            height: 50px; /* 높이를 크게 설정 */
            resize: none; /* 크기 조정 불가능하게 설정 */
        }

        textarea {
            height: 200px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
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
    <form method="post" id="writeform" action="/board/write">
        <div class="form-group">
            <label for="title">제목을 입력해 주세요</label>
            <input type="text" name="title" id="title" placeholder="제목을 입력해 주세요" required class="title-input" value="${boardcontent.title}" /> 
        </div>
        <input type="hidden" name="userno" value="${user.userno}">
        <div class="form-group">
            <label for="type">게시판 선택</label>
            <select name="type" id="type" required>
                <c:if test="${user.admin == 1}">
                    <option value="announcement" <c:if test="${boardcontent.type == 'announcement'}">selected</c:if>>공지사항</option>
                </c:if>
                <option value="free" <c:if test="${boardcontent.type == 'free'}">selected</c:if>>자유</option>
                <option value="recommend" <c:if test="${boardcontent.type == 'recommend'}">selected</c:if>>추천</option>
                <option value="review" <c:if test="${boardcontent.type == 'review'}">selected</c:if>>리뷰</option>
            </select>
        </div>
        <div class="form-group">
            <label for="contents">내용을 입력해주세요</label>
            <textarea name="contents" id="editorTxt" placeholder="내용을 입력해주세요" required>${boardcontent.contents}</textarea>
        </div>
        <div class="form-group">
            <input type="submit" id="save" value="새글 등록"> 
        </div>
    </form>
</div>

</body>
</html>
