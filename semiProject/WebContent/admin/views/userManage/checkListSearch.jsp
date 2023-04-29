<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.kh.common.model.vo.PageInfo, com.kh.bMember.model.vo.BMember, java.util.ArrayList"%>
 <%
 	PageInfo pi = (PageInfo)request.getAttribute("pi");
 	ArrayList<BMember> list = (ArrayList<BMember>)request.getAttribute("list");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkList search</title>
</head>
<body>
    <%@include file="../common/menubar.jsp"%>
   <div id="wrapper">
		<div id="bb"><br>
			<form action="<%=contextPath %>/select.ck" method="post">
				<div id="search_div">
					<input type="hidden" name="currentPage" value="1">
					<select id="select" name="select" id="search_select" onchange="selectboxP();">
						<option value="1" selected>ID</option>
						<option value="2">차단 합계</option>
						<option value="3">게시물 필터링 수</option>
					</select>
				</div>
				<div>
					<input type="search" name="search_input" id="search_input" placeholder="검색할 ID를 입력하세요.">
				</div>
					<button type="submit" class="custom-btn btn-10">검색</button>
				</form>
				<button type="button" id="checkL" class="custom-btn btn-11" onclick="location.href='<%=contextPath%>/important.ck?currentPage=1'">★ Check</button>
		</div>

	<%if(!list.isEmpty()) { %>
        
        <p style="text-align: center; font-weight: bold; font-size:large; line-height:100px;">검색하신 결과입니다.</p>
    
    <table id="tab">
		<thead>
			<tr>
				<th>NO</th>
				<th>ID</th>
				<th>NAME</th>
				<th>Block Count</th>
				<th>Filtering Count</th>
				<th>Food point</th>
				<th>Enroll Date</th>
				<th>Update Date</th>
			</tr>
		</thead>
		<tbody>
				<%for(int i=0; i<list.size(); i++) {%>
					<tr>
						<td><%=((BMember)list.get(i)).getUserNo()%></td>
						<td><%=((BMember)list.get(i)).getUserId() %></td>
						<td><%=((BMember)list.get(i)).getUserName() %></td>
						<td><%=((BMember)list.get(i)).getTotalB()%></td>
						<td><%=((BMember)list.get(i)).getTotalF() %></td>
						<td><%=((BMember)list.get(i)).getPoint() %></td>
						<td><%=((BMember)list.get(i)).getCreateDate() %></td>
						<td><%=((BMember)list.get(i)).getModifyDate() %></td>

					</tr>
					<% } %>
		</tbody>
	</table>
    <% } else { %>
        <p style="text-align: center; font-weight: bold; font-size:large; line-height:500px;">검색내역에 일치하는 결과가 없습니다.</p>
    <% } %>
    </div>
	<div>
		<!-- 페이징처리 -->
		<% if(pi.getCurrentPage()==1) {%>
		<button type="button" disabled></button>
		<% } else { %>
		<button type="button"
			onclick="location.href='<%=contextPath%>/select.ck?currentPage=<%=pi.getCurrentPage()-1%>';">&lt;</button>
		<% } %>
		<% for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++) { %>

		<%if(i==pi.getCurrentPage()) {%>
		<button type="button" disabled>i</button>
		<% } else {%>
		<button type="button"
			onclick="location.href='<%=contextPath%>/select.ck?currentPage=<%=i%>';"><%=i %></button>
		<% } %>

		<% } %>

		<% if(pi.getMaxPage()!=pi.getCurrentPage()) { %>
		<button type="button"
			onclick="location.href='<%=contextPath%>/select.ck?currentPage=<%=pi.getCurrentPage()+1%>';">&gt;</button>
		<% } else { %>
		<button type="button" disabled>&gt;</button>
		<% } %>
	</div>

	<script>
    	function selectboxP(){
            if($("#search_select option:selected").val()=="1"){
		        $("#search_input").attr("placeholder","검색할 ID를 입력하세요.");
		    } else {
		        $("#search_input").attr("placeholder","기준치를 입력하세요.");
		    }
       }
    </script>
</body>
</html>