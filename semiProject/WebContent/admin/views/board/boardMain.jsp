<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.Board, java.util.ArrayList, com.kh.common.model.vo.PageInfo"%>
<%
	ArrayList<Board> blist = (ArrayList<Board>)request.getAttribute("blist");	
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	int typeNo = (int)request.getAttribute("typeNo");
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
				<form action="<%=contextPath%>/selectList.abo" method="get">
					<input type="hidden" name="currentPage" value="1">
					<select name="category" id="board-category">
						<option name="b-category" value="4">공지사항</option>
						<option name="b-category" value="1">영상</option>
						<option name="b-category" value="2">대나무숲</option>
						<option name="b-category" value="3">맛집</option>
					</select>
					<div><input type="search" name="search" placeholder="검색어를 입력하세요"></div>
					<div><button type="submit">검색</button></div>
				</form>
			<button type="button" onclick="location.href='<%=contextPath%>/insert.abo'">작성하기</button>	
			<button type="button" onclick="location.href='<%=contextPath%>/blurboard.abo?currentPage=1'">Check★</button>	
			</div>
			<hr>
			<div id="con2">
				<!-- 게시물 조회해와서 버튼이랑 같이 반복문으로 출력하기 -->
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
						<% if(blist.isEmpty()) {%>
							<tr>
								<td>작성된 공지사항이 없습니다.</td>
							</tr>
						<% } else {%>
							<% for(Board b : blist) {%>
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
					
					<!-- selectbox attr checked로 바뀌게해서 설정값이랑 맞추기  -->
				</table>
			</div>
			<div>
	<!-- 페이징처리 -->
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
	</div>
		</div>
	</div>
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
			location.href="<%=contextPath%>/detail.abo?status=Y&bno="+bno;
		});
	</script>
</body>
</html>