<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.kh.board.model.vo.*,com.kh.common.model.vo.PageInfo"%>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	
%>
<!DOCTYPE html>
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style >
	.bam-area>thead th{
		border:1px solid black;
	}
	.bam-area>tbody td{
		border:1px solid black;
	}
</style>
</head>
<body>
	  <%@ include file ="../common/menubar.jsp"%> 
	  
	<div align="center">
		<a href="<%=contextPath%>/baminsert.bo" class="btn btn-info">글작성</a>
	</div>
	<div align="center">
	<table border="1" style="border:1px solid black;" class="bam-area">
        <thead>
            <tr>
                <th width="50">글번호</th>
                <th width="50">카테고리</th>
                <th width="50">사진여부</th>
                <th width="100">작성자</th>
                <th width="300">제목</th>
                <th width="100">작성일</th>
                <th width="50">조회수</th>
                <th width="50">추천수</th>
            </tr>	
        </thead>
        <tbody>
		<%if(list.isEmpty()){ %>
			<tr>
				<td colspan="6">조회된 게시글이 없습니다.</td>
			</tr>
		<%}else{ %>
			<%for(Board b : list){ %>
				
		            <tr>
		                <td><%=b.getBoardNo() %></td>
		                <td><%=b.getBoardType() %></td>
		                <td>사진여부</td>
		                <td>익명(사진)</td>
		                <td><%=b.getBoardTitle() %></td>
		                <td><%=b.getCreateDate() %></td>
		                <td><%=b.getCount() %></td>
		                <td><%=b.getGood() %></td>
		            </tr>
	            
	         <%} %>
         <%} %>
        </tbody>
    </table>
	</div>
    <script >
    	$(function(){
    		
	    	$(".bam-area>tbody>tr").click(function(){
	    		var bno = $(this).children().eq(0).text();
	    		console.log(bno);
	            location.href="<%=contextPath%>/bamdetail.bo?bno="+bno;
	    	});
    	});
    </script>
    
    <div align="center" class="paging-area">
    	<%if(pi.getCurrentPage()!= 1){ %>
				<button onclick="location.href='<%=contextPath%>/bamlist.bo?currentPage=<%=pi.getCurrentPage()-1%>'">&lt;</button>
		<%} %>
        <%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++ ){ %>
				<!-- 내가 보고있는 페이지 버튼은 비활성화 하기  -->
				<%if(i != pi.getCurrentPage()){ %>
					<button onclick="location.href='<%=contextPath%>/bamlist.bo?currentPage=<%=i%>';"><%=i %></button>
				<%}else{ %> <!-- 내가 보고있는 페이지와 페이징바 버튼의 수가 같다면 i와 currentPage -->
					<button disabled><%=i %></button>
				<%} %>
			<%} %>
			
			<%if(pi.getCurrentPage() != pi.getMaxPage()){ %>
				<button onclick="location.href='<%=contextPath%>/bamlist.bo?currentPage=<%=pi.getCurrentPage()+1%>'">&gt;</button>
			<%} %>
	</div>
    
</body>
</html>