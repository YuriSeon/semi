 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*, com.kh.board.model.vo.Board"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Break Time[Food_Rank]</title>
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
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	int maxpage = 0;
%>
<body>
	<div style="text-align:center;">	
		<a href="<%=request.getContextPath()%>/rankInsert.bo" class="btn btn-primary">글작성</a>
		<a href="<%=request.getContextPath()%>/foodmain.bo" class="btn btn-warning">홈으로 이동</a>
	</div>
	<br><br>
	<%if(!list.isEmpty()){ %>
	<%
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
	<table id="example" class="table table-striped table-bordered" cellspacing="0" align="center"  style="text-align: center; width:80%">
		<thead>
			<tr>
				<th>#</th>
				<th>제목</th>
				<th>메뉴</th>
				<th>추천</th>
				<th>작성날짜</th>
				<th>작성자</th>
				<th>맛등급</th>
			</tr>
		</thead>
		<tbody>
		<%try{ %>
		<%for(int i = 7 *(start-1); i < 7 *(start); i++){ %>
		<%if(i < list.size()){ %>
			 <tr>
			 	<td><%=((Board)list.get(i)).getBoardNo() %></td>
			 	<td><%=((Board)list.get(i)).getBoardTitle() %></td>
			 	<td><%=((Board)list.get(i)).getBoardContent() %></td>
			 	<td><%=((Board)list.get(i)).getGood() %></td>
			 	<td><%=((Board)list.get(i)).getCreateDate() %></td>
			 	<td><%=((Board)list.get(i)).getBoardWriter() %></td>
			 	<td><%=((Board)list.get(i)).getPointName() %></td>
			 </tr>
		<%} else{ throw new Exception();}%>
		<%} %>
		<%}catch(Exception e){ }%>
		</tbody>
	</table>
		<% }else{ %>
		<h1>아무 글도 없습니다.</h1>
	<%} %>
	
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
			$("#example tbody tr").click(function(){
				location.href="<%=request.getContextPath() %>/foodRankingDetail.bo?bno="+$(this).children().eq(0).text();
			});
			
			$(".hibtn").on("click",function(){
				location.href="<%=request.getContextPath() %>/foodRanking.bo?cp="+$(this).attr("id");
			});
			
			
	</script>
</body>

</html>