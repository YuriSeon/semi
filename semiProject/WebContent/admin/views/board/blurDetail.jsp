<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.*, java.util.ArrayList"%>
<%
    Board b = (Board)request.getAttribute("b");
	Attachment a = (Attachment)request.getAttribute("a");
	ArrayList<Reply> rList = (ArrayList<Reply>)request.getAttribute("rList");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<div id="wrapper">
		<div id="bb">
			
			<button type="button" class="custom-btn btn-3" onclick="boardActive();">활성화</button>
			<button type="button" class="custom-btn btn-5" onclick="boardDelete();">삭제</button>
		</div>
	</div>
	
	<script>
		var bno = <%=b.getBoardNo()%>;
	
		function boardActive(){
			if(confirm("게시물을 활성화시키시겠습니까?")){
				location.href="<%=contextPath%>/active.abo?bno="+bno;
			} else {
				alert("취소하셨습니다.");
			}
		}
		
		function boardDelete(){
			if(confirm("게시물을 삭제하시겠습니까?")){
				location.href="<%=contextPath %>/blurDelete.abo?bno="+bno;
			} else {
				alert("취소하셨습니다.");
			}
		}
	</script>
</body>
</html>