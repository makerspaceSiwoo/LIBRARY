<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/admin/book/add.css">
</head>
<body>
	<div id="header">
		<img src="/logo/logo.png">
		<a href="/admin/home">도서관 Home</a>
		<a href="/book/borrow">대출관리</a>
		<a href="/book/add">도서추가</a>
		<a href="/book/manage">도서정보 수정</a>
		<a href="/admin/recomm">인기도서</a>
		<a href="">회원관리</a>
		<a href="board/list">나눔마당</a>
		<!--<c:if test="${user }"></c:if>-->
	</div>

	<div>
		<h1>도서 추가</h1>
	</div>
	<div>
		<h3>직접 입력</h3>
	</div>
	<form action="#" method="post" id="bookform">
		<div>
			<input id="booktitle" name="booktitle" placeholder="책 이름을 입력하세요">
			<input id="author" name="author" placeholder="저자">
			<input id="callno" name="callno" placeholder="청구기호">
			<input id="publisher" name="publisher" placeholder="출판사">
			<input id="pubyear" type="number" name="pubyear" placeholder="출판연도">
			<button type="button" onclick="return addToList();">추가</button>
			<input type="reset" value="초기화">
		</div>

		<div>
			<table id="booklist" border="1">
				<tr>
					<td colspan="7" align="center">새로 추가할 도서 목록</td>
				</tr>
				<tr>
					<td>책 이름</td>
					<td>저자</td>
					<td>청구기호</td>
					<td>출판사</td>
					<td>출판연도</td>
					<td colspan="2"></td>
				</tr>
			</table>
		</div>
		<div>
			<button type="button" onclick="return listSubmit();">등록</button>
		</div>
	</form>
	
    <div id="failedbox">
		<table id="failedlist" border="1" >
			<tr>
				<td colspan="7" align="center">전송 실패한 도서 목록</td>
			</tr>
			<tr>
				<td>책 이름</td>
				<td>저자</td>
				<td>청구기호</td>
				<td>출판사</td>
				<td>출판연도</td>
				<td colspan="2"></td>
			</tr>
		</table>
		<button type="button" onclick="return cancel();">전송 취소</button>
	</div>

	
	<div>
		<h3>엑셀 업로드 (.xlsx)</h3>
	</div>
	<div id="excel">
	<p>엑셀 업로드는 한 번에 1000권까지 가능합니다.</p>
	<p>엑셀 업로드 중 창을 닫을 경우, 작업이 중단 될 수 있습니다. 전송 후, 결과 파일 다운로드까지 기다리십시오.</p>
    	<button type="button" onclick="return location.href='/book/add/downform';" >엑셀 양식 다운로드</button>
    	<br>
		<form id="excelupload" action="/book/add/excel" method="post" enctype="multipart/form-data" onsubmit="return validateAndSubmit();">
			<label for="file-upload" class="custom-file-upload">
	    		업로드 버튼
			</label>
			<input id="file-upload" type="file" name="booklistexcel" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
			<button type="submit">도서목록 업로드</button>
		</form>
	</div>


<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
let datalist = []; // 입력한 데이터를 저장할 리스트
let failedlist = []; // 전송 실패한 데이터를 저장할 리스트
let currentIndex = 0; // 현재 인덱스를 추적

/* 파일용량 제한*/
$("input[name=booklistexcel").on("change", function(){
  let maxSize = 5 * 1024 * 1024; //* 5MB 사이즈 제한
	let fileSize = this.files[0].size; //업로드한 파일용량

  if(fileSize > maxSize){
		alert("파일첨부 사이즈는 5MB 이내로 가능합니다.");
		$(this).val(''); //업로드한 파일 제거
		return; 
	}
});

function validateAndSubmit() {
    var fileInput = document.getElementById('file-upload');
    
    if (!fileInput.value) {
        alert('파일을 선택해야 합니다.'); // 파일이 없으면 경고 메시지 출력
        return false; // 폼 제출 중단
    }
    
    return true; // 파일이 선택되었으면 폼 제출 진행
}s

function exceldownload(){ // 양식 다운로드
    $.ajax({
        url: "/book/add/downform",
        method: "get",
    }).done(function () {
		alert("다운로드 완료");
    });
}



function cancel() { // 전송 취소
    location.href = "/book/add";
}

function del(obj, listType) {
    // 현재 클릭된 버튼의 부모 행을 찾습니다
    const row = $(obj).closest('tr');

    // 행의 인덱스를 가져옵니다
    const index = row.data('index');

    // 배열인지 확인하고, 데이터 삭제
    if (listType === 'datalist') {
        if (Array.isArray(datalist)) {
            datalist = datalist.filter(book => book.index !== index);
        } else {
            console.error("datalist is not an array.");
        }
    } else {
        if (Array.isArray(failedlist)) {
            failedlist = failedlist.filter(book => book.index !== index);
        } else {
            console.error("failedlist is not an array.");
        }
    }
    // 삭제 후 행을 제거
    row.remove();
}

