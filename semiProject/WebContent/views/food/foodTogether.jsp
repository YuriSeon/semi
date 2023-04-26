<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Break Time[Food_TO]</title>

</head>
<body>
<%
	ArrayList<HashMap<String, String>> list = (ArrayList<HashMap<String, String>>)request.getAttribute("list");
	// list에는 현재 밥 같이 먹기 게시판의 내용이 다 들어있다.
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
			 <tr>
			 	<td><%=list.get(i).get("boardNo") %></td>
			 	<td><%=list.get(i).get("boarTitle") %></td>
			 	<td><%=list.get(i).get("userId") %></td>
			 	<td><%=list.get(i).get("person") %></td>
			 	<td><%=list.get(i).get("endTime") %></td>
			 </tr>
		<%} %>
		</tbody>
	</table>
	<%} else { %>
		<h1>아무 글 도 없습니다.</h1>
	<%} %>
	
		<script>
			$("#example tbody tr").click(function(){
				location.href="<%=request.getContextPath() %>" + "/foodtogetherdetail.bo?bno=" + $(this).children().eq(0).text();
			});
	</script>
  	

 
</body>
</html>