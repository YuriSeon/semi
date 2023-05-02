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
<style>
	#bb{
		text-align: center;
		padding-top : 10px;
	}
	.btn-11 {
		width: 85px;
  		height: 30px;
	}
	tbody>tr:hover{
		background-color: rgb(241, 241, 241);
		cursor: pointer;
	}
	.btn-8{
		text-align: center;
	}
	
</style>
</head>
<body>
    <%@include file="../common/menubar.jsp"%>
	<h2>상태 확인 필요 회원 </h2>
	<br>
    <div id="wrapper">
    	<div id="bb">
			<% if(list!=null && list.isEmpty()) { %>
				<p style="text-align: center; font-weight: bold; font-size:X-large; line-height:450px">
					관리가 필요한 회원이 없습니다.
				</p>
				<button class='custom-btn btn-8' onclick="location.href='<%=contextPath%>/main.admin';">메인으로</button>
			<% } else { %>
			<br><br><br>
			<table id="tab">
				<thead>
					<tr>
						<th>NO</th>
						<th>ID</th>
						<th>Name</th>
						<th>Board Report</th>
						<th>DM Block</th>
						<th>False Report</th>
						<th>Total Block</th>
						<th>Board Filtering</th>
						<th>Reply Filtering</th>
						<th>Total Filtering</th>
						<th style="color: rgb(196, 183, 34);">Warn</th>
						<th style="color:crimson">Kick Out</th>
					</tr>
				</thead>
				<tbody>
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
								<td >
									&nbsp;<%=((UserCondition)list.get(i)).getYellowCard() %> &nbsp;/&nbsp;
								<button type="button" class="custom-btn btn-14" name="<%= ((UserCondition)list.get(i)).getUserNo()%>">경고</button>
								</td>
								<% if(((UserCondition)list.get(i)).getYellowCard()>=4) { %>
										<td><button class="custom-btn btn-11" style="width: 85px; height: 30px;" 
												name="<%=((UserCondition)list.get(i)).getUserNo()%>">강제탈퇴</button></td>
								<% } else { %>
										<td><button class="custom-btn btn-16"  style="width: 85px; height: 30px;" name="<%=((UserCondition)list.get(i)).getUserNo()%>" disabled>강제탈퇴</button></td>
								<% } %>
							<% } %>
						</tr>
					<% } %>
				<% } %>
			</tbody>
		</table>
		</div>
    </div>
    <div>
    	<% if(pi.getMaxPage() > 1) { %>
			<!-- 페이징처리 -->
			<% if(pi.getCurrentPage()==1) {%>
			
				<button type="button" disabled>&lt;</button>
			<% } else { %>
				<button type="button" onclick="location.href='<%=contextPath%>/important.ck?currentPage=<%=pi.getCurrentPage()-1%>';">&lt;</button>
			<% } %>
			<% for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++) { %>
				<%if(i==pi.getCurrentPage()) {%>
					<button type="button" disabled><%=pi.getCurrentPage()%></button>
				<% } else {%>
					<button type="button" onclick="location.href='<%=contextPath%>/important.ck?currentPage=<%=i%>';"><%=i %></button>
				<% } %>
			<% } %>
			<% if(pi.getMaxPage()!=pi.getCurrentPage()) { %>
				<button type="button" onclick="location.href='<%=contextPath%>/important.ck?currentPage=<%=pi.getCurrentPage()+1%>';">&gt;</button>
			<% } else { %>
				<button type="button" disabled>&gt;</button>
			<% } %>
		<% } %>	
	</div>
    <script>
    	$(".btn-14").on("click", function(){
    		var userNo = $(this).attr("name");
    		$.ajax({
    			url : "important.ck",
    			data : { userNo : userNo,
    					 currentPage : "1"	
    			},
    			type : "post",
    			success : function(list){
    				alert("경고장 전송 완료");
    				var str = "";
					if(list?.length){ 
						/*
							js는 list.isEmpty or list.size로 비어있는지 확인 불가능
							list?. = 옵셔널체이닝 
							자바스크립트에서 존재하지 않는 요소에 접근하려 할 때 에러가 발생가능함.
							옵셔널 체이닝은 nullish한 (null or undefined) 값을 할당하고 있는 경우에 에러를 반환하지 않고 undefined를 반환
							왜냐하면 옵셔널 체인징(?.)은 바로 앞에있는 평가 대상에만 적용되고 확장하지 않아서 평가대상이 nullish한 경우 즉시 평가를 멈춘다.
							이를 옵셔널 체이닝의 단축평가라고 하고 이러한 이유 때문에 프러퍼티까지 평가하지 않고 중간에 평가를 멈춘 후 undefined를 반환하여 에러가 생기지 않는 것!
						
						*/
						for(var i=0;i<list.length; i++){
							str +="<tr>"
								+"<td>"+list[i].userNo+"</td>"
								+"<td>"+list[i].userId+"</td>"
								+"<td>"+list[i].userName+"</td>"
								i++;
							str+= "<td>"+list[i].blockC+"</td>"
								+"<td>"+list[i].dmBlockC+"</td>"
								+"<td>"+list[i].falseBlockC+"</td>"
								+"<td>"+list[i].totalB+"</td>"
								+"<td>"+list[i].boardFiltering+"</td>"
								+"<td>"+list[i].replyFiltering+"</td>"
								+"<td>"+list[i].totalF+"</td>"
								+"<td>"+list[i].yellowCard + " / "+
		                        "<button type='button' class='custom-btn btn-14' name='list[i].yellowCard'>경고</button></td>";
		                        if(list[i].yellowCard>=4) {
                        			str+="<td><button class='custom-btn btn-11' style='width: 85px; height: 30px;' name="+list[i].userNo+">강제탈퇴</button></td>";
                        		} else {
                        			str+="<td><button class='custom-btn btn-16' style='width: 85px; height: 30px;' name="+list[i].userNo+">강제탈퇴</button></td>";
                        		}
                        	}
								+"</tr>";
								
								$("#tab>tbody").html(str);
								
								location.reload(); // 이벤트가 삭제되어서 리로드 실행시킴.
						} else {
							str = "<p style='text-align: center; font-weight: bold; font-size:X-large; line-height:450px'>관리가 필요한 회원이 없습니다.</p>"
								+"<td><button class='custom-btn btn-8' onclick='location.href=<%=contextPath%>/main.admin'>메인으로</button></td>";
							$("#bb").html(str);
						}
    			},
    			error : function(){
    				alert("전송 오류 확인 필요");
    			}
    		});
    	});
    
        $("tbody>tr").click(function(e){
			var userNo = $(this).children().eq(0).text();
			location.href="<%=contextPath%>/update.um?userNo="+userNo;
			e.stopImmediatePropagation(); //다음 요소들로 전달을 막는 메서드 아래 2개의 function에도 작성함.
		});
        
        $(".btn-11").click(function(e){
        	var userNo = $(this).attr("name");
            if(confirm($(this).attr('name') + "번 회원과 작별인사 하시겠습니까?")){
                location.href="<%=contextPath%>/delete.um?userNo=" + userNo;
            } else {
                alert("탈퇴시키기를 취소하셨습니다.");
            }
            e.stopImmediatePropagation(); 
        }); 
        
        $(".btn-14").click(function(e){
        	e.stopImmediatePropagation(); 
        });
        

    </script>
</body>
</html>