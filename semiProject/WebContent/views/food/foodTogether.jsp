<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Break Time[Food_TO]</title>
<style>
#example *{
	border:1px solid black;
}
</style>
</head>
<body>
<%
	ArrayList<HashMap<String, String>> list = (ArrayList<HashMap<String, String>>)request.getAttribute("list");
// 	// list에는 현재 밥 같이 먹기 게시판의 내용이 다 들어있다.
  	int check = (int)request.getAttribute("check");
%>

<!-- 
				map.put("changeName", rset.getString("CHANGE_NAME"));
				map.put("boarTitle", rset.getString("BOARD_TITLE"));
				map.put("person", rset.getString("PERSON"));
				map.put("endTime", rset.getString("END_TIME"));
				map.put("userId", rset.getString("USERID"));
				map.put("filePath", rset.getString("FILE_PATH"));
				
				보여줄때 필요한거 : 제목, 사진, 작성자, 종료시간, 인원제한
				디테일 뷰로 갈때 필요한거 : board_no

 -->
	<%@ include file="../common/menubar.jsp" %>
    <!-- 
    	들어오면 현재 게시물들을 보여준다.
     -->
  	<a href="<%=contextPath %>/foodmain.bo">메인으로가기</a>
  	<a href="<%=contextPath %>/foodTogetherInsert.bo">글쓰기</a>
<%--   	<iframe name="hiddeniframe" style="display:none;" src="<%=contextPath %>/views/food/test.jsp"></iframe> --%>
  	

<!--   	<div id="testiframe"></div> -->
  	
  	
  <%if(!list.isEmpty()) {%>
	<table id="example">
		<thead>
			<tr>
				<th>#</th>
				<th>제목</th>
				<th>작성자</th>
				<th>인원</th>
				<th>남은시간</th>
			</tr>
		</thead>
		<tbody>
		<%for(int i = 0; i < list.size(); i++){%>
		<%
			String[] timearr = list.get(i).get("endTime").split(":");
			int timeM = Integer.parseInt(timearr[0])*3600 + Integer.parseInt(timearr[1])*60; // 종료 시간 초 단위
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
			String now = sdf.format(d);
			String[] noewTime = now.split(":");
			int nowM = Integer.parseInt(noewTime[0])*3600 + Integer.parseInt(noewTime[1])*60 + Integer.parseInt(noewTime[2]);
			int showtime = timeM - nowM;
			int hour = showtime/3600;
			int min = (showtime%3600)/60;
			int sec = (showtime%3600)%60;	
			// 서버가 종료되면 시간이 가지 않는다.
		%>
		<%if(check == Integer.parseInt(list.get(i).get("boardNo"))){ %>
			 <tr>
			 	<td style="background-color:red"><%=list.get(i).get("boardNo") %></td>
			 	<td><%=list.get(i).get("boarTitle") %></td>
			 	<td><%=list.get(i).get("userId") %></td>
			 	<td><%=list.get(i).get("nowpt")%> / <%=list.get(i).get("person") %></td>
			 	<td data-timeleft="<%=timeM - nowM%>">
			 		<%=hour==0?"":hour + " : " %><%=min==0?"":min+" : " %><%=sec %>
			 	</td>
			 </tr>
		 <%}else{ %>
		 <tr>
			 	<td><%=list.get(i).get("boardNo") %></td>
			 	<td><%=list.get(i).get("boarTitle") %></td>
			 	<td><%=list.get(i).get("userId") %></td>
			 	<td><%=list.get(i).get("nowpt")%> / <%=list.get(i).get("person") %></td>
			 	<td data-timeleft="<%=timeM - nowM%>">
			 		<%=hour==0?"":hour + " : " %><%=min==0?"":min+" : " %><%=sec %>
			 	</td>
			 </tr>
		 <%} %>
		<%} %>
		</tbody>
	</table>
	<%} else { %>
		<h1>아무 글 도 없습니다.</h1>
	<%} %> 
	
	<script>
			$("#example").on("click", "tbody tr", function(){
				console.log(this);
				location.href="<%=request.getContextPath() %>" + "/foodtogetherdetail.bo?bno=" + $(this).children().eq(0).text();
			});
			
			function updateElements(){
		        $.each($("[data-timeleft]"), function(){
		            const timeLeft = parseInt($(this)[0].dataset.timeleft);
		         
		            
		
		            if(timeLeft > 1){
		                $(this)[0].dataset.timeleft = timeLeft - 1;
		                let hour = parseInt($(this)[0].dataset.timeleft/3600);		             
		                let min = parseInt(($(this)[0].dataset.timeleft%3600)/60);
		                let sec = parseInt($(this)[0].dataset.timeleft%3600)%60;
			                $(this).text(((hour==0)?"":hour+" : ") + ((min==0)?"":min + " : ") + sec); 		                	
		            }else{
		                // $(this).text("---");
		                // console.log($(this).parents("tr").children().eq(0).text()); // 0초 된거
		                // 새로운 iframe을 만들고 거기서 지속적으로 새로고침을 시키며 데이터만 이쪽으로 넘겨주면 깜빡거림을 아예 없앨 수 있을 꺼 같다.
		                $.ajax({
		                	url : "deleteTogether.bo",
		                	type : "get",
		                	data : {
		                		bno : $(this).parents("tr").children().eq(0).text()
		                	},
		                	success : function(data){
		                		location.href="<%=request.getContextPath()%>/foodTogether.bo";
		                	},
		                	error : function(){
		                		console.log("ajax error");
		                	}
		                })
		                
		            }
		        })
		} 
			setInterval(updateElements, 1000);
	
