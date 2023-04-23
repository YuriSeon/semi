<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="com.kh.board.model.vo.Board, java.util.ArrayList, com.kh.common.model.vo.PageInfo"%>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	int currentPage = (int)request.getAttribute("currentPage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<button type="button" onclick="selectList();">선택삭제</button>
    <hr>
    <table id="t">
        <thead>
            <tr>
                <th>게시판번호</th>
                <th>게시판 종류</th>
                <th>작성자ID</th>
                <th>제목</th>
                <th>싫어요</th>
                <th>신고</th>
                <th>조회수</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody>
            <% for(Board b : list) { %>
	            <tr>
	                <td><%= b.getBoardNo() %></td>
	                <td><%= b.getBoardType()%></td>
	                <td><%= b.getBoardWriter()%></td>
	                <td><%= b.getBoardTitle()%></td>
	                <td><%= b.getBad()%></td>
	                <td><%= b.getReport()%></td>
	                <td><%= b.getCount()%></td>
	                <td><%= b.getCreateDate()%></td>
	            </tr>
            <% } %>
        </tbody>
    </table>
</body>
<script>
	$("#t tbody>tr").click(function(){
		var bno = $(this).children.eq(0).text();
		location.href="<%=contextPath %>/blurDetail.abo?status=C&bno="+bno;
	});

</script>
</html>