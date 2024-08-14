<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<div>
	<h1>도서 정보 수정/삭제</h1>
	<p>현재 DB에 저장된 책 정보</p>
	<table border="1">
		<tr>
			<td>관리 번호</td>
			<td>책 이름</td>
			<td>저자</td>
			<td>청구기호</td>
			<td>출판사</td>
			<td>출판연도</td>
		</tr>
		<tr>
			<td>${book.bookno }</td>
			<td>${book.booktitle }</td>
			<td>${book.author }</td>
			<td>${book.callno }</td>
			<td>${book.publisher }</td>
			<td>${book.pubyear }</td>
		</tr>
	</table>
</div>
<hr>
<div>
	<form id="modifyForm" method="post">
	<table border="1">
		<tr>
			<td>관리 번호</td>
			<td>책 이름</td>
			<td>저자</td>
			<td>청구기호</td>
			<td>출판사</td>
			<td>출판연도</td>
		</tr>
		<tr>
			<td>
				<input id="bookno" name="bookno" value=${book.bookno } readonly>
			</td>
			<td>
				<input id="booktitle" name="booktitle" value=${book.booktitle }>
			</td>
			<td>
				<input id="author" name="author" value=${book.author }>
			</td>
			<td>
				<input id="callno" name="callno" value=${book.callno }>
			</td>
			<td>
				<input id="publisher" name="publisher" value=${book.publisher }>
			</td>
			<td>
				<input id="pubyear" type="number" name="pubyear" value=${book.pubyear }>
			</td>
		</tr>
	</table>
		<button type="submit" onclick="return mod();">수정</button>
		<button type="button" onclick="return del();">삭제</button>
		<button type="button" onclick="return history.back();">목록으로 돌아가기</button>
	</form>
</div>


</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

function del() {
	let result = confirm("DB에서 삭제하시겠습니까?");
	if(result){
		 $.ajax({
		        url: "/book/del",
		        method: "delete",
		        data : {bookno : ${book.bookno}}
		    }).done(function (data) {
					alert("삭제되었습니다.");
			    	location.href="/book/manage";
		    });
	}else{
	    alert("취소되었습니다.");
	}
};

function mod(){
	let book = "${book}";
	$.ajax({
        url: "/book/mod",
        method: "post",
        data: JSON.stringify(book),
        contentType: 'application/json; charset=utf-8'
    }).done(function (data) {
	    	alert("수정되었습니다.");
	    	location.replace("/book/mod?bookno="+${book.bookno});
    	
    });
}


</script>
</html>