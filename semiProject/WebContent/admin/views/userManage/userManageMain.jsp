<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="java.util.ArrayList, com.kh.common.model.vo.PageInfo, 
    		com.kh.admin.userManage.model.vo.UserManage, com.kh.bMember.model.vo.BMember"%>
    
<% 
	ArrayList<Object> list = (ArrayList<Object>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	int j = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body{
  background: #68b8c4;
  text-align: center;
  padding: 10%;
}

.modal-trigger{
  display: inline-block;
  background: white;
  border: 0;
  margin: 0;
  font-family: 'Helvetica Neue';
  font-weight: 300;
  font-size: 18px;
  padding: .5em 1em;
  border-radius: 5px;
  cursor: pointer;
  outline: 0 none;
}

.modal-wrap,
.modal-bg,
.modal-content{
  display: none;
  position: fixed;
}

.modal-wrap,
.modal-bg{
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
}

.modal-wrap{
  -webkit-backface-visibility: hidden;
  -webkit-transform: translateZ(0);
}

.modal-bg{
  background: rgba(0,0,0,.6);
}

.modal-content{
  text-align: right;
  padding: 10px;
  top: 50%;
  left: 50%;
  width: 400px;
  height: 300px;
  margin: -150px 0 0 -200px;
  background: white;
  border-radius: 9px;
}

.modal-close{
  display: inline-block;
  padding: 10px;
  cursor: pointer;
}
</style>
</head>
<body>
	<%@include file="../common/menubar.jsp" %>
		<div>
			<div>
				<select name="select-sort" class="orderBy" id="orderByS">
					<option value="desc">내림차순</option>
					<option value="asc">오름차순</option>
				</select>
				<select name="select-order" class="orderBy" id="orderByC">
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
						<%if(list.get(i) instanceof UserManage) {%>
						<td><%=((UserManage)list.get(i)).getBoardCount() %></td>
						<td><%=((UserManage)list.get(i)).getVideoCount() %></td>
						<td><%=((UserManage)list.get(i)).getReplyCount() %></td>
						<td><%=((UserManage)list.get(i)).getFoodBStatus() %></td>
						<td><button type="button" >회원정보수정</button></td>
					</tr>
						<% } %>
					<% } %>
			<% } else if (list==null) { %>
			
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

	<script>
		
		
		$(".orderBy").on("change", function() {
			var sort = $("#orderByS option:selected").val();
			var select = $("#orderByC option:selected").val();
			console.log(sort);
			console.log(select);
			$.ajax({
				url : "main.um",
				data : {
					sort : sort,
					select : select,
					currentPage : "1"
				},
				type : "post",
				success : function(list) {
					var str = "";
					if(sort == "asc"){
						for(var i=<%=j%>;i<list.length; i++){
							str +="<tr>"
								+"<td>"+list[i].userNo+"</td>"
								+"<td>"+list[i].userId+"</td>"
								+"<td>"+list[i].userName+"</td>"
								+"<td>"+list[i].phone+"</td>"
								+"<td>"+list[i].email+"</td>"
								+"<td>"+list[i].schoolNo+"</td>"
								i++;
								str+=
								"<td>"+list[i].boardCount+"</td>"
								+"<td>"+list[i].videoCount+"</td>"
								+"<td>"+list[i].replyCount+"</td>"
								+"<td>"+list[i].foodBStatus+"</td>"
								//+"<td>"<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">회원정보수정</button>"</td>"
								+"</tr>";
						}
					} else {
						for(var i=1;i<list.length; i+=3){
							str +="<tr>"
								+"<td>"+list[i].userNo+"</td>"
								+"<td>"+list[i].userId+"</td>"
								+"<td>"+list[i].userName+"</td>"
								+"<td>"+list[i].phone+"</td>"
								+"<td>"+list[i].email+"</td>"
								+"<td>"+list[i].schoolNo+"</td>"
								i--;
								str+=
								"<td>"+list[i].boardCount+"</td>"
								+"<td>"+list[i].videoCount+"</td>"
								+"<td>"+list[i].replyCount+"</td>"
								+"<td>"+list[i].foodBStatus+"</td>"
								//+"<td>"<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">회원정보수정</button>"</td>"
								+"</tr>";
						}
					}
					
					$("#tab tbody").html(str);
					
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