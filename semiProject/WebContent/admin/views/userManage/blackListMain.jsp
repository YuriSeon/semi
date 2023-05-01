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
<style>
	select, input{
		height: 30px;
	}
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
	<div id="wrapper"><br>
	<div id="bb">
        <form action="<%=contextPath %>/main.bl" method="post">
            <select id="selectBox" name="search_box" >
                <option value="id">ID</option>
                <option value="name">Name</option>
                <option id="status" value="status">ReJoin</option>
            </select>
            <script>
            		
            	if($("#selectBox option:selected").val == 'status'){
            		$("search").attr()
            	}
            </script>
            <input type="hidden" name="currentPage" value="1">
            <input type="search" id="search" name="input" placeholder="검색어를 입력하세요">
            <button type="submit" class="custom-btn btn-10">검색</button>
        </form>
    </div>
    <br>
    <table id="tab">
        <thead>
	            <tr>
	                <th>NO</th>
	                <th>ID</th>
	                <th>Name</th>
	                <th>Phone</th>
	                <th>Email</th>
	                <th>Person Num</th>
	                <th>Board Report</th>
	                <th>DM Block</th>
	                <th>False Report</th>
	                <th>Filtering Count</th>
	                <th>ReJoin</th>
	            </tr>
        </thead>
         <tbody>
        	<%if(list!= null && list.isEmpty()){ %>
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
    </div>
    <!-- 페이징처리 하기 -->
    <div id="page">
    <% if(pi.getMaxPage() > 1) { %>
		<% if(pi.getCurrentPage()==1) {%>
			<button type="button" disabled>&lt;</button>
		<% } else { %>
			<button type="button" onclick="location.href='<%=contextPath%>/main.bl?currentPage=<%=pi.getCurrentPage()-1%>';">&lt;</button>
		<% } %>
		<% for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++) { %>
			<%if(i==pi.getCurrentPage()) {%>
				<button type="button" disabled><%=pi.getCurrentPage()%></button>
			<% } else {%>
				<button type="button" onclick="location.href='<%=contextPath%>/main.bl?currentPage=<%=i%>';"><%=i %></button>
			<% } %>
		<% } %>
		<% if(pi.getMaxPage()!=pi.getCurrentPage()) { %>
			<button type="button" onclick="location.href='<%=contextPath%>/main.bl?currentPage=<%=pi.getCurrentPage()+1%>';">&gt;</button>
		<% } else { %>
			<button type="button" disabled>&gt;</button>
		<% } %> 
	<% } %>
	</div>

</body>
</html>