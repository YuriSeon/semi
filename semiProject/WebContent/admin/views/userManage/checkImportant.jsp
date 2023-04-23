<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.kh.common.model.vo.PageInfo, com.kh.admin.userManage.model.vo.*
            , java.util.ArrayList, com.kh.bMember.model.vo.BMember"%>
<%
    PageInfo pi = (PageInfo)request.getAttribute("pi");
    ArrayList<User> list = (ArrayList<User>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <%@include file="../common/menubar.jsp"%>
    <table border="1">
        <thead>
            <tr>
                <th>회원 번호</th>
                <th>아이디</th>
                <th>이름</th>
                <th>게시글 차단</th>
                <th>DM 차단</th>
                <th>허위 신고</th>
                <th>차단 총 합계</th>
                <th>게시글 필터링</th>
                <th>댓글 필터링</th>
                <th>필터링 총 합계</th>
                <th>경고</th>
                <th>강제 탈퇴</th>
            </tr>
        </thead>
        <tbody>
            <% if(list.isEmpty()) { %>
                <p style="text-align: center; font-weight: bold; font-size:large">체크가 필요한 회원이 없습니다.</p>
            <% } else { %>
                <% for(int i=0; i<list.size(); i++) { %>
                    <tr>
                    	<%if(list.get(i) instanceof BMember) {%>
	                        <td><%=((BMember)list.get(i)).getUserNo() %></td>
	                        <td><%=((BMember)list.get(i)).getUserId() %></td>
	                        <td><%=((BMember)list.get(i)).getUserName() %></td>
                        <% } %>
                        <% i++; %>
                        <%if(list.get(i) instanceof UserCondition) {%>
	                        <td><%=((UserCondition)list.get(i)).getBlockC() %></td>
	                        <td><%=((UserCondition)list.get(i)).getDmBlockC() %></td>
	                        <td><%=((UserCondition)list.get(i)).getFalseBlockC() %></td>
	                        <td><%=((UserCondition)list.get(i)).getTotalB() %></td>
	                        <td><%=((UserCondition)list.get(i)).getBoardFiltering() %></td>
	                        <td><%=((UserCondition)list.get(i)).getReplyFiltering() %></td>
	                        <td><%=((UserCondition)list.get(i)).getTotalF() %></td>
	                        <td>
	                        <%=((UserCondition)list.get(i)).getYellowCard() %>
	                        <button type="button" class="yellow" name="<%= ((UserCondition)list.get(i)).getUserNo()%>">경고</button>
	                        </td>
	                        <% if(((UserCondition)list.get(i)).getYellowCard()==4) { %>
	                        		<td><button class="delete_userNo" name="<%=((UserCondition)list.get(i)).getUserNo()%>">강제탈퇴</button></td>
	                        <% } else { %>
	                       			<td><button class="delete_userNo" name="<%=((UserCondition)list.get(i)).getUserNo()%>" disabled>강제탈퇴</button></td>
	                        <% } %>
                        <% } %>
                    </tr>
                <% } %>
            <% } %>
        </tbody>
    </table>
    <script>
    	$(".yellow").click(function(){
    		var userNo = $(this).attr("name");
    		$.jajx(){
    			url : "important.ck",
    			data : { userNo = userNo },
    			type : "post",
    			success : function(result){
    				if(result>0){
	    				alert("전송 완료");
    				} else {
    					alert("전송 실패");
    				}
    			},
    			error : function(){
    				alert("전송 오류 확인 필요");
    			},
    			complete : function(){
    				console.log("통신은 됨");
    			}
    		}
    	});
    
    
        $(".delete_userNo").click(function(){
            if(confirm("$(this).attr('name')번 회원과 작별인사 하시겠습니까?")){
                location.href="<%=contextPath %>/userDelete.um?userNo=" + $(this).attr("name");
            } else {
                alert("탈퇴시키기를 취소하셨습니다.");
            }
        });
        
    </script>
</body>
</html>