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
		.bam_head{
            text-align: center;
            font-size: 25px;
            font-weight: bold;
            margin-top: 100px;
            margin-bottom: 20px;
        }
		.board-list{			
			border-top: 3px solid rgb(186, 229, 244);
			width: 75%;			
			margin: auto;
			text-align: center;
			height: 100%;
			
		}
		
		.board-list-pre{	
			
			width: 65%;
			border-bottom: 2px solid gainsboro;
			border-left:2px solid gainsboro;
			border-right:2px solid gainsboro;
			margin: auto;
			height: 10%;
			display: inline-block;			
		}
		.board-list-pre:hover{
			background-color:rgb(243, 241, 241); 
		}
		
		.title{			
			height: 60%;						
		}
		.title>h3,p{
			margin-left: 2%;
			margin-top: 1%;
			margin-bottom: 2%;			
		}
		.title>a{
			
			text-decoration: none;
			color: black;
			text-align: center;
			font-weight: 800;
			font-size: 20px;
			text-overflow: ellipsis;
			white-space : nowrap;
			overflow : hidden;
			
		}
		.title>h3{
			font-weight: 800;
		}
		
		#content{
			font-weight: 500;
			font-size : 15;
			width:70%;
			color:black;
	        text-overflow: ellipsis;
			overflow: hidden;
	        display: -webkit-box;
	        -webkit-line-clamp: 1;
	        -webkit-box-orient: vertical;	
		}
		.sub{			
			height: 30%;
			
			width: 100%;
			float: left;
			
			
			
		}
		.sub>p{
			text-align: left;
			margin-left: 4%;
			width: 20%;
		}
		.sub2{			
			
			display: inline-block;
			width: 100%;						
		}
		.sub2>a{
			color: black;
			text-decoration: none;
			margin-left: 2%
		}
		.sub3{			
			
			text-align:right;
			
		}
		.sub3>a{
			text-decoration: none;
			color: black;
			font-size: 120%;

		}
		.category a{
			text-decoration: none;
			color: black;
			margin: 2%;
		}
		.name {
			margin-left: 2%;
			margin-top: 1%;
			margin-bottom: 1%;
			float: left;
		}
		.writebtn{
			width:50%
		}
</style>
</head>
<body>
	<%@ include file ="../common/menubar.jsp"%> 
	  
	<div class="bam_head" align="center">대나무 숲</div>
	<br>
	<div class="layout">
		<div class="board-list">
		<br>
			<%if(list.isEmpty()){ %>
				<h3>조회된 글이 없음</h3>
			<%}else{ %>
				<%for(Board b : list){ %>
				<div class="board-list-pre">
					<div class="title" align="center">
						<span class="category">
							<%if(b.getBoardType()==null){ %> <!-- 카테고리 -->
								<!-- 공지사항 이라면 -->
								<a href="<%=contextPath%>/bamdetail.bo?bno=<%=b.getBoardNo()%>"><img style="width:25px" src="resources/bam_files/메가폰.png">공지</a>
							<%}else{ %>
								<a href="<%=contextPath%>/bamdetail.bo?bno=<%=b.getBoardNo()%>"><%=b.getBoardType() %></a>
							<%} %>
						</span>
							<%if(b.getTypeNo()==1||b.getReplyCount()==0){ %> <!-- 제목+댓글수 -->
								<!-- 공지사항 이거나 댓글이 없다면 -->
								<a href="<%=contextPath%>/bamdetail.bo?bno=<%=b.getBoardNo()%>"><%=b.getBoardTitle() %></a> 
							<%}else{ %>
								<a href="<%=contextPath%>/bamdetail.bo?bno=<%=b.getBoardNo()%>"><%=b.getBoardTitle() %>(<%=b.getReplyCount() %>)</a>
							<%} %>
							<a id="content" href="<%=contextPath%>/bamdetail.bo?bno=<%=b.getBoardNo()%>"><%=b.getBoardContent() %></a>
					</div>
					<div class="sub">
						<%if(b.getTypeNo()==1&&b.getBoardWriter().equals("1")){ %> <!-- 작성자 -->
							<p class="name">관리자</p>										
						<%}else{ %>
							<p class="name">익명</p>
						<%} %>					
						<div class="sub3">
							<!-- 작성일 -->
							<a href="<%=contextPath%>/bamdetail.bo?bno=<%=b.getBoardNo()%>"><%=b.getCreateDate() %></a>
						</div>
						<div class="sub2">
							<!-- 조회수, 추천수, 사진있는 글인지 -->
							<a href="<%=contextPath%>/bamdetail.bo?bno=<%=b.getBoardNo()%>"><i class="fa-regular fa-eye"><%=b.getCount() %></i></a>
							<a href="<%=contextPath%>/bamdetail.bo?bno=<%=b.getBoardNo()%>"><i class="fa-regular fa-thumbs-up"><%=b.getGood() %></i></a>
							<a href="<%=contextPath%>/bamdetail.bo?bno=<%=b.getBoardNo()%>">
								<%if(b.getFileNo()!=null){ %>
								<i class="fa-regular fa-image"></i>
								<%}else{%>
								<i class="fa-regular fa-comment"></i>
								<%} %>
							</a>
						</div>
					</div>
				</div>	
			 	<%} %>
			<%} %>			 					
		</div>
	</div>
    <br>
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
			<div class="writebtn" align="right">
				<a href="<%=contextPath%>/baminsert.bo" class="btn btn-info">글작성</a>
			</div>
	</div>
	<br>
	<div align="center">
		<form action="<%=contextPath %>/bamlist.bo">
			<input type="hidden" name="currentPage" value="1">
			<select name="searchCategory">
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
		    <input type="search" name="keyword" size=45 placeholder="검색하실 제목">
		    <button type="submit" class="btn btn-info">검색</button>
		</form>
	</div>
	<br><br><br>
</body>
</html>