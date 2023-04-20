<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<form action="<%=contextPath %>/insert.abo " method="post">
		<div>
			<div id="cont">
				<input type="hidden" name=typeno value="1"> 
				<select name="boardtype" id="boardtype">
					<option value="video">영상</option>
					<option value="bam">대나무숲</option>
					<option value="food">맛집</option>
				</select>
			</div>
			<div>
				<label for="insertTitle">제목 : </label><input type="text" name="insertTitle" id="insertTitle">
			</div>
			<div>
				<label for="content" style="vertical-align: top;">내용 : </label><textarea name="content" id="content" cols="30" rows="10" style="resize: none;"></textarea>
			</div>
			<button type="submit">등록</button>
			<button type="button" onclick="history.back();">취소</button>
		</div>
	</form>
</body>
</html>