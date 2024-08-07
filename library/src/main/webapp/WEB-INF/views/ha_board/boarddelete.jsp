<%@ page contentType="text/html; charset=UTF-8" %>
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
<form method="post" id="writeform" action="/home5/test">
	<table border="1">
			<tr>
			<td class="orange">글번호</td>
			<td><input name="boardno"></td>
		</tr>
		<tr>
			<td class="orange">작성자</td>
			<td><input name="userno"></td>
		</tr>
		
		<tr>
			<td class="orange">내용</td>
			<td><div id="smarteditor">
        	<textarea name="contents" id="editorTxt" 
                  rows="20" cols="10" 
                  placeholder="내용을 입력해주세요"
                  style="width: 745px"></textarea>
      </div></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" id="save" value="새글 등록"> 
			</td>
		</tr>
	</table>
</form>





</body>

</html>