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
<form method="post" id="writeform" action="/board/write">
	<table border="1">
		<tr>
			<td class="orange">제목</td>
			<td><input name="title"/></td>
		</tr>
		<tr>
			<td><input type="hidden" name="userno" value=${user.userno }></td>
		</tr>
		<tr>
		
			<td class="orange">type</td>
			<td><select name="type" id="type">
			<c:if test = "${ user.admin == 1  }">
			<option value="announcement">공지사항</option>
			</c:if>
        	<option value="free">자유</option>
        	<option value="recommend">추천</option>
        	<option value="review">리뷰</option>
    		</select></td>
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