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
<style>
	tbody>tr:hover{
		background-color: rgb(241, 241, 241);
		cursor: pointer;
	}
	#bb{
		text-align: center;
	}
	btn-8{
		margin-bottom: 100px;
	}
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<div id="wrapper">
		<div id="bb"><br><br>
			<%if(list!=null && !list.isEmpty()) { %>
				<table id="tab">
					<thead>
						<tr>
							<th>No</th>
							<th>Category</th>
							<th>Writer</th>
							<th>Title</th>
							<th>Bad</th>
							<th>Report</th>
							<th>Count</th>
							<th>CreateDate</th>
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
	        <% } else { %>
	        	<h1 style="line-height: 500px; text-align: center;">확인 필요한 게시물이 없습니다</h1>
	        	<button class='custom-btn btn-8' onclick="location.href='<%=contextPath%>/main.admin';">메인으로</button>
	        <% } %>
	    </div>
    </div>
    <div>
		<!-- 페이징처리 -->
		<% if(pi.getCurrentPage()==1) {%>
			<button type="button" disabled></button>
		<% } else { %>
			<button type="button" onclick="location.href='<%=contextPath%>/blurboard.abo?currentPage=<%=pi.getCurrentPage()-1%>';">&lt;</button>
		<% } %>
		
		<% for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++) { %>
			<%if(i==pi.getCurrentPage()) {%>
				<button type="button" disabled>i</button>
			<% } else {%>
				<button type="button" onclick="location.href='<%=contextPath%>/blurboard.abo?currentPage=<%=i%>';"><%=i %></button>
			<% } %>
		<% } %>
		<% if(pi.getMaxPage()!=pi.getCurrentPage()) { %>
			<button type="button" onclick="location.href='<%=contextPath%>/blurboard.abo?currentPage=<%=pi.getCurrentPage()+1%>';">&gt;</button>
		<% } else { %>
			<button type="button" disabled>&gt;</button>
		<% } %>		
	</div>
</body>
<script>
	$("#tab tbody>tr").click(function(){
		var bno = $(this).children().eq(0).text();
		location.href="<%=contextPath %>/blurDetail.abo?bno="+bno;
	});

</script>
</html>