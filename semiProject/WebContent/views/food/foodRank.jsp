<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Break Time[Food_Rank]</title>
</head>
<body>
	<h1>���� ��ŷ</h1>
	<p>���⿡ �۵��� �¸���</p>
	<a href="<%=request.getContextPath()%>/rankChellage.bo">���ۼ�</a>
	
	
	<script>
		document.querySelector("td").addEventLinster("click", function(){
			location.href = "<%=request.getContextPath() %>/foodDtail?bno=1";
			// �۵����� ���� board No �����ϱ� �������.
		});
	</script>
</body>
</html>