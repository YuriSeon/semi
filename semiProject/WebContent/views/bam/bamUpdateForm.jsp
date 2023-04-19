<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대나무숲 수정폼</title>
</head>
<body>
<body>
	<%@include file ="bamInsertView.jsp"%>
	<form action="<%=request.getContextPath() %>/bamupdate.bo" method="post" enctype="multipart/form-data">
        <div style="width: 500px; background-color: gray; color: white;">
			<!--  <input type="hidden" name="userNo" value="loginUser.getUserNo() ">-->
			<input type="hidden" name="userNo" value="2">
            <select name="category">
				<%for(BamCategory c : list) {%>
					<option value="<%=c.getBamCategoryNo()%>"><%=c.getBamCategoryName() %></option>
				<%} %>
			</select>
            제목 : <input type="text" name="title" id="title">
        </div>
            <textarea name="content" id="content" cols="30" rows="10" style="resize:none; width: 450px; "></textarea>
            <br>
            
            <input type="file" name="upfile">
            <br>
            <button type="submit">작성하기</button>
            <button type="reset">취소</button>
            
        </form>
</body>
</html>