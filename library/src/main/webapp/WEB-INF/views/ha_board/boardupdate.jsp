<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<title>글쓰기</title>
<style>
	.orange{background-color: orange; width: 50px;}
	table{border-collapse : collapse; width: 800px}
</style>
</head>
<body>
<form method="post" id="writeform" action="/home4/test">
	<table border="1">
			<tr>
			<td class="orange">글번호</td>
			<td><input name="boardno" value=${boardno}></td>
		</tr>
		<tr>
			<td class="orange">작성자</td>
			<td><input name="userno" value=${boardcontent.userno} > </td>
		</tr>
		
		<tr>
			<td class="orange">내용</td>
			<td><div id="smarteditor">
        	<textarea name="contents" id="editorTxt" 
                  rows="20" cols="10" 
                 
                  style="width: 745px">${boardcontent.contents}</textarea>
      </div></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" id="save" value="수정 하기"> 
			</td>
		</tr>
	</table>
</form>





</body>

</html>