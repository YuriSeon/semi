<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Break Time[Food_TO]</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.js"integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="crossorigin="anonymous"></script>
<style>
        body {margin:2em;}

        td:last-child {text-align:center;}
        
        tbody tr {
        	cursor: pointer;
        }
</style>
</head>
<body>
<%
	ArrayList<HashMap<String, String>> list = (ArrayList<HashMap<String, String>>)request.getAttribute("list");
// 	// list에는 현재 밥 같이 먹기 게시판의 내용이 다 들어있다.
  	int check = (int)request.getAttribute("check");
	int maxpage = 0;
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
     <div style="text-align:center;">     
	  	<a  class="btn btn-warning" href="<%=contextPath %>/foodmain.bo">메인으로가기</a>
	  	<a class="btn btn-primary" href="<%=contextPath %>/foodTogetherInsert.bo">글쓰기</a>
     </div>
     <br><br>
<%--   	<iframe name="hiddeniframe" style="display:none;" src="<%=contextPath %>/views/food/test.jsp"></iframe> --%>
  	

<!--   	<div id="testiframe"></div> -->
  	
  	
  <%if(!list.isEmpty()) {%>
	<table id="example" class="table table-striped table-bordered" cellspacing="0" align="center"  style="text-align: center; width:80%; border-collapse: collapse;" >
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
		
		
		<%
			// 서버가 종료되면 시간이 가지 않는다.
			
			int totalboard = list.size();
			maxpage = totalboard/7;
			int maxpage2 = totalboard%7;
			if(maxpage2 != 0){
				maxpage = maxpage +1;
			}
			int start = (int)request.getAttribute("cp");
			if(start == 0){
				start = 1;
			}
			
		%>
		<%try{ %>
		<%for(int i = 7 *(start-1); i < 7 *(start); i++){%>
		<%if(i < list.size()){ %>
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
		%>
		<%if(check == Integer.parseInt(list.get(i).get("boardNo"))){ %>
			 <tr style="background-color:pink">
			 	<td><%=list.get(i).get("boardNo") %></td>
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
		 <%} else{ throw new Exception();}%>
		 
		<%} %>
		<%}catch(Exception e){ }%>
		</tbody>
	</table>
	<%} else { %>
		<h1>아무 글 도 없습니다.</h1>
	<%} %> 
	
	<!-- 페이징 버튼 -->
	<div id="bbb" style="text-align:center;">
	<%if(maxpage > 1) {%>
	<%for (int b = 0; b < maxpage; b++){ %>
		<%if((int)request.getAttribute("cp") == 0 && b+1 == 1){ %>
				 <button class="hibtn btn btn-danger" id=<%=b+1 %>><%=b+1 %></button>
		<%} else{ %>
		<%if((int)request.getAttribute("cp") == b+1){ %>
		 	<button class="hibtn btn btn-danger" id=<%=b+1 %>><%=b+1 %></button>
		 <%} else { %>
				 <button class="hibtn btn" id=<%=b+1 %>><%=b+1 %></button>
		 <%} %>
		 <%} %>
	<%} %>
	<%} %>
	</div>
	
	<script>
	$(".hibtn").on("click",function(){
		location.href="<%=request.getContextPath() %>/foodTogether.bo?cp="+$(this).attr("id");
	});
	
	
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

	</script>
  	

 
</body>
</html>