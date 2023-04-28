<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="java.util.ArrayList, com.kh.common.model.vo.PageInfo, 
    		com.kh.admin.userManage.model.vo.*, com.kh.bMember.model.vo.BMember"%>
<% 
	ArrayList<User> list = (ArrayList<User>)request.getAttribute("list");
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
	tbody>tr:hover{
		background-color: rgb(241, 241, 241);
		cursor: pointer;
	}
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<h2>회원 정보</h2>
	<br>
	<div id="wrapper">
		<br>
			<div id="bb">
				<div>
					<select name="select-sort" class="orderBy" id="orderByS">
						<option value="desc">내림차순</option>
						<option value="asc">오름차순</option>
					</select>
					<select name="select-order" class="orderBy" id="orderByC">
						<option value="recently">recent update</option>
						<option value="foodRank">FoodRank</option>
						<option value="total">Activity</option>
					</select>
				</div>
			</div>
		<br>
		<table id="tab">
			<thead>
				<tr>
					<th>NO</th>
					<th>ID</th>
					<th>Name</th>
					<th>Phone</th>
					<th>Email</th>
					<th>University</th>
					<th>Upload Board</th>
					<th>Upload Reply</th>
					<th>Food Rank</th>
				</tr>
			</thead>
			<tbody>
		
				<%if(!list.isEmpty()) { %>
					<%for(int i=0; i<list.size(); i++) {%>
						<tr>
							<%if(list.get(i) instanceof BMember) {%>
							
							<td><%=((BMember)list.get(i)).getUserNo()%></td>
							<td><%=((BMember)list.get(i)).getUserId() %></td>
							<td><%=((BMember)list.get(i)).getUserName() %></td>
							<td><%=((BMember)list.get(i)).getPhone() %></td>
							<td><%=((BMember)list.get(i)).getEmail() %></td>
							<td><%=((BMember)list.get(i)).getSchoolNo() %></td>
							<% } %>
							<% i++; %>
							<%if(list.get(i) instanceof UserManage) {%>
							<td><%=((UserManage)list.get(i)).getBoardCount() %></td>
							<td><%=((UserManage)list.get(i)).getReplyCount() %></td>
							<td><%=((UserManage)list.get(i)).getFoodBStatus() %></td>
						</tr>
							<% } %>
						<% } %>
				<% } else if (list==null) { %>
				
				<% } else { %>
					<tr>
						<td colspan="10">조회내역이 없습니다.</td>
					</tr>
				<% } %>
			</tbody>
		</table>
	</div>
		<div>
		<!-- 페이징처리 -->
			<% if(pi.getCurrentPage()==1) {%>
				<button type="button" disabled></button>
			<% } else { %>
				<button type="button" onclick="location.href='<%=contextPath%>/main.um?currentPage=<%=pi.getCurrentPage()-1%>';">&lt;</button>
			<% } %>
			<% for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++) { %>
				
				<%if(i==pi.getCurrentPage()) {%>
					<button type="button" disabled>i</button>
				<% } else {%>
					<button type="button" onclick="location.href='<%=contextPath%>/main.um?currentPage=<%=i%>';"><%=i %></button>
				<% } %>
				
			<% } %>
			
			<% if(pi.getMaxPage()!=pi.getCurrentPage()) { %>
					<button type="button" onclick="location.href='<%=contextPath%>/main.um?currentPage=<%=pi.getCurrentPage()+1%>';">&gt;</button>
			<% } else { %>
				<button type="button" disabled>&gt;</button>
			<% } %> 
		</div>

		<script>
			
			
			$(".orderBy").on("change", function() {
				var sort = $("#orderByS option:selected").val();
				var select = $("#orderByC option:selected").val();
				console.log(sort);
				console.log(select);
				$.ajax({
					url : "main.um",
					data : {
						sort : sort,
						select : select,
						currentPage : "1"
					},
					type : "post",
					success : function(list) {
						
						var str = "";
						if(sort == "asc"){
							for(var i=0;i<list.length; i++){
								str +="<tr>"
									+"<td>"+list[i].userNo+"</td>"
									+"<td>"+list[i].userId+"</td>"
									+"<td>"+list[i].userName+"</td>"
									+"<td>"+list[i].phone+"</td>"
									+"<td>"+list[i].email+"</td>"
									+"<td>"+list[i].schoolNo+"</td>"
									i++;
									str+=
									"<td>"+list[i].boardCount+"</td>"
									+"<td>"+list[i].replyCount+"</td>"
									+"<td>"+list[i].foodBStatus+"</td>"
									+"</tr>";
							}
						} else {
							for(var i=1;i<list.length; i+=3){
								str +="<tr>"
									+"<td>"+list[i].userNo+"</td>"
									+"<td>"+list[i].userId+"</td>"
									+"<td>"+list[i].userName+"</td>"
									+"<td>"+list[i].phone+"</td>"
									+"<td>"+list[i].email+"</td>"
									+"<td>"+list[i].schoolNo+"</td>"
									i--;
									str+=
									"<td>"+list[i].boardCount+"</td>"
									+"<td>"+list[i].replyCount+"</td>"
									+"<td>"+list[i].foodBStatus+"</td>"
									+"</tr>";
							}
						}
						$("#tab tbody").html(str);
					},
					error : function() {
						console.log("통신실패");
					}
				});
			});

			$("#tab tbody>tr").click(function(){
				// console.log($(this).children().eq(0).text());
				var userNo = $(this).children().eq(0).text();
				location.href="<%= contextPath%>/update.um?userNo="+userNo;
			});
			
		</script>
	</body>
</html>