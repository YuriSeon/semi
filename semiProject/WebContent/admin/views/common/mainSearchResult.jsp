<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.kh.board.model.vo.Board, com.kh.bMember.model.vo.BMember, com.google.gson.Gson"%>
<%
	ArrayList<Board> blist = (ArrayList<Board>)request.getAttribute("bList");
	ArrayList<BMember> mlist = (ArrayList<BMember>)request.getAttribute("mList");
	
	Gson gson = new Gson();
	String mlistS = gson.toJson(mlist);
	String blistS = gson.toJson(blist);
	
	String search = (String)request.getAttribute("search");
	int mPage = (int)request.getAttribute("mPage");
	int bPage = (int)request.getAttribute("bPage");
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
	#btn1, #btn2{
		margin-top: 10px;
		text-align : center;
	}
	button{
		margin-left: 5px;
	}
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<!-- 리스트 널이면 검색결과없음 보여주고 결과 있으면 클릭이벤트로 상세페이지로 넘어가는 매핑주소 연결 -->
	<h2>"<%=search %>" 검색하신 결과입니다.</h2>
	<div id="wrapper">
		<div id="bb">
			<div id="member">
			</div>
			<div id="btn1">
			</div>
			<div id="board">
			</div>
			<div id="btn2">
			</div>
		</div>
	</div>
	<script>
		
		$(function(){
			<%if(mlist!=null && blist!=null) {%>
				<% if(mlist.isEmpty() && blist.isEmpty()) { %>
					$("#bb").html("<h2>검색어와 일치하는 결과가 없습니다.</h2>");
				<% } else if(mlist.isEmpty()) {%>
					$("#board").html(boardTable(7));
					$("#btn1").html(bPagebar("<%=blist7%>"));
				
				<% } else if(blist.isEmpty()) {%>
					$("#member").html(memberTable(7));
					$("#btn1").html(mPagebar("<%=mlist7%>"));
				<% } else { %>
					$("#member").html("<br>"+memberTable(4));
					$("#btn1").html(mPagebar("<%=mlist4%>"));
					$("#board").html("<br>"+boardTable(4));
					$("#btn2").html(bPagebar("<%=blist4%>"));
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
		
		function mPagebar(num){
			var btn = "";
			if(num> 1) {
				if(<%=mPage%>==1) {
					btn +='<button type="button" disabled>&lt;</button>';
				} else {
					btn +="<button type='button' onclick=\"location.href='<%=contextPath%>/mainSearch.menu?search=<%=search%>&bPage=<%=bPage%>&mPage=<%=mPage-1%>';\">&lt;</button>";
				}
				for(var j=1; j<=num; j++) {
					if(j==<%=mPage%>) {
						btn +="<button type='button' disabled>"+j+"</button>";
					} else {
						btn +="<button type='button' onclick=\"location.href='<%=contextPath%>/mainSearch.menu?search=<%=search%>&bPage=<%=bPage%>&mPage="+j+"';\">"+j+"</button>";
					}
				}
				if(num!=<%=mPage%>) {
					btn +="<button type='button' onclick=\"location.href='<%=contextPath%>/mainSearch.menu?search=<%=search%>&bPage=<%=bPage%>&mPage=<%=mPage+1%>';\">&gt;</button>";
				} else {
					btn +="<button type='button' disabled>&gt;</button>"
				}
				return btn;
			}
		}
	
		function bPagebar(num){
			var btn = "";
			if(num> 1) {
				if(<%=bPage%>==1) {
					btn +='<button type="button" disabled>&lt;</button>';
				} else {
					btn +="<button type='button' onclick=\"location.href='<%=contextPath%>/mainSearch.menu?search=<%=search%>&mPage=<%=mPage%>&bPage=<%=bPage-1%>';\">&lt;</button>";
				}
				for(var j=1; j<=num; j++) {
					if(j==<%=bPage%>) {
						btn +="<button type='button' disabled>"+j+"</button>";
					} else {
						btn +="<button type='button' onclick=\"location.href='<%=contextPath%>/mainSearch.menu?search=<%=search%>&mPage=<%=mPage%>&bPage="+j+"';\">"+j+"</button>";
					}
				}
				if(num!=<%=bPage%>) {
					btn +="<button type='button' onclick=\"location.href='<%=contextPath%>/mainSearch.menu?search=<%=search%>&mPage=<%=mPage%>&bPage=<%=bPage+1%>';\">&gt;</button>";
				} else {
					btn +="<button type='button' disabled>&gt;</button>"
				}
				return btn;
			}
		}
		
		var mlist = <%=mlistS%>;
		var blist = <%=blistS%>;
		
		function memberTable(value){
			var member = "<table id='tab' class='member'><thead><tr><th>NO</th><th>ID</th><th>Name</th>"
						+"<th>Email</th><th>University</th><th>Nickname</th></tr></thead>"
						try{
							for (var i=(<%=mPage%>-1)*value; i<<%=mPage%>*value; i++) {
								member+="<tr>"
										+"<td>"+mlist[i].userNo+"</td>"
										+"<td>"+mlist[i].userId+"</td>"
										+"<td>"+mlist[i].userName+"</td>"
										+"<td>"+mlist[i].email+"</td>"
										+"<td>"+mlist[i].schoolNo+"</td>"
										+"<td>"+mlist[i].userNick+"</td>"
										+"</tr>"
							}
						}catch(err){}
				member+= "</tbody></table>";
			return member;
		}
		
		function boardTable(value){
			var board = "<table id='tab' class='board'><thead><tr><th>NO</th><th>Writer</th><th>Category</th>"
						+"<th>Title</th><th>Status</th></tr></thead><tbody>"
						try { 
							for(var i=(<%=bPage%>-1)*value; i<<%=bPage%>*value; i++) {
								board+= "<tr>"
										+"<td>"+blist[i].boardNo+"</td>"
										+"<td>"+blist[i].boardWriter+"</td>"
										+"<td>"+blist[i].boardType+"</td>"
										+"<td>"+blist[i].boardTitle+"</td>"
										+"<td>"+blist[i].status+"</td>"
										+"</tr>"
							}
						} catch (err){}
				board+= "</tbody></table>";
			return board;
		}
	</script>
</body>
</html>