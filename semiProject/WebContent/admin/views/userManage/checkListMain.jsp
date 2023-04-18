<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.common.model.vo.PageInfo"%>
 <%
 	PageInfo pi = (PageInfo)request.getAttribute("pi");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>USER CHECKLIST</title>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
    <div>
   		<form>
	        <div id="search_div">
	            <select name="" id="search_select" onchange="selectboxP();">
	                <option value="id" selected>ID</option>
	                <option value="block" >차단 합계</option>
	                <option value="filtering">게시물 필터링 수</option>
	            </select>
	        </div>
	        <div>
	            <input type="search" name="" id="search_input" placeholder="검색할 ID를 입력하세요.">
	        </div>
	        <div>
                <button type="submit">검색</button>
            </div>
        </form>
        <div>
            <button type="button">★ Check</button>
        </div>
    </div>
            <script>
            	function selectboxP(){
            		
            		if($("#search_select option:selected").val()=="id"){
		            	
		                $("#search_input").attr("placeholder","검색할 ID를 입력하세요.");
		                
		            } else {
		            	
		            	$("#search_input").attr("placeholder","기준치를 입력하세요.");
		            	
		            }
            		
            	}
            
            </script>
            <hr>
        <table>
            <tr>
                
            </tr>
        </table>    
    	<div>
    	<!-- 페이징처 -->
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