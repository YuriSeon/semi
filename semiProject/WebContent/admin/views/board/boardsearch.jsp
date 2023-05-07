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
<style>
	p{
		font-size : 27px;
		font-weight: bold;
		margin-top: 200px;
	}
	
	select, input{
		height: 30px;
		margin: 0;
		padding: 0;
	}
	#con2{
		text-align : center;
	}
	.btn-8{
		margin-top: 15%;
	}
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp"%>
	<div id="wrapper">
		<div id="bb">
			<div>
				<form action="<%=contextPath%>/selectList.abo" method="post">
					<input type="hidden" name="currentPage" value="1"> 
					<br>
					<select name="board-type">
						<option name="b-type" value="2">대나무숲</option>
						<option name="b-type" value="3">맛집</option>
					</select>
					<div>
						<input type="search" name="search-content" id="input">
					</div>
					<div>
						<button type="submit" class="custom-btn btn-10">검색</button>
					</div>
				</form>
				
				<%-- <button type="button" id="deleteL" class="custom-btn btn-5" onclick="location.href='<%=contextPath%>/delete.abo'">선택삭제</button> --%>
			</div>
			<br>
			<div id="con2">
				<% if(list!=null && list.isEmpty()) {%>
					<p>검색어와 일치하는 게시물이 없습니다.</p>
					<button class='custom-btn btn-8' onclick="location.href='<%=contextPath%>/main.abo?currentPage=1';">이전으로</button>
				<% } else {%>
					<table id="tab">
						<thead>
							<tr>
								<th>No</th>
								<th>Board Type</th>
								<th>Category</th>
								<th>Writer</th>
								<th>Title</th>
								<th>Count</th>
								<th>Create Date</th>
								<th>Modify Date</th>
								<th>Delete</th>
							</tr>
						</thead>
						<tbody>
						<% for(Board b : list) {%>
							<tr>
								<td><%=b.getBoardNo() %></td>
								<% if(b.getTypeNo()==1) {%>
									<td>공지사항</td>
								<% } else { %>
									<td>게시판</td>
								<% } %>
								<td><%=b.getBoardType()%></td>
								<td><%=b.getBoardWriter()%></td>
								<td><%=b.getBoardTitle()%></td>
								<td><%=b.getCount()%></td>
								<td><%=b.getCreateDate()%></td>
								<td><%=b.getModifyDate()%></td>
								<td>
									<button name="<%=b.getBoardNo() %>" class="custom-btn btn-5">삭제</button>
								</td>
							</tr>
						<% } %>
					<% } %>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div>
	<% if(pi.getMaxPage() > 1) { %>
		<!-- 페이징처리 -->
		<% if(pi.getCurrentPage()==1) {%>
			<button type="button" disabled>&lt;</button>
		<% } else { %>
			<button type="button"onclick="location.href='<%=contextPath%>/selectList.abo?currentPage=<%=pi.getCurrentPage()-1%>';">&lt;</button>
		<% } %>
		
		<% for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++) { %>
			<%if(i==pi.getCurrentPage()) {%>
				<button type="button" disabled><%=pi.getCurrentPage()%></button>
			<% } else {%>
				<button type="button"onclick="location.href='<%=contextPath%>/selectList.abo?currentPage=<%=i%>';"><%=i %></button>
			<% } %>
		<% } %>

		<% if(pi.getMaxPage()!=pi.getCurrentPage()) { %>
			<button type="button" onclick="location.href='<%=contextPath%>/selectList.abo?currentPage=<%=pi.getCurrentPage()+1%>';">&gt;</button>
		<% } else { %>
			<button type="button" disabled>&gt;</button>
		<% } %>
	<% } %>
	</div>
	
	<script>
					
		// 상세페이지 detail view로 넘어가는 이벤트
		$("tbody>tr").click(function(e){
			var bno = $(this).children().eq(0).text();
			location.href="<%=contextPath%>/detail.abo?bno="+bno;
			e.stopImmediatePropagation()
		});
		
		//삭제버튼 이벤트 실행 후 tr 이벤트 실행되지 않도록 처리(버블링)
		$(".btn-5").click(function(e){
				if(confirm("게시물을 삭제하시겠습니까?")){
					location.href='<%=contextPath %>/delete.abo?bno=' + $(this).attr("name") ;
				} else {
					alert("삭제를 취소하셨습니다.");
				}
		    e.stopImmediatePropagation(); //다음 요소들로 전달을 막는 메서드
		}); 
	</script>
</body>
</html>