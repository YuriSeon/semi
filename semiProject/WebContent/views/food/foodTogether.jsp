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

 -->
	<%@ include file="../common/menubar.jsp" %>
    <h1>밥 같이 먹을 사람</h1>
    <br><br>
    <!-- 
    	들어오면 현재 게시물들을 보여준다.
     -->
  	<a href="<%=contextPath %>/foodmain.bo">메인으로가기</a>
  	<a href="<%=contextPath %>/foodTogetherInsert.bo">글쓰기</a>
  	

 
</body>
</html>