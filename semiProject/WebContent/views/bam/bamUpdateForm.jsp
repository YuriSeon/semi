<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.*"%>
<%
	Board b = (Board)request.getAttribute("b");
	Attachment at = (Attachment)request.getAttribute("at");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대나무숲 수정폼</title>
</head>
<body>
<body>
	<%@ include file ="../common/menubar.jsp"%> 
	
	<form action="<%=contextPath%>/bamupdate.bo" id="bamup" method="post" enctype="multipart/form-data">
        <div style="width: 500px; background-color: gray; color: white;">
			<input type="hidden" name="boardNo" value="<%=b.getBoardNo()%>">
            <script>
				$(function(){
					$("#bamup option").each(function(){
						if($(this).text()=="<%=b.getBoardType()%>"){
							$(this).attr("selected",true);
						}
					});
				});
			</script>
            <select name="category" id="category">
				<option value="1">일반</option>
				<option value="2">질문</option>
				<option value="3">연애</option>
			</select>
            제목 : <input type="text" name="title" id="title" value="<%=b.getBoardTitle()%>">
        </div>
            <textarea name="content" id="content" cols="30" rows="10" style="resize:none; width: 450px; "><%=b.getBoardContent() %></textarea>
            <br>
            
      		<%if(at!=null) {%>
							
				<%=at.getOriginName()%>
				<input type="hidden" name="fileNo" value="<%=at.getFileNo() %>">
				<input type="hidden" name="originFileName" value="<%=at.getChangeName() %>">
			<%} %>	
			<input type="file" name="reUpfile">
            <br>
            <button type="submit">작성하기</button>
            <button type="reset">취소</button>
            
        </form>
	
</body>
</html>