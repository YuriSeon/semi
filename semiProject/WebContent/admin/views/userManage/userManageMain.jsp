<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="java.util.ArrayList, com.kh.common.model.vo.PageInfo, 
    		com.kh.admin.userManage.model.vo.UserManage, com.kh.bMember.model.vo.BMember"%>
    
<% 
	ArrayList<Object> list = (ArrayList<Object>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
		<div>
			<div>
				<select name="select-sort" id="orderByS" >
					<option value="desc">내림차순</option>
					<option value="asc">오름차순</option>
				</select>
				<select name="select-order" id="orderByC">
					<option value="recently">recent update</option>
					<option value="foodRank">FoodRank</option>
					<option value="total">Activity</option>
				</select>
			</div>
		</div>
	<hr>
	<table id="tab">
		<thead>
			<tr>
				<th>NO</th>
				<th>ID</th>
				<th>NAME</th>
				<th>PHONE</th>
				<th>EMAIL</th>
				<th>UNIVERSITY</th>
				<th>UPLOAD BOARD</th>
				<th>UPLOAD VIDEO</th>
				<th>UPLOAD REPLY</th>
				<th>FOOD RANK</th>
				<th>INFO UPDATE</th>
			</tr>
		</thead>
		<tbody>
	
			<%if(!list.isEmpty()) { %>
				<%for(int i=0; i<list.size(); i++) {%>
					<tr>
						<%if(list.get(i) instanceof BMember) {%>
						
						<td><%=((BMember)list.get(i)).getUserNo()%></td>
						<td><%=((BMember)list.get(i)).getUserId() %></td>
						<td><%=((BMember)list.get(i)).getUserName() %></td>
						<td><%=((BMember)list.get(i)).getPhone() %></td>
						<td><%=((BMember)list.get(i)).getEmail() %></td>
						<td><%=((BMember)list.get(i)).getSchoolNo() %></td>
						<% } %>
						<% i++; %>
						<%if(list.get(i) instanceof UserManage) %>
						<td><%=((UserManage)list.get(i)).getBoardCount() %></td>
						<td><%=((UserManage)list.get(i)).getVideoCount() %></td>
						<td><%=((UserManage)list.get(i)).getReplyCount() %></td>
						<td><%=((UserManage)list.get(i)).getFoodBStatus() %></td>
						<td><button type="button" class="modal-trigger">회원정보수정</button></td>
					</tr>
				<% } %>
			<% } else { %>
				<tr>
					<td colspan="10">조회내역이 없습니다.</td>
				</tr>
			<% } %>
		</tbody>
	</table>
	
	<div>
	<!-- 페이징처리 -->
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

		<div id="ModalBgWrap" class="modal-wrap">
		  <div class="modal-bg mix"></div>
		</div> 
		
		<div id="ModalContentWrap" class="modal-wrap">
		  <div class="modal-content mix">
		    <div class="modal-close"><h1>✖</h1></div>
		  </div>
		</div>

	<script>
		$("#orderByS").on("change", function() {
			$.ajax({
				url : "main.um",
				data : {
					sort : $("#orderByS option:selected").val(),
					select : $("#orderByS option:selected").val(),
					currentPage : "1"
				},
				type : "post",
				success : function(list) {
					var str = "";
					<%int i = 0;%>
					for(i=<%=i%>;i<list.size(); i++){
						str +="<tr>"
							+"<td>"+list.get(i)).UserNo+"</td>"
							+"<td>"+list.get(i)).UserId+"</td>"
							+"<td>"+list.get(i)).UserName+"</td>"
							+"<td>"+list.get(i)).Phone+"</td>"
							+"<td>"+list.get(i)).Email+"</td>"
							+"<td>"+list.get(i)).SchoolNo+"</td>"
							<%i++;%>
							+"<td>"+list.get(i)).BoardCount+"</td>"
							+"<td>"+list.get(i)).VideoCount+"</td>"
							+"<td>"+list.get(i)).ReplyCount+"</td>"
							+"<td>"+list.get(i)).FoodBStatus+"</td>"
							+"<td>"<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">회원정보수정</button>"</td>"
							+"</tr>";
					}
					
					$("tab tbody").html(str);
					
				},
				error : function() {
					console.log("통신실패");
				}
			});
		});
		
		$("#orderByC").on("change", function() {
			$.ajax({
				url : "main.um",
				data : {
					sort : $("#orderByS option:selected").val(),
					select : $("#orderByS option:selected").val(),
					currentPage : "1"
				},
				type : "post",
				success : function(list) {
					console.log("성공")
				},
				error : function() {
					console.log("통신실패");
				}
			});
		});
	</script>
	<!-- 모달창 -->
		<!-- <script>
			// Declare modal object
		
			var mixModal = {
			  $bg: null,
			  $content: null,
			  init: function(){
			    
			    // Instantiate MixItUp on background wrapper
			    
			    this.$bg.mixItUp({
			      controls: {
			        enable: false
			      },
			      load: {
			        filter: 'none'
			      },
			      animation: {
			        effects: 'fade',
			        duration: 400,
			      }
			    });
			    
			    // Instantiate MixItUp on content wrapper
		
			    this.$content.mixItUp({
			      controls: {
			        enable: false
			      },
			      animation: {
			        effects: 'fade translateZ(-300px) translateY(5%)',
			        duration: 300,
			        easing: 'cubic-bezier(0.175, 0.885, 0.32, 1.275)'
			      },
			      load: {
			        filter: 'none'
			      }
			    });
			  },
			  
			  // Create a "show" method
			  
			  show: function(){
			    this.$bg.show().mixItUp('filter', 'all');
			    this.$content.show().mixItUp('filter','all'); 
			  },
			  
			  // Create a "hide" method
			  
			  hide: function(){
			    this.$bg.mixItUp('filter', 'none', function(){
			      $(this).hide();
			    });
			    this.$content.mixItUp('filter','none', function(){
			      $(this).hide();
			    });
			  }
			};
		
			// On document ready:
			  
			$(function(){
			  
			  // Assign elements to modal properties
			  
			  mixModal.$bg = $('#ModalBgWrap');
			  mixModal.$content = $('#ModalContentWrap');
			  
			  // Initialize modal
			  
			  mixModal.init();
			  
			  // Bind click handlers
			  
			  $('.modal-trigger').on('click', function(){
			    mixModal.show();
			  });
			  
			  $('.modal-close, .modal-wrap').on('click', function(e){
			    if(e.target === this){
			      mixModal.hide();
			    }
			  });
			  
			 });
	</script> -->
</body>
</html>