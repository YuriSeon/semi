<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>

<!-- Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="alert alert-success" style="text-align:center;">
	<h1><strong>이미 작성된 글이 있습니다.</strong></h1>
	<button type="button" class="btn btn-success" onclick="location.href='<%=request.getContextPath()%>/foodmain.bo'">Home</button>
<%-- 	<button type="button" class="btn btn-warning" onclick="location.href='<%=request.getContextPath()%>/foodmain.bo'">내가 작성한 글</button> --%>
</div>
</body>
</html>