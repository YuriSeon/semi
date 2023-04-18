<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"import="java.util.ArrayList,com.kh.board.model.vo.BamCategory"%>
<%
	ArrayList<BamCategory> list = (ArrayList<BamCategory>)request.getAttribute("clist");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대나무숲 게시글작성</title>
</head>
<body>
	<form action="<%=request.getContextPath() %>/baminsert.bo" method="post" enctype="multipart/form-data">
        <div style="width: 500px; background-color: gray; color: white;">
			<input type="hidden" name="userNo" value="<%=loginUser.getUserNo() %>">
            <select name="category">
				<%for(BamCategory c : list) {%>
					<option value="<%=c.getBamCategoryNo()%>"><%=c.getBamCategoryName() %></option>
				<%} %>
			</select>
            제목 : <input type="text" name="title" id="title">
        </div>
            <textarea name="content" id="content" cols="30" rows="10" style="resize:none; width: 450px; "></textarea>
            <br>
            
            <input type="file" id="upfile">
            <br>
            <input type="submit">
            
        </form>
    </body>
</body>
</html>