<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.Board"%>
<% 
    Board b = (Board)request.getAttribute("b");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <%@ include file="../common/menubar.jsp" %>
    <form action="<%=contextPath %>/update.abo" method="post">
        <div>
        <input type="hidden" name="bno" value="<%=b.getBoardNo() %>">
			<div>
				<label for="updateTitle">제목 : </label><input type="text" name="updateTitle" id="updateTitle" value="<%=b.getBoardTitle()%>">
			</div>
			<div>
				<label for="content" style="vertical-align: top;">내용 : </label><textarea name="content" id="content" cols="30" rows="10" style="resize: none;"><%=b.getBoardContent() %></textarea>
			</div>
            <div>
                <button type="submit">수정</button>
                <button type="button" onclick="history.back();">취소</button>
            </div>    
        </div>
    </form>

</body>
</html>