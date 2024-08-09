<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>이달의 도서 추천</title>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
    }
    th {
        background-color: #f2f2f2;
    }
    .button {
        padding: 5px 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
        float: right;
    }
    .button.cancel {
        background-color: #f44336;
    }
    .box {
        display: flex; /* Flexbox를 사용하여 자식 요소들을 가로로 정렬 */
        align-items: center; /* 수직 가운데 정렬 */
        border: 1px solid #ccc; /* 박스 테두리 */
        padding: 10px; /* 박스 안의 여백 */
        border-radius: 5px; /* 모서리 둥글게 */
        background-color: #f9f9f9; /* 배경 색상 */
        justify-content: space-between; /* 요소들을 양쪽 끝에 배치 */
    }
    .box p {
        margin: 0; /* 문단 사이의 기본 여백 제거 */
        padding: 0 10px; /* 각 문단의 좌우 여백 추가 */
        white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 설정 */
    }
    .p-box {
        display: inline-block; /* 각 문단 박스를 인라인 블록으로 설정 */
        border: 1px solid #ddd; /* 박스 테두리 */
        padding: 10px; /* 박스 안의 여백 */
        border-radius: 5px; /* 모서리 둥글게 */
        background-color: #f9f9f9; /* 배경 색상 */
        margin-right: 10px; /* 문단 박스 사이의 간격 */
    }
</style>
</head>
<body>
<h1>이달의 도서 추천</h1>

<input type="text" id="search" placeholder="바다">
<button onclick="searchBooks()">검색</button>

<table>
    <thead>
        <tr>
            <th>제목 검색결과</th>
        </tr>
    </thead>
    <tbody id="book-list">
        <tr>
            <td class="book-info">
                <div class="box">
                    <div class="p-box">바다</div>
                    <div class="p-box">존 밴빌</div>
                    <div class="p-box">712ㅂ87ㅂ</div>
                    <div class="p-box">2005</div>
                    <button class="button" onclick="addBook(this)">선택</button>
                </div>
            </td>
        </tr>
        <tr>
            <td>먼바다</td>
            <td>공지영</td>
            <td>754ㄱ64ㅅ</td>
            <td>2010</td>
            <td><button class="button" onclick="addBook(this)">선택</button></td>
        </tr>
        <tr>
            <td>바다의 탐험자 플로츠</td>
            <td>김용서</td>
            <td>804ㅅ13ㄴ</td>
            <td>2007</td>
            <td><button class="button" onclick="addBook(this)">선택</button></td>
        </tr>
        <tr>
            <td>노인과 바다</td>
            <td>어니스트 헤밍웨이</td>
            <td>755ㅎ10ㄴ</td>
            <td>1952</td>
            <td><button class="button" onclick="addBook(this)">선택</button></td>
        </tr>
    </tbody>
</table>

<h2>추가할 도서 목록</h2>
<table>
    <thead>
        <tr>
            <th>추가할 도서 목록</th>
        </tr>
    </thead>
    <tbody id="selected-books">
        <tr>
            <td>바다가 들리는 편의점</td>
            <td>마치다 쇼노코</td>
            <td>743ㄹ46ㄷ</td>
            <td>2023</td>
            <td><button class="button cancel" onclick="removeBook(this)">선택 취소</button></td>
        </tr>
    </tbody>
</table>

<button onclick="registerBooks()">등록</button>

<script>
    function addBook(button) {
        const row = button.closest('tr');
        const clone = row.cloneNode(true);
        clone.querySelector('button').textContent = '선택 취소';
        clone.querySelector('button').classList.add('cancel');
        clone.querySelector('button').setAttribute('onclick', 'removeBook(this)');
        document.getElementById('selected-books').appendChild(clone);
        row.remove();
    }

    function removeBook(button) {
        const row = button.closest('tr');
        const clone = row.cloneNode(true);
        clone.querySelector('button').textContent = '선택';
        clone.querySelector('button').classList.remove('cancel');
        clone.querySelector('button').setAttribute('onclick', 'addBook(this)');
        document.getElementById('book-list').appendChild(clone);
        row.remove();
    }

    function registerBooks() {
        const selectedBooks = document.getElementById('selected-books').children;
        const books = [];
        for (let i = 0; i < selectedBooks.length; i++) {
            const cells = selectedBooks[i].cells;
            const book = {
                title: cells[0].textContent,
                author: cells[1].textContent,
                callNumber: cells[2].textContent,
                year: cells[3].textContent
            };
            books.push(book);
        }
        console.log('등록된 도서:', books);
        alert('도서가 등록되었습니다.');
    }

    function searchBooks() {
        const query = document.getElementById('search').value;
        console.log('검색어:', query);
        // 검색 기능 구현 필요
    }
</script>
</body>
</html>