function modify(obj, index, listType) { // 수정
    // 적절한 배열을 선택합니다
    const list = (listType === 'failedlist' ? failedlist : datalist);

    // 배열인지 확인
    if (!Array.isArray(list)) {
        console.error(`\${listType} is not an array.`);
        return;
    }

    // 인덱스를 통해 배열에서 항목을 찾습니다
    const book = list.find(book => book.index === index);

    // book이 undefined일 경우 에러 로그 추가
    if (!book) {
        console.error(`Book with index \${index} not found in \${listType}`);
        return;
    }

    // 입력 폼을 수정된 항목으로 채웁니다
    $("#booktitle").val(book.booktitle);
    $("#author").val(book.author);
    $("#callno").val(book.callno);
    $("#publisher").val(book.publisher);
    $("#pubyear").val(book.pubyear);

    // 행을 삭제합니다
    del(obj, listType);
}

function addToList() {
    // 입력 데이터 가져오기
    const title = $("#booktitle").val();
    const author = $("#author").val();
    const callno = $("#callno").val();
    const publisher = $("#publisher").val();
    const pubyear = $("#pubyear").val();

    if (!title || !author || !callno || !publisher || !pubyear) {
        alert("책 정보를 빠짐없이 입력해주세요.");
        return false;
    }

    // 데이터 항목 생성
    let book = {
        'index': currentIndex++, // 인덱스를 고유 식별자로 사용
        'booktitle': title,
        'author': author,
        'callno': callno,
        'publisher': publisher,
        'pubyear': pubyear,
    };

    // 데이터 리스트에 추가
    datalist.push(book);

    // 입력란 초기화
    $("#bookform")[0].reset();

    // 테이블에 행 추가
    let tag = `<tr data-index="\${book.index}">
        <td data-tooltip='\${title}'>\${title}</td>
        <td data-tooltip='\${author}'>\${author}</td>
        <td data-tooltip='\${callno}'>\${callno}</td>
        <td data-tooltip='\${publisher}'>\${publisher}</td>
        <td data-tooltip='\${pubyear}'>\${pubyear}</td>
        <td><button type="button" class="modify-button" onclick="return modify(this, \${book.index}, 'datalist');">수정</button></td>
        <td><button type="button" class="delete-button" onclick="del(this, 'datalist');">삭제</button></td>
        </tr>`;

    $("#booklist").append(tag);
}

function listSubmit() { // 전송
    if (datalist.length === 0) {
        alert("전송할 책 정보가 없습니다.");
        return false;
    }

    $.ajax({
        url: "/book/add",
        method: "post",
        data: JSON.stringify(datalist),
        contentType: 'application/json; charset=utf-8'
    }).done(function (data) {
        // datalist 초기화
        datalist = [];

        // 실패한 목록을 인덱스와 함께 저장
        failedlist = data.map((item, index) => {
            return {
                ...item,
                index: index
            };
        });

        if (failedlist.length === 0) {
            alert("도서 리스트 전송 완료");
            location.href = "/book/add";
        } else {
            alert("도서 리스트 중 전송 실패한 도서가 있습니다.\n전송 실패한 도서 수 : " + failedlist.length);
            console.log(failedlist);
            // 0,1 번은 테이블 헤더
            // 전송 목록 테이블 초기화
            const table = document.getElementById("booklist");
            let r = table.rows.length;
            for (let i = r - 1; i > 1; i--) {
                table.deleteRow(i);
            }
            // 실패 목록을 테이블에 추가
            failedlist.forEach((element) => {
                const title = element.booktitle;
                const author = element.author;
                const callno = element.callno;
                const publisher = element.publisher;
                const pubyear = element.pubyear;
                const index = element.index;

                let tag = `<tr data-index="\${index}">
                	<td data-tooltip='\${title}'>\${title}</td>
                    <td data-tooltip='\${author}'>\${author}</td>
                    <td data-tooltip='\${callno}'>\${callno}</td>
                    <td data-tooltip='\${publisher}'>\${publisher}</td>
                    <td data-tooltip='\${pubyear}'>\${pubyear}</td>
                    <td><button type="button" class="modify-button" onclick="return modify(this, \${index}, 'failedlist');">수정</button></td>
                    <td><button type="button" class="delete-button" onclick="del(this, 'failedlist');">삭제</button></td>
                    </tr>`;
                $("#failedlist").append(tag);
            });

        }
    })
}

</script>
</body>
</html>

</script>
</body>
</html>