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
	<div>
		<div id="cont">
		<select name="boardtype" id="boardtype">
			<option value=""></option>
			<input type="text" name="insertTitle" id="insertTitle">
			<textarea name="content" id="content" cols="30" rows="10" style="resize: none;"></textarea>
		</select>
		
		</div>
	</div>
</body>
</html>