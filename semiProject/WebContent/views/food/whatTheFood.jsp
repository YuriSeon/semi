<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, com.kh.board.model.vo.Attachment"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		ArrayList<Attachment> list = (ArrayList<Attachment>)request.getAttribute("Imglist");
	%>
	
	
	<div>
	<%if(list.isEmpty()){ %>
		<h1>준비 된 사진이 없습니다.</h1>		
	<%} else {%>
		<%for(int i = 0; i < list.size(); i++){ %>
		 <img class="Img" src='<%=list.get(i).getFilePath()  + "/"+ list.get(i).getChangeName()%>' style="width:100%; height:100%">
		<%} %>
	<%} %>
	</div>
</body>
</html>