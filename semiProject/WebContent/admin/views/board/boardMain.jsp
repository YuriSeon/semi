<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.Board, java.util.ArrayList, com.kh.common.model.vo.PageInfo"%>
<%
	ArrayList<Board> blist = (ArrayList<Board>)request.getAttribute("blist");	
	PageInfo pi = (PageInfo)request.getAttribute("pi");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
	select, input{
		height: 30px;
		margin: 0;
		padding: 0;
	}
	.btn-11{
		vertical-align: middle;
		font-size: medium;
		margin-top: 13px;
	}
	tbody>tr:hover{
		background-color: rgb(241, 241, 241);
		cursor: pointer;
	}

</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	
	<div id="wrapper">
		<div id="bb">
			<div id="con1">
				<form action="<%=contextPath%>/selectList.abo" method="get">
					<div>
						<input type="hidden" name="currentPage" value="1"><br>
						<select name="category" id="board-category">
							<option name="b-category" value="4">공지사항</option>
							<option name="b-category" value="2">대나무숲</option>
							<option name="b-category" value="3">맛집</option>
						</select>
						<div><input type="search" name="search" placeholder="검색어를 입력하세요"></div>
						<div><button class="custom-btn btn-10" type="submit">검색</button></div>
						<button type="button" class="custom-btn btn-10" onclick="location.href='<%=contextPath%>/insert.abo'">작성하기</button>	
					</div>
				</form>
				<button type="button" class="custom-btn btn-11" id="checkL" onclick="location.href='<%=contextPath%>/blurboard.abo?currentPage=1'">Check★</button>	
			</div>
		</div>
		<br>
		<div id="con2">
			<%
			if (blist != null && blist.isEmpty()) {
			%>
				<p>작성된 공지사항이 없습니다.</p>
			<%
			} else {
			%>
			<table id="tab">
				<thead>
					<tr>
						<th>NO</th>
						<th>BoardType</th>
						<th>Category</th>
						<th>Writer</th>
						<th>Title</th>
						<th>Count</th>
						<th>CreateDate</th>
						<th>ModifyDate</th>
						<th>Delete</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Board b : blist) {
					%>
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
							<button name="<%=b.getBoardNo() %>" class="custom-btn btn-5">삭제</button>
						</td>
					</tr>
					<% } %>
					<% } %>
				</tbody>
				<!-- selectbox attr checked로 바뀌게해서 설정값이랑 맞추기  -->
			</table>
		</div>
	</div>
		<div>
		<!-- 페이징처리 -->
		<% if(pi.getMaxPage() > 0) { %>
			<% if(pi.getCurrentPage()==1) {%>
				<button type="button" disabled></button>
			<% } else { %>
				<button type="button" onclick="location.href='<%=contextPath%>/main.abo?currentPage=<%=pi.getCurrentPage()-1%>';">&lt;</button>
			<% } %>
			
			<% for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++) { %>
				<%if(i==pi.getCurrentPage()) {%>
					<button type="button" disabled>i</button>
				<% } else {%>
					<button type="button" onclick="location.href='<%=contextPath%>/main.abo?currentPage=<%=i%>';"><%=i %></button>
				<% } %>
			<% } %>
			
			<% if(pi.getMaxPage()!=pi.getCurrentPage()) { %>
				<button type="button" onclick="location.href='<%=contextPath%>/main.abo?currentPage=<%=pi.getCurrentPage()+1%>';">&gt;</button>
			<% } else { %>
				<button type="button" disabled>&gt;</button>
			<% } %> 
		<% } %>
		</div>
			
		<script>
			// 상세페이지 detail view로 넘어가는 이벤트
			$("tbody>tr").click(function(e){
				var bno = $(this).children().eq(0).text();
				location.href="<%=contextPath%>/detail.abo?status=Y&bno="+bno;
				e.stopImmediatePropagation(); //다음 요소들로 전달을 막는 메서드
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
			
			// 캡쳐링과 버블링이 같이 일어나는 상황이라서 둘 다 다음 요소로 전달을 막는 메서드를 사용해줘야 각각의 이벤트만 진행이 가능함
		</script>
	</body>
</html>