<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.kh.board.model.vo.Board, com.kh.bMember.model.vo.BMember"%>
<%
	ArrayList<Board> blist = (ArrayList<Board>)request.getAttribute("bList");
	ArrayList<BMember> mlist = (ArrayList<BMember>)request.getAttribute("mList");
	String search = (String)request.getAttribute("search");
	int currentPage = (int)request.getAttribute("currentPage");
	int mlist7 = (int)Math.ceil((double)mlist.size()/7);
	int mlist4 = (int)Math.ceil((double)mlist.size()/4);
	int blist7 = (int)Math.ceil((double)blist.size()/7);
	int blist4 = (int)Math.ceil((double)blist.size()/4);
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
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<!-- 리스트 널이면 검색결과없음 보여주고 결과 있으면 클릭이벤트로 상세페이지로 넘어가는 매핑주소 연결 -->
	<div id="wrapper">
		<div id="bb">
			<div id="member">
				<div id="btn1">
				</div>
			</div>
			<div id="board">
				<div id="btn2">
				</div>
			</div>
		</div>
	</div>
	<script>
		
		
		
		
		$(function(){
			<%if(mlist!=null && blist!=null) {%>
				<% if(mlist.isEmpty() && blist.isEmpty()) { %>
					$("#bb").html("<h2>검색어와 일치하는 결과가 없습니다.</h2>");
				<% } else if(mlist.isEmpty()) {%>
					$("#member").html(boardTable(7));
					$("#btn1").html(pagebar("<%=blist7%>"));
				
				<% } else if(blist.isEmpty()) {%>
					$("#board").html(memberTable(7));
					$("#btn1").html(pagebar("<%=mlist7%>"));
				<% } else { %>
					$("#member").html(memberTable(4));
					$("#btn1").html(pagebar("<%=mlist4%>"));
					$("#board").html("<hr>"+boardTable(4)));
					$("#btn2").html(pagebar("<%=blist4%>"));
				<% } %>
			<% }%>
		});

		$(".member tbody>tr").on("click",function(){
			var userNo = $(this).children().eq(0).text();
			location.href="<%=contextPath %>/detail.um?userNo=" + userNo;
		});
		
		$(".board tbody>tr").on("click", function(){
			var bno = $(this).children().eq(0).text();
			location.href="<%=contextPath%>/detail.abo?bno="+bno;
		});
		
		function pagebar(num){
			var btn = "";
			if(num> 1) {
				if(<%=currentPage%>==1) {
					btn +='<button type="button" disabled>&lt;</button>'
				} else {
					btn +="<button type='button' onclick='location.href='<%=contextPath%>/mainsearch.menu?currentPage=<%=currentPage-1%>&search=<%=search%>''>&lt;</button>"
				}
				for(var j=<%=currentPage%>; j<=num; j++) {
					if(j==<%=currentPage%>) {
						btn +="<button type='button' disabled>"+j+"</button>"
					} else {
						btn +="<button type='button' onclick='location.href='<%=contextPath%>/mainsearch.menu?currentPage="+j+"&search=<%=search%>';'>"+j+"</button>"
					}
				}
				if(num!=<%=currentPage%>) {
					btn +="<button type='button' onclick='location.href='<%=contextPath%>/mainsearch.menu?currentPage=<%=currentPage+1%>&search=<%=search%>';'>&gt;</button>"
				} else {
					btn +="<button type='button' disabled>&gt;</button>"
				}
				return btn;
			}
		}
		var currentPage = <%=currentPage%>;
		
		function memberTable(value){
			var member = "<table id='tab' class='member'><thead><tr><th>NO</th><th>ID</th><th>Name</th>"
				member+="<th>Email</th><th>University</th><th>Nickname</th></tr></thead>"
				<% try { %>
					for (var i=(currentPage-1)*value; i<currentPage*value; i++) {
						+"<tr>"
						+"<td>"+<%=mlist.get(i).getUserNo()%>+"</td>"
						+"<td>"+<%=mlist.get(i).getUserId()%>+"</td>"
						+"<td>"+<%=mlist.get(i).getUserName()%>+"</td>"
						+"<td>"+<%=mlist.get(i).getEmail()%>+"</td>"
						+"<td>"+<%=mlist.get(i).getSchoolNo()%>+"</td>"
						+"<td>"+<%=mlist.get(i).getUserNick()%>+"</td>"
						+"</tr>"
					}
				<% } catch (Exception e){}%>
				+"</tbody></table>";
				
			return member;
		}
		
		function boardTable(value){
			var board = "<table id='tab' class='board'><thead><tr><th>NO</th><th>Writer</th><th>Category</th>"
				+"<th>Title</th><th>Status</th></tr></thead><tbody>"
				<% try { %>
					for(var i=currentPage-1*value; i<currentPage*value; i++) {
						+"<tr>"
						+"<td>"+<%=blist%>+"</td>"
						+"<td>"+<%=blist(i).getBoardWriter()%>+"</td>"
						+"<td>"+<%=blist(i).getBoardType()%>+"</td>"
						+"<td>"+<%=blist(i).getBoardTitle()%>+"</td>"
						+"<td>"+<%=blist(i).getStatus()%>+"</td>"
						+"</tr>"
					}
				<% } catch (Exception e){}%>
				+"</tbody></table>";
			return board;
		}
	</script>
</body>
</html>