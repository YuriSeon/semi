<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="java.util.ArrayList, com.kh.admin.userManage.model.vo.*, com.kh.bMember.model.vo.BMember"%>
<%
	ArrayList<User> list = (ArrayList<User>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#user1{
	height: 180px;
}
#user2{
	height: 100px;
}
td>input{
	box-sizing: border-box;
	width: 100%;
	height: 100%;
	color: rgb(255, 148, 166);
}
table *{
	text-align: center;
}
table{
	table-layout: fixed;
}
td{
	background-color: white;
}
#btnbtn{
	text-align: center;
	margin-top: 50px;
}
p{
	margin: 10px;
	padding: 3px;
	margin-left: 30px;
	margin-top: 20px;
}
button{
	margin: 13px;
}
#back, #userUpdate{
	width: 105px;
  	height: 40px;
}
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<div id="wrapper">
		<div id="bb">
			<p> ♥ 개인정보 영역 </p>
			<% if(!list.isEmpty()) { %>
				<% for(int i=0; i<list.size(); i++) { %>
					<table id="user1">
						<% if(list.get(i) instanceof BMember) { %>
							<tr>
								<th>회원번호</th>
								<td id="userNo"><%= ((BMember)list.get(i)).getUserNo() %></td>
								<th>ID</th>
								<td><%= ((BMember)list.get(i)).getUserId() %></td>
								<th>이름</th>
								<td><%= ((BMember)list.get(i)).getUserName() %></td>
							</tr>
							<tr>
								<th>닉네임</th>
								<td><%=((BMember)list.get(i)).getUserNick() %></td>
								<th>Email</th>
								<td><%=((BMember)list.get(i)).getEmail() %></td>
								<th>주민번호</th>
								<td><%=((BMember)list.get(i)).getSsn().substring(0,8)+"******"%></td>
							</tr>
							<tr>
								<th>학교인증 / 학교명</th>
								<td colspan="3">
									<%= ((BMember)list.get(i)).getSchool_st() %> &nbsp;&nbsp; / &nbsp;&nbsp; <%= ((BMember)list.get(i)).getSchoolNo() %>
								</td>
								<th>입맛점수</th>
								<td><input type="text" id="point" name="point" value="<%=((BMember)list.get(i)).getPoint() %>"></td>
							</tr>
						<% } %>
						<% i++; %>
						<% if(list.get(i) instanceof UserManage) { %>
							<tr>
								<th>작성 게시글 수</th>
								<td><%=((UserManage)list.get(i)).getBoardCount() %></td>
								<th>작성 댓글 수</th>
								<td><%=((UserManage)list.get(i)).getReplyCount() %></td>
								<th>맛집 게시글 제한</th>
								<td><input type="text" id="foodBoard" name="foodBoard" value="<%=((UserManage)list.get(i)).getFoodBStatus() %>"></td>
							</tr>
						<% } %>	
					</table>	
				<p> ♥ 회원 활동 관리 영역 </p>	
				<table id="user2">
					<% i++; %>
					<% if(list.get(i) instanceof UserCondition) { %>
						<tr>
							<th>게시물 신고</th>
							<td><input type="text" name="block" id="block" value="<%=((UserCondition)list.get(i)).getBlockC() %>"></td>
							<th>DM 차단</th>
							<td><input type="text" id="dmBlock" name="dmBlock" value="<%=((UserCondition)list.get(i)).getDmBlockC() %>"></td>
							<th>허위 신고 내역</th>
							<td><input type="text" id="falseBlock" name="falseBlock" value="<%=((UserCondition)list.get(i)).getFalseBlockC() %>"></td>
							<th>신고 및 차단 합계</th>
							<td id="totalB"><%=((UserCondition)list.get(i)).getBlockC()+((UserCondition)list.get(i)).getDmBlockC()+((UserCondition)list.get(i)).getFalseBlockC() %></td>
						</tr>
						<tr>
							<th>게시글 필터링</th>
							<td><input type="text" id="boardF" name="boardF" value="<%=((UserCondition)list.get(i)).getBoardFiltering()%>"></td>
							<th>댓글 필터링</th>
							<td><input type="text" id="replyF" name="replyF" value="<%=((UserCondition)list.get(i)).getReplyFiltering()%>"></td>
							<th>총 필터링 합계</th>
							<td id="totalF"><%=((UserCondition)list.get(i)).getBoardFiltering() + ((UserCondition)list.get(i)).getReplyFiltering()%></td>
							<th>받은 경고장 </th>
							<td><input type="text" id="yellow" name="yellow" value="<%=((UserCondition)list.get(i)).getYellowCard()%>"></td>
						</tr>
					<% } %>
				</table>
				<% } %>
			<% } %>
			<div id="btnbtn">
				<button type="button" class="custom-btn btn-9" id="back" onclick="history.back()">뒤로가기</button>
				<button type="button" class="custom-btn btn-10" id="userUpdate">회원정보수정</button>
				<button type="button" class="custom-btn btn-11" id="delete">회원강제탈퇴</button>
			</div>
		</div>
	</div>
	    
		 <script>
	 		$("#userUpdate").click(function(){
	 			$.ajax({
	 				url:"update.um",
	 				data:{
	 					userNo : $("#userNo").text(),
	 					point : $("#point").val(),
	 					foodBoard : $("#foodBoard").val(),
	 					block : $("#block").val(),
	 					dmBlock : $("#dmBlock").val(),
	 					falseBlock : $("#falseBlock").val(),
	 					yellow : $("#yellow").val(),
	 					boardF : $("#boardF").val(),
	 					replyF : $("#replyF").val()
	 				},
	 				type:"post",
	 				success:function(list){
	 					if(<%=!list.isEmpty()%>){
	 						alert("회원정보 업데이트 성공")
		 						<%
		 						for(int i=0;i<list.size();i++) {
		 							if(list.get(i) instanceof BMember){ %>
		 								$("#point").attr("value", "<%=((BMember)list.get(i)).getPoint()%>");
		 						<%		i++;
		 							}
		 							if(list.get(i) instanceof UserManage){%>
		 								$("#foodBoard").attr("value", "<%=((UserManage)list.get(i)).getFoodBStatus()%>");
		 						<%		i++;
		 							}
		 							if(list.get(i) instanceof UserCondition){ %>
		 								$("#block").attr("value", "<%=((UserCondition)list.get(i)).getBlockC()%>");
		 								$("#dmBlock").attr("value", "<%=((UserCondition)list.get(i)).getDmBlockC()%>");
		 								$("#falseBlock").attr("value", "<%=((UserCondition)list.get(i)).getFalseBlockC()%>");
		 								$("#yellow").attr("value", "<%=((UserCondition)list.get(i)).getYellowCard()%>");
		 								$("#boardF").attr("value", "<%=((UserCondition)list.get(i)).getBoardFiltering()%>");
		 								$("#replyF").attr("value", "<%=((UserCondition)list.get(i)).getReplyFiltering()%>");
		 						<%	}
		 						}
		 						%>
		 						$("#totalB").text(parseInt($("#block").val())+parseInt($("#dmBlock").val())+parseInt($("#falseBlock").val()));
		 						console.log(parseInt($("#boardF").val())+parseInt($("#replyF").val()));
		 						$("#totalF").text(parseInt($("#boardF").val())+parseInt($("#replyF").val()));
	 					} else {
	 						alert("회원정보 업데이트 실패로 회원관리 메인페이지로 돌아갑니다");
	 						location.href="<%=contextPath%>/main.um?currentPage=1";
	 					}
	 				},
	 				error:function(){
	 					console.log("통신에러");
	 				}
	 			});
	 		});
			
	 		 $("#delete").click(function(){
	         	var userNo = $("#userNo").text();
	             if(confirm( userNo + "번 회원과 작별인사 하시겠습니까?")){
	                 location.href="<%=contextPath %>/delete.um?userNo=" + userNo;
	             } else {
	                 alert("탈퇴시키기를 취소하셨습니다.");
	             }
	         });  	
		 	
	 	</script>
	</body>
</html>