// 	function updateElements(){
// 		$.ajax({
// 			url : "test.bo",
// 			type : "get",
// 			success : function(){
// 				console.log("ajax success");
// 				var str = "";
// 				str =
<%-- 				<%if(!list.isEmpty()) {%> --%>
// 				"<table id='example'>"+
// 					"<thead>"+
// 						"<tr>"+
// 							"<th>#</th>"+
// 							"<th>제목</th>"+
// 							"<th>작성자</th>"+
// 							"<th>인원</th>"+
// 							"<th>남은시간</th>"+
// 						"</tr>"+
// 					"</thead>"+
// 					"<tbody>"+
<%-- 					<%for(int i = 0; i < list.size(); i++){%> --%>
<%-- 					<% --%>
// 						String[] timearr = list.get(i).get("endTime").split(":");
// 						int timeM = Integer.parseInt(timearr[0])*3600 + Integer.parseInt(timearr[1])*60; // 종료 시간 초 단위
// 						Date d = new Date();
// 						SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
// 						String now = sdf.format(d);
// 						String[] noewTime = now.split(":");
// 						int nowM = Integer.parseInt(noewTime[0])*3600 + Integer.parseInt(noewTime[1])*60 + Integer.parseInt(noewTime[2]);
// 						int showtime = timeM - nowM;
// 						int hour = showtime/3600;
// 						int min = (showtime%3600)/60;
// 						int sec = (showtime%3600)%60;
// 						int ggg = timeM - nowM;
						
// 						// 서버가 종료되면 시간이 가지 않는다.
<%-- 						%>  --%>
<%-- 						<%if(check == Integer.parseInt(list.get(i).get("boardNo"))){ %>  --%>
// 						 "<tr>"+
<%-- 						 	"<td style=\"background-color:red\"><%=list.get(i).get("boardNo") %></td>"+  --%>
<%-- 							 	"<td><%=list.get(i).get("boarTitle") %></td>"+  --%>
<%-- 							 	"<td><%=list.get(i).get("userId") %></td>"+  --%>
<%-- 							 	"<td><%=list.get(i).get("nowpt")%> / <%=list.get(i).get("person") %></td>"+  --%>
<%-- 							 	"<td data-timeleft='<%=ggg%>'><%=hour==0?"":hour + " : " %><%=min==0?"":min+" : " %><%=sec %></td>"+  --%>
// 						 "</tr>"+
<%-- 					 <%}else{ %>  --%>
// 					 "<tr>"+
<%-- 						 	"<td><%=list.get(i).get("boardNo") %></td>"+ --%>
<%-- 						 	"<td><%=list.get(i).get("boarTitle") %></td>"+ --%>
<%-- 						 	"<td><%=list.get(i).get("userId") %></td>"+ --%>
<%-- 						 	"<td><%=list.get(i).get("nowpt")%> / <%=list.get(i).get("person") %></td>"+ --%>
<%-- 						 	"<td data-timeleft='<%=ggg%>'><%=hour==0?"":hour + " : " %><%=min==0?"":min+" : " %><%=sec %></td>"+ --%>
// 						 "</tr>"+
<%-- 					 <%} %> --%>
<%-- 					<%} %> --%>
// 					"</tbody>"+
// 				"</table>"
<%-- 				<%} else { %>  --%>
// 					+"<h1>아무 글 도 없습니다.</h1>"
<%-- 				<%} %> ; --%>
// 				$("#testiframe").html(str);
				
				
// 				console.log("ajax success last");
// 			},
// 			error : function(){
// 				console.log("ajax error");
// 			}
// 		})
		
// 	}
// 		setInterval(function(){
// 			$.ajax({
// 				url : "foodTogether.bo",
// 				type : "get",
// 				success : function(){
// 					console.log("ajax success");
// 					var str = "";
// 					str =
<%-- 					<%if(!list.isEmpty()) {%> --%>
// 					"<table id='example'>"+
// 						"<thead>"+
// 							"<tr>"+
// 								"<th>#</th>"+
// 								"<th>제목</th>"+
// 								"<th>작성자</th>"+
// 								"<th>인원</th>"+
// 								"<th>남은시간</th>"+
// 							"</tr>"+
// 						"</thead>"+
// 						"<tbody>"+
<%-- 						<%for(int i = 0; i < list.size(); i++){%> --%>
<%-- 						<% --%>
// 							System.out.println("list" + list);
// 							String[] timearr = list.get(i).get("endTime").split(":");
// 							int timeM = Integer.parseInt(timearr[0])*3600 + Integer.parseInt(timearr[1])*60; // 종료 시간 초 단위
// 							Date d = new Date();
// 							SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
// 							String now = sdf.format(d);
// 							String[] noewTime = now.split(":");
// 							int nowM = Integer.parseInt(noewTime[0])*3600 + Integer.parseInt(noewTime[1])*60 + Integer.parseInt(noewTime[2]);
// 							int showtime = timeM - nowM;
// 							int hour = showtime/3600;
// 							int min = (showtime%3600)/60;
// 							int sec = (showtime%3600)%60;
// 							int ggg = timeM - nowM;
// 							System.out.println(ggg);
// 							System.out.println(check);
// 							System.out.println("hour " + hour);
// 							System.out.println("min " + min);
// 							System.out.println("sec " + sec);
							
// 							// 서버가 종료되면 시간이 가지 않는다.
<%-- 							%>  --%>
<%-- 							<%if(check == Integer.parseInt(list.get(i).get("boardNo"))){ System.out.println("1번째 조건");%>  --%>
// 							 "<tr>"+
<%-- 							 	"<td style=\"background-color:red\"><%=list.get(i).get("boardNo") %></td>"+  --%>
<%-- 								 	"<td><%=list.get(i).get("boarTitle") %></td>"+  --%>
<%-- 								 	"<td><%=list.get(i).get("userId") %></td>"+  --%>
<%-- 								 	"<td><%=list.get(i).get("nowpt")%> / <%=list.get(i).get("person") %></td>"+  --%>
<%-- <%-- 								 	"<td data-timeleft='<%=ggg%>'><%=hour==0?"":hour + " : " %><%=min==0?"":min+" : " %><%=sec %></td>"+  --%>
<%-- 								 	"<td data-timeleft='<%=ggg%>'><%=hour %><%=min %><%=sec %></td>"+  --%>
// 							 "</tr>"+
<%-- 						 <%}else{ System.out.println("2번째 조건"); %>  --%>
// 						 "<tr>"+
<%-- 							 	"<td><%=list.get(i).get("boardNo") %></td>"+ --%>
<%-- 							 	"<td><%=list.get(i).get("boarTitle") %></td>"+ --%>
<%-- 							 	"<td><%=list.get(i).get("userId") %></td>"+ --%>
<%-- 							 	"<td><%=list.get(i).get("nowpt")%> / <%=list.get(i).get("person") %></td>"+ --%>
<%-- 							 	"<td data-timeleft='<%=ggg%>'><%=hour==0?"":hour + " : " %><%=min==0?"":min+" : " %><%=sec %></td>"+ --%>
// 							 "</tr>"+
<%-- 						 <%} %> --%>
<%-- 						<%} %> --%>
// 						"</tbody>"+
// 					"</table>"
<%-- 					<%} else { System.out.println("None 조건"); %>  --%>
// 						+"<h1>아무 글 도 없습니다.</h1>"
<%-- 					<%} %> ; --%>
// 					$("#testiframe").html(str);
// 				},
// 				error : function(){
// 					console.log("ajax error");
// 				}
// 			});
// 		}, 1000);
	</script>
  	

 
</body>
</html>