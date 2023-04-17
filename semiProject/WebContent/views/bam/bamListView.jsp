<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,com.kh.board.model.vo.Board,com.kh.common.model.vo.PageInfo"%>
<%
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div align="center">
		<a href="<%=request.getContextPath() %>/baminsert.bo" class="btn btn-info">글작성</a>
	</div>
	
	<table border="1">
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
        </tbody>
    </table>
    <div align="center" class="paging-area">
    	<%if(pi.getCurrentPage()!= 1){ %>
				<button onclick="location.href='<%=request.getContextPath()%>/bamlist.bo?currentPage=<%=pi.getCurrentPage()-1%>'">&lt;</button>
		<%} %>
        <%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++ ){ %>
				<!-- 내가 보고있는 페이지 버튼은 비활성화 하기  -->
				<%if(i != pi.getCurrentPage()){ %>
					<button onclick="location.href='<%=request.getContextPath()%>/bamlist.bo?currentPage=<%=i%>';"><%=i %></button>
				<%}else{ %> <!-- 내가 보고있는 페이지와 페이징바 버튼의 수가 같다면 i와 currentPage -->
					<button disabled><%=i %></button>
				<%} %>
			<%} %>
			
			<%if(pi.getCurrentPage() != pi.getMaxPage()){ %>
				<button onclick="location.href='<%=request.getContextPath()%>/bamlist.bo?currentPage=<%=pi.getCurrentPage()+1%>'">&gt;</button>
			<%} %>
		</div>
    </div>
</body>
</html>