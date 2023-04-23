<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.Board, java.util.ArrayList, com.kh.common.model.vo.PageInfo"%>
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
    <div>
		<div id="content">
			<div id="con1">
				<form action="<%=contextPath%>/selectList.abo" method="post">
				<input type="hidden" name="currentPage" value="1">
				<select name="board-type">
					<option name="b-type" value="1">영상</option>
					<option name="b-type" value="2">대나무숲</option>
					<option name="b-type" value="3">맛집</option>
				</select>
				<div><input type="search" name="search-content" id=""></div>
				<div><button type="submit">검색</button></div>
			</form>
			<button type="button" onclick="location.href='<%=contextPath %>/delete.abo'">삭제하기</button>	
			</div>
			
            <div id="con2">
				<table border="1">
					<thead>
						<tr>
							<td>No</td>
							<td>Board Type</td>
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
						<% if(list.isEmpty()) {%>
							<tr>
								<td>작성된 공지사항이 없습니다.</td>
							</tr>
						<% } else {%>
							<% for(Board b : list) {%>
								<tr>
									<td><%=b.getBoardNo() %></td>
									<% if(b.getTypeNo()==1) {%>
										<td>공지사항</td>
									<% } else { %>
										<td>게시판</td>
									<% } %>
									<td><%=b.getBoardType() %></td>
									<td><%=b.getBoardWriter() %></td>
									<td><%=b.getBoardTitle() %></td>
									<td><%=b.getCount() %></td>
									<td><%=b.getCreateDate() %></td>
									<td><%=b.getModifyDate() %></td>
									<td>
									<button id="b-update-btn" onclick="location.href='<%=contextPath %>/update.abo?bno=<%=b.getBoardNo()%>';">수정</button>
									</td>
									<td>
									<button name="<%=b.getBoardNo() %>" class="btn" >삭제</button>
									</td>
								</tr>
							<% } %>
						<% } %>
					</tbody>
				</table>
				<script>
					$(".btn").click(function(){
						if(confirm("게시물을 삭제하시겠습니까?")){
							location.href='<%=contextPath %>/delete.abo?bno=' + $(this).attr("name") ;
						} else {
							alert("삭제를 취소하셨습니다.");
						}
					});
					
					// 상세페이지 detail view로 넘어가는 이벤트
					$("tbody>tr").click(function(){
						var bno = $(this).children().eq(0).text();
						location.href="<%=contextPath%>/detail.abo?bno="+bno;
					});
				</script>
			</div> 
		</div>
	</div>
</body>
</html>