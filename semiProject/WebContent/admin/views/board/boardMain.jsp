<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.Board, java.util.ArrayList, com.kh.common.model.vo.PageInfo"%>
<%
	ArrayList<Board> blist = (ArrayList<Board>)request.getAttribute("blist");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	int bType = Integer.parseInt(request.getParameter("bType"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<div>
		<div id="content">
			<div id="con1">
				<form action="<%=contextPath%>/main.bo?bType=<%=%>" method="get">
				<select name="board-category" id="board-category">
					<option name="b-category" value="">공지사항</option>
					<option name="b-category" value="">대나무숲</option>
				</select>
				<div><input type="search" name="search-content" id=""></div>
				<div><button type="submit">검색</button></div>
			</form>
			<button type="button">작성하기</button>	
			</div>
			<div id="con2">
				<!-- 게시물 조회해와서 버튼이랑 같이 반복문으로 출력하기 -->
				<table>
					<thead>
						<tr>
							<td>No</td>
							<%if(bType!=4) { %>
								<td>Board Type</td>
							<% } %>
							<td>Category</td>
							<td>Writer</td>
							<td>Title</td>
							<td>Count</td>
							<td colspan="2">Update / Delete</td>
							<td>Create Date</td>
						</tr>
					</thead>
					<tbody>
						<% if(blist.isEmpty()) {%>
							<tr>
								<td>작성된 공지사항이 없습니다.</td>
							</tr>
						<% } else {%>
							<% for(Board b : blist) {%>
								<tr>
									<td><%b.getBoardNo(); %></td>
									<%if(!(b.getBoardType().equals("공지사항"))) {  %>
										<td>게시판</td>
									<% } %>
									<td><%b.getBoardType(); %></td>
									<td><%b.getBoardWriter(); %></td>
									<td><%b.getBoardTitle(); %></td>
									<td><%b.getCount(); %></td>
									<td>
									<button id="b-update-btn" onclick="">수정</button>
									</td>
									<td>
									<button id="b-delete-btn" onclick="">삭제</button>
									<</td>
									<td><%b.getCreateDate(); %></td>
								</tr>
							<% } %>
						<% } %>
					</tbody>
					<!-- selectbox attr checked로 바뀌게해서 설정값이랑 맞추기  -->
				</table>
			</div>
		</div>
	</div>
</body>
</html>