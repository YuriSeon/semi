<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="com.kh.common.model.vo.PageInfo, com.kh.bMember.model.vo.BMember, 
    		java.util.ArrayList, com.google.gson.Gson"%>
 <%
 	PageInfo pi = (PageInfo)request.getAttribute("pi");
 	ArrayList<BMember> list = (ArrayList<BMember>)request.getAttribute("list");
 	int option = Integer.parseInt(request.getParameter("option"));
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>USER CHECKLIST</title>
<style>
	#search_select, input{
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
	#box{
		height : 25px;
		margin-top :10px;
		margin-bottom : 5px;
	}
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp"%>
	<div id="wrapper">
		<div id="bb"><br>
			<form action="<%=contextPath %>/select.ck" method="post">
				<div id="search_div">
					<input type="hidden" name="currentPage" value="1">
					<select name="select" id="search_select" onchange="selectboxP();">
						<option value="1" selected>ID</option>
						<option value="2">차단 합계</option>
						<option value="3">게시물 필터링 수</option>
					</select>
				</div>
				<div>
					<input type="search" name="search_input" id="search_input" placeholder="검색할 ID를 입력하세요.">
				</div>
				<div>
					<button type="submit" class="custom-btn btn-10">검색</button>
				</div>
			</form>
				<!-- 만약 리스트가 비어있다면 비활성화 하기 조건문  -->
				<button type="button" id="checkL" class="custom-btn btn-11" onclick="location.href='<%=contextPath%>/important.ck?currentPage=1'">★ Check</button>
			<div>
			</div>
			<br>
			<div><br>
				<select id="box" name="box" onchange="selectboxP();">
					<option value="1" selected>최근 업데이트순 </option>
					<option value="2">차단 합계</option>
					<option value="3">게시물 필터링 수</option>
				</select>
			</div>
		</div>
		<%if(list!=null && !list.isEmpty()) { %>
		    <table id="tab">
				<thead>
					<tr>
						<th>NO</th>
						<th>ID</th>
						<th>Name</th>
						<th>Block Count</th>
						<th>Filtering Count</th>
						<th>Food point</th>
						<th>Enroll Date</th>
						<th>Update Date</th>
					</tr>
				</thead>
				<tbody>
						<%for(int i=0; i<list.size(); i++) {%>
							<tr>
								<td><%=((BMember)list.get(i)).getUserNo()%></td>
								<td><%=((BMember)list.get(i)).getUserId() %></td>
								<td><%=((BMember)list.get(i)).getUserName() %></td>
								<td><%=((BMember)list.get(i)).getTotalB()%></td>
								<td><%=((BMember)list.get(i)).getTotalF() %></td>
								<td><%=((BMember)list.get(i)).getPoint() %></td>
								<td><%=((BMember)list.get(i)).getCreateDate() %></td>
								<td><%=((BMember)list.get(i)).getModifyDate() %></td>
		
							</tr>
							<% } %>
				</tbody>
			</table>
	    <% } else { %>
	        <p style="text-align: center; font-weight: bold; font-size:large">확인이 필요한 회원이 없습니다.</p>
	    <% } %>
    </div>
	<div>
	<!-- option값 체크된거 넘어가도록 처리 -->
		<% if(pi.getMaxPage()>1) { %>
			<!-- 페이징처리 -->
			<% if(pi.getCurrentPage()==1) {%>
			<button type="button" disabled>&lt;</button>
			<% } else { %>
			<button type="button"
				onclick="beforePage();">&lt;</button>
			<% } %>
			<% for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++) { %>
	
			<%if(i==pi.getCurrentPage()) {%>
			<button type="button" disabled><%=pi.getCurrentPage()%></button>
			<% } else {%>
			<button type="button" class="btnNum" name="<%=i %>" onclick="pageNum();"><%=i %></button>
			<% } %>
	
			<% } %>
	
			<% if(pi.getMaxPage()!=pi.getCurrentPage()) { %>
			<button type="button"
				onclick="afterPage();">&gt;</button>
			<% } else { %>
			<button type="button" disabled>&gt;</button>
			<% } %>
		<% } %>
	</div>

	<script>
		function selectboxP(){
	        if($("#search_select option:selected").val()=="1"){
		        $("#search_input").attr("placeholder","검색할 ID를 입력하세요.");
		    } else {
		        $("#search_input").attr("placeholder","기준치를 입력하세요.");
		    }
	   }	
	
	
		$(function(){
			$("#box").children().each(function(){
				if($(this).val()=="<%=option%>"){
					$(this).attr("selected", true);
				} 
			});
		});
	
		function beforePage(){
			location.href='<%=contextPath%>/main.ck?currentPage=<%=pi.getCurrentPage()-1%>&option='+$("#box option:selected").val();
		}
		
		function afterPage(){
			location.href='<%=contextPath%>/main.ck?currentPage=<%=pi.getCurrentPage()+1%>&option='+$("#box option:selected").val();
		}
		
		function pageNum(){
			location.href='<%=contextPath%>/main.ck?currentPage='+$(".btnNum").attr("name")+'&option='+$("#box option:selected").val();
		}
	
    	
    	
    	$("#box").on("change", function() {
			var box = $("#box option:selected").val();
			/* var gson = GsonBuilder().setDateFormat("yyyy-MM-dd").create() */
			$.ajax({
				url : "main.ck",
				data : {
					check : "na",
					option : box,
					currentPage : "1"
				},
				type : "get",
				success : function(list) {
					
					var str = "";
						for(var i=0;i<list.length; i++){
							str +="<tr>"
								+"<td>"+list[i].userNo+"</td>"
								+"<td>"+list[i].userId+"</td>"
								+"<td>"+list[i].userName+"</td>"
								+"<td>"+list[i].totalB+"</td>"
								+"<td>"+list[i].totalF+"</td>"
								+"<td>"+list[i].point+"</td>"
								+"<td>"+list[i].createDate+"</td>"
								+"<td>"+list[i].modifyDate+"</td>"
								+"</tr>";
						}
					$("#tab tbody").html(str);
				},
				error : function() {
					console.log("통신실패");
				}
			});
		});
    	
    		$("#tab tbody>tr").on("click",function(){ // 동적으로 생긴 tr에도 이벤트를 걸겠다!
    			var userNo = $(this).children().eq(0).text();
    			location.href="<%=contextPath %>/update.um?userNo="+userNo;
    		});
   </script>
</body>
</html>