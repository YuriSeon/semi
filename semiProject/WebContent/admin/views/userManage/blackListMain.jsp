<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.kh.admin.userManage.model.vo.BlackList, com.kh.common.model.vo.PageInfo"%>
 <% 
 	ArrayList<BlackList> list = (ArrayList<BlackList>)request.getAttribute("list");
 	PageInfo pi = (PageInfo)request.getAttribute("pi");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BlackListMain</title>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<div id="search_div">
        <form action="<%=contextPath %>/main.bl" method="post">
            <select name="search_box" >
                <option value="USERID">ID</option>
                <option value="USERNAME">NAME</option>
                <option value="STATUS">재가입시도</option>
            </select>
            <input type="hidden" name="currentPage" value="1">
            <input type="search" name="input">
            <button type="submit">검색</button>
        </form>
    </div>
	<!-- 나중에 시간 되면 selectbox 선택되면 해당 선택내역으로 order by 비동기통신으로 해보기 onchange -->    
    <table id="list_table" border="1">
        <thead>
	            <tr>
	                <th>회원번호</th>
	                <th>아이디</th>
	                <th>이름</th>
	                <th>휴대폰</th>
	                <th>E메일</th>
	                <th>주민번호</th>
	                <th>게시물신고횟수</th>
	                <th>DM차단횟수</th>
	                <th>허위신고횟수</th>
	                <th>필터링당한횟수</th>
	                <th>재가입시도여부</th>
	            </tr>
        </thead>
         <tbody>
        	<%if(list.isEmpty()){ %>
        	
	            <tr>
	                <th colspan="11" style="text-align: center; font-size: 30px;">강제 탈퇴 회원 목록이 없습니다</th>
	            </tr>
	            
            <%} else { %>
            
	            <%for(BlackList b : list) { %>
	            
		            <tr>
		                <td><%=b.getUserNo() %></td>
		                <td><%=b.getUserId() %></td>
		                <td><%=b.getUserName() %></td>
		                <td><%=b.getPhone() %></td>
		                <td><%=b.getEmail() %></td>
		                <td><%=b.getSsn() %></td>
		                <td><%=b.getBlockC() %></td>
		                <td><%=b.getDmBlockC() %></td>
		                <td><%=b.getFalseBlockC() %></td>
		                <td><%=b.getFiltering() %></td>
		                <td>
		                <%if(b.getReEnroll().equals("KA")) { %>
		                	O	
		                <% } else { %>
		                	X
		                <% } %>
		                </td>
		            </tr>
		            
	            <% } %>
	            
            <% } %>
            
         </tbody>
    </table>
    <!-- 페이징처리 하기 -->
    <div id="page">
	<% if(pi.getCurrentPage()==1) {%>
		<button type="button" disabled></button>
	<% } else { %>
		<button type="button" onclick="location.href='<%=contextPath%>/main/bl?currentPage=<%=pi.getCurrentPage()-1%>';">&lt;</button>
	<% } %>
	<% for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++) { %>
		
		<%if(i==pi.getCurrentPage()) {%>
			<button type="button" disabled>i</button>
		<% } else {%>
			<button type="button" onclick="location.href='<%=contextPath%>/main/bl?currentPage=<%=i%>';"><%=i %></button>
		<% } %>
		
	<% } %>
	
	<% if(pi.getMaxPage()!=pi.getCurrentPage()) { %>
			<button type="button" onclick="location.href='<%=contextPath%>/main/bl?currentPage=<%=pi.getCurrentPage()+1%>';">&gt;</button>
	<% } else { %>
		<button type="button" disabled>&gt;</button>
	<% } %> 
	</div>

</body>
</html>