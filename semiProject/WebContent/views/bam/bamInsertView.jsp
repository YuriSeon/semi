<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.kh.board.model.vo.BamCategory,com.kh.bMember.model.vo.BMember"%>
<%
	ArrayList<BamCategory> clist = (ArrayList<BamCategory>)request.getAttribute("clist");
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대나무숲 게시글작성</title>
</head>
<body>
	<%@ include file ="../common/menubar.jsp"%> 
	<form action="<%=contextPath%>/baminsert.bo" method="post" enctype="multipart/form-data">
        <div style="width: 500px; background-color: gray; color: white;">
			<input type="hidden" name="userNo" value="<%=loginUser.getUserNo()%>">
			
            <select name="category">
					<option value="1">일반</option>
					<option value="2">질문</option>
            		<option value="3">연애</option>
            <%if(loginUser !=null&& loginUser.getUserNo()==1){ %>
					<option value="4">공지</option>            		
            <%} %>
			</select>
            제목 : <input type="text" name="title" id="title" maxlength="20">
        </div>
            <textarea name="content" id="content" cols="30" rows="10" style="resize:none; width: 450px; "></textarea>
            <br>
            
            <input type="file" name="upfile">
            <br>
            <button type="submit" onclick="badCheck();">작성하기</button>
            <button type="reset">취소</button>
            
      </form>
</body>
</html>