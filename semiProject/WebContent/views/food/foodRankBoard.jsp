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
%>
<body>
	<a href="<%=request.getContextPath()%>/rankInsert.bo" class="btn btn-primary">글작성</a>
	<a href="<%=request.getContextPath()%>/foodmain.bo" class="btn btn-primary">뒤로가기</a>
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
		<%if(!list.isEmpty()){ %>
		<%for(Board b : list){ %>
			 <tr>
			 	<td><%=b.getBoardNo() %></td>
			 	<td><%=b.getBoardTitle() %></td>
			 	<td><%=b.getBoardContent() %></td>
			 	<td><%=b.getGood() %></td>
			 	<td><%=b.getCreateDate() %></td>
			 	<td><%=b.getBoardWriter() %></td>
			 	<td><%=b.getPointName() %></td>
			 </tr>
		<%}} %>
		</tbody>
	</table>
	<script>
			$("#example tbody tr").click(function(){
				location.href="<%=request.getContextPath() %>/foodRankingDetail.bo?bno="+$(this).children().eq(0).text();
			});
	</script>
</body>

</html>