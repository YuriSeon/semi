<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.ArrayList, com.kh.board.model.vo.Board, com.kh.bMember.model.vo.BMember"%>
<%
	ArrayList<Board> blist = (ArrayList<Board>)request.getAttribute("bList");
	ArrayList<BMember> mlist = (ArrayList<BMember>)request.getAttribute("mList");
	String search = (String)request.getAttribute("search");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<!-- 리스트 널이면 검색결과없음 보여주고 결과 있으면 클릭이벤트로 상세페이지로 넘어가는 매핑주소 연결 -->
	<script>
		var member = "<table id='member'><thead><tr><th>NO</th><th>ID</th><th>Name</th>"
						+"<th>Email</th><th>University</th><th>Nickname</th></tr></thead>"
						<% for (BMember m : mlist) { %>
						+"<tr>"
						+"<td>"+<%=m.getUserNo()%>+"</td>"
						+"<td>"+<%=m.getUserId()%>+"</td>"
						+"<td>"+<%=m.getUserName()%>+"</td>"
						+"<td>"+<%=m.getEmail()%>+"</td>"
						+"<td>"+<%=m.getSchoolNo()%>+"</td>"
						+"<td>"+<%=m.getUserNick()%>+"</td>"
						+"</tr>"
					<% } %>
					+"</tbody></table>";
		
		var baord = "<table id='board'><thead><tr><th>NO</th><th>Writer</th><th>Category</th>"
					+"<th>Title</th><th>Status</th></tr></thead><tbody>"
						<% for(Board b : blist) { %>
						"<tr>"
						+"<td>"+<%=b.getBoardNo()%>+"</td>"
						+"<td>"+<%=b.getBoardWriter()%>+"</td>"
						+"<td>"+<%=b.getBoardType()%>+"</td>"
						+"<td>"+<%=b.getBoardTitle()%>+"</td>"
						+"<td>"+<%=b.getStatus()%>+"</td>"
						+"</tr>"
					<% } %>
					+"</tbody></table>";
		$(function(){
			<% if(mlist.isEmpty() && blist.isEmpty()) { %>
				$("#bb").html("<h2>검색어와 일치하는 결과가 없습니다.</h2>");
			<% } else if(mlist.isEmpty()) {%>
				$.("#bb").html(board);
			<% } else if(blist.isEmpty()) {%>
				$.("#bb").html(member);
			<% } else { %>
				<% if(mlist.size()>blist.size()) {%>
					$("#bb").html(member+"<hr>"+board);
				<% } else { %>
					$.("#bb").html(board+"<hr>"+member);
				<% } %>
			<% } %>
		});
	</script>
	<div id="wrapper">
		<div id="bb">
		</div>
	</div>
	<script>
		$("#member tbody>tr").click(function(){
			var userNo = $(this).children().eq(0).text();
			var status = $(this).children().eq(4).text();
			location.href="<%=contextPath %>/detail.um?userNo=" + userNo+'&status='+status;
		});
		
		$("#board tbody>tr").click(function(){
			var bno = $(this).children().eq(0).text();
			location.href="<%=contextPath%>/detail.abo?bno="+bno;
		});
	</script>
</body>
</html>