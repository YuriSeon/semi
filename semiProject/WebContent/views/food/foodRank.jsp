<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Break Time[Food_Rank]</title>
</head>
<body>
	<h1>맛집 랭킹</h1>
	<p>여기에 글들이 좌르륵</p>
	<a href="<%=request.getContextPath()%>/rankChellage.bo">글작성</a>
	
	
	<script>
		document.querySelector("td").addEventLinster("click", function(){
			location.href = "<%=request.getContextPath() %>/foodDtail?bno=1";
			// 글들한테 각자 board No 있으니깐 상관없다.
		});
	</script>
</body>
</html>