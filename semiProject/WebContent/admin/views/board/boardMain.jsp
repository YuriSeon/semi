<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.Board, java.util.ArrayList, com.kh.common.model.vo.PageInfo"%>
<%
	ArrayList<Board> blist = (ArrayList<Board>)request.getAttribute("blist");	
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	int typeNo = Integer.parseInt(request.getParameter("typeNo"));
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
				<form action="<%=contextPath%>/main.bo" method="get">
				
				<select name="board-category" id="board-category">
					<option name="b-category" value="4">공지사항</option>
					<option name="b-category" value="1">영상</option>
					<option name="b-category" value="2">대나무숲</option>
					<option name="b-category" value="3">맛집</option>
				</select>
				<div><input type="search" name="search-content" placeholder="검색어를 입력하세요"></div>
				<div><button type="submit">검색</button></div>
			</form>
			<button type="button" onclick="location.href='<%=contextPath%>/insert.abo'">작성하기</button>	
			</div>
			<hr>
			<div id="con2">
				<!-- 게시물 조회해와서 버튼이랑 같이 반복문으로 출력하기 -->
				<table>
					<thead>
						<tr>
							<td>No</td>
							<%if(typeNo!=1) { %>
								<td>Board Type</td>
							<% } %>
							<td>Category</td>
							<td>Writer</td>
							<td>Title</td>
							<td>Count</td>
							<td>Create Date</td>
							<td>Modify Date</td>
							<td colspan="2">Update / Delete</td>
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
									<td><%=b.getBoardNo() %></td>
									<%if(!(b.getBoardType().equals("공지사항"))) {  %>
										<td>게시판</td>
									<% } %>
									<td><%=b.getBoardType() %></td>
									<td><%=b.getBoardWriter() %></td>
									<td><%=b.getBoardTitle() %></td>
									<td><%=b.getCount() %></td>
									<td><%=b.getCreateDate() %></td>
									<td><%=b.getModifyDate() %></td>
									<td>
									<form>
									<button id="b-update-btn" onclick="location.href='<%=contextPath %>/update.abo?bno=<%=b.getBoardNo()%>';">수정</button>
									</td>
									<td>
									<button id="b-delete-btn" onclick="deleteBoard();" name="bno" value="<%=b.getBoardNo()%>">삭제</button>
									<</td>
								</tr>
							<% } %>
						<% } %>
					</tbody>
					<script>
					function deleteBoard(){
						
						if(confirm("게시물을 삭제하시겠습니까?")){
							
							location.href='<%=contextPath %>/delete.abo';
						
						} else {
							
							alert("삭제를 취소하셨습니다.");
						}
					}
					</script>
					
					<!-- selectbox attr checked로 바뀌게해서 설정값이랑 맞추기  -->
				</table>
			</div>
		</div>
	</div>
</body>
</html>