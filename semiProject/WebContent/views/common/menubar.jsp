<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.bMember.model.vo.BMember"%>
<%
	//로그인 유저 정보
	BMember loginUser = (BMember)session.getAttribute("loginUser");
	//알람 메세지
	String alertMsg = (String)session.getAttribute("alertMsg");
	//패스 변수
	String contextPath = request.getContextPath();
%>    
<!DOCTYPE html>
<html>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">    
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<!-- jQuery library -->
<script src="https://code.jquery.com/jquery-3.6.4.js"integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        /* 폰트 시작 */
        @font-face {
        font-family: 'LotteMartDream';
        font-style: normal;
        font-weight: 400;
        src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamMedium.woff2') format('woff2'), url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamMedium.woff') format('woff');
        }
        @font-face {
        font-family: 'LotteMartDream';
        font-style: normal;
        font-weight: 700;
        src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamBold.woff2') format('woff2'), url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamBold.woff') format('woff');
        }
        @font-face {
        font-family: 'LotteMartDream';
        font-style: normal;
        font-weight: 300;
        src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamLight.woff2') format('woff2'), url('//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamLight.woff') format('woff');
        }
        header {
        font-family: 'LotteMartDream', sans-serif;
        }

        /* 폰트 끝 */
        /* 노말라이즈 시작 */
        .con-min-width> ul, li {
        margin:0;
        padding:0;
        list-style:none;
        }
        .float-gird a {
        color:inherit;
        text-decoration:none;
        }
        /* 노말라이즈 끝 */
        /* 라이브러리 시작 */
        .con {
        margin-left:auto;
        margin-right:auto;
        }

        .bg-black {
        background-color:black;
        }

        .color-white {
        color:white;
        }

        .text-align-center {
        text-align:center;
        }
        .float-gird::after{
        content:"";
        display:block;
        clear:both;
        }

        .float-gird > *{
        float:left;
        box-sizing:border-box;
        }
        /* 라이브러리 끝 */
        /* 커스텀 시작 */
        .con-min-width {
        min-width:1200px;
        }

        .con {
        width:1200px;
        }
        .block {
        display:block;
        }
        /* 커스텀 끝 */
        /* logo 시작 */
        .logo {
        font-size:3rem;
        width:200px;
        height:175px;
        display:inline-block;
        
        

        }
        .com{
        box-sizing: border-box;
        }

        /* logo 끝 */
        /* logo bar 시작 */
        .logo-bar {
        background-color:white;
        color:black;
        height: 175px;
        }

        /* logo bar 끝 */

        /* 메뉴바 시작 */
        .menu-bar {
        background-color:skyblue;
        color:white;
        
        }
        /* 메뉴바 끝 */
        /* 메뉴바 - 메뉴1 시작 */
        .menu-bar__menu-1 ul > li {
        width:25%;
        }

        .menu-bar__menu-1 ul > li > a{
        font-size:1.5rem;
        text-align:center;
        padding:20px 0;
        border-radius:10px 10px 0 0;
        }

        .menu-bar__menu-1 ul > li:hover > a{
        background-color:white;
        color:black;
        }

        /* 메뉴바 - 메뉴1 끝 */
        #myModal{
        width: 200px;
    	}
    	.exit{
    		
    		text-decoration: none;
            color: darkgrey;
    	}
        .exit a{
            margin-left:1150px;
    		margin-top:-45px;
        }


        .exit:hover{
        	filter: invert(100%);
        }
        .nameArea{
	        margin-left:1050px;
	        margin-top : -60px;
	        margin-bottom: 10px;
	        font-size:20px;
	        margin-right:20px;
	        font-weight:bold;
	        color:deepskyblue;
	        text-align:center;
        }
        .friendList{
       		background-color:#F0F8FF;
       		border-radius:10px;
        	position:absolute;
        	width:150px;
        	height:600px;
        	text-align:center;
        	font-family: 'LotteMartDream';
        	margin-left:30px;
        	overflow:auto;
        	margin-top:10px;
        }
        .friendList a{
        	text-decoration:none;
        	color:deepskyblue;
        	font-weight:bold;
        	font-size:18px;
        	
        }
        #frdTb{
        	margin-top:20px;
        }
        #searchf{
        	margin-bottom:10px;
        	width:100%;
        }
        .frdBtn{
        	width:60px;
        	border-style:none;
        	background-color:deepskyblue;
        	text-align:center;
        	color:white;
        	border-radius:5px;
        }
        .frdHd{
        	font-size:18px;
        	font-weight:bold;
        	margin-top:10px;
        }

    </style>
</head>
<body>
    <!-- font-awsome load -->
    <script src="https://kit.fontawesome.com/d093edb2d8.js" crossorigin="anonymous"></script>


    <header class="logo-bar con-min-width">
    <div class="com text-align-center">
        <a href="./" class="logo">
        <img src="resources/밑에자른 로고.png" style="width: 200px; margin-top:0;">
        
        </a>
    </div>
    <div class="nameArea">
    	<span><%=loginUser.getUserNick() %> 님</span>
    	&nbsp&nbsp&nbsp
    	<% if(!(loginUser.getPower().equals("A"))) { %>
        	<a href="<%=contextPath%>/logout.me" class="exit">로그아웃</a>
        <% } else { %>
        	<a href="<%=contextPath%>/main.admin" class="exit">관리자 페이지로</a>
        <% } %>
        <img src="resources/로그아웃_투명.png" style="width: 30px;" class="exit">
    </div>
    
    </header>

    <header class="menu-bar con-min-width">
    <div class="con">
        <nav class="menu-bar__menu-1">
        <ul class="float-gird">
            <li>
            <a href="<%=contextPath%>/list.me?currentPage=1" class="block">
                <i class="fas fa-user"></i>
                <span>마이페이지</span>
            </a>
            </li>
            <li>
            
            <a href="javascript:void(0);" class="block">
                <i class="fa-solid fa-ban"></i>
                <span>공사중</span>
            </a>
             
            </li>
            <li>
            <%if(loginUser.getSchool_st().equals("N")){ %>
            <a href="javascript:void(0);" onclick="noSchool();" class="block">
                <i class="fa-solid fa-user-secret"></i>
                <span>대나무숲</span>
            </a>
            <%}else{ %>
            <a href="<%=contextPath%>/bamlist.bo?currentPage=1" class="block">
                <i class="fa-solid fa-user-secret"></i>
                <span>대나무숲</span>
            </a>
            <%} %>
            </li>
            <li>
            <a href="<%=contextPath%>/foodmain.bo" class="block">
                <i class="fa-solid fa-burger"></i>
                <span>맛집</span>
            </a>
            </li>
        </ul>
        </nav>
    </div>
    </header>
    
    <div class="friendList">
    	<table id="frdTb">
    		<thead style="font-size:19px;">
	    		<tr>
	    			<td>
	    			<p class="frdHd">친구 목록</p>
	    			</td>
	    		</tr>  		
	    		<tr>
	    			<td>
	    			<input type="text" name="searchNick" id="searchf">
	    			</td>
	    		</tr>
	    		<tr>
	    			<td>
	    			<button class="frdBtn" onclick="friendSearch();">검색</button>
	    			</td>
	    		</tr>	
    		</thead>
    		<tbody>
    		</tbody>


    	</table>
    	
    </div>
    	
    <div class="modal fade" id="myModal" tabindex="-1" >
        <div class="modal-dialog">
            <div class="modal-content">
            	<div class="modal-header">
            		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            	</div>
                <div class="modal-body">
                    <table border="1" id="nickname-layer">
                        <tr>
                            <td><button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#msgEnroll">메시지 보내기</button></td>
                        </tr>
                        <tr>
	                        <td><button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#msgBlock">차단하기</button></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
        <!-- 메시지 입력 모달 -->
    <div class="modal fade" id="msgEnroll" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">New message</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                        <div class="mb-3">
                            <label for="recipient-name" class="col-form-label">닉네임:</label>
                            <input type="text" class="form-control" id="recipient-name" readonly>
                        </div>
                         <div class="mb-3">
                            <label for="message-text" class="col-form-label">내용:</label>
                            <textarea class="form-control" id="message-text" style="resize:none"></textarea>
                </div>
             </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="msgEnroll();">Send message</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
        <!-- 차단 등록 모달 -->
    <div class="modal fade" id="msgBlock" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">차단 등록</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                        <div class="mb-3">
                            <label for="recipient-name" class="col-form-label">닉네임:</label>
                            <input type="text" class="form-control" id="block-name" readonly>
                        </div>
                         <div class="mb-3">
                            <label for="message-text" class="col-form-label">차단 메모:</label>
                            <textarea class="form-control" id="block-text" style="resize:none"></textarea>
                </div>
             </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="msgBlock();">차단 등록</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    
     <script >
	     $("#frdTb tbody").on("click", "tr" , function(){
	    	$("#recipient-name").val($(this).text()); //메시지 입력창 닉네임 넣기
	    	$("#block-name").val($(this).text());	//차단 등록창 닉네임 넣기
	     });
	     
	     $(document).ready(function(){
	    	 friendList(); // 초기화면에 친구목록 보여주기
	    	    $("#searchf").focus(function(){ //커서올리면 보여주기
	    	        friendSearch();
	    	    });
	    	});
	     
	     
	     function friendList(){//친구 목록 불러오기

	    	 $.ajax({
	    		 url: "friendList.me",
	    		 success:function(list){
	    			 var result = "";


	    			 for(var i=0; i<list.length; i++){
	    				 result += "<tr>"
	    				 		+"<td><a href='javascript:void(0)' data-bs-toggle=modal data-bs-target=#myModal class='userNick'>"+list[i]+"</a></td>"
	    				 		+"</tr>"
	    			 }
	    			 $("#frdTb tbody").html(result);
	    		 },
	    		 error:function(){
	    			 alert("목록 불러오기 실패");
	    		 }
	    	 });

	     }
	 	     	     
	     function friendSearch(){
	    	    var searchValue = $("#searchf").val();
	    	    if(searchValue == ''){//원래 ===
	    	        friendList();
	    	        return;
	    	    }
	     
    
	    	 $.ajax({//친구 이름 찾기

	    		 url: "friendList.me",
	    		 type: "post",
	    		 data:{
	    			 userNick:$("#searchf").val()
	    		 },
	    		 success : function(response){
	    			 if(response == ""){
	    				 alert("조회하신 회원이 없습니다.");
	    				 return;
	    			 }
	    			 var userNick = response;
	    			 var result = "";
	    			 result += "<tr>"
	    			 +"<td><a href='javascript:void(0)' data-bs-toggle=modal data-bs-target=#myModal class='userNick'>"+userNick+"</a></td>"
	    			 +"</tr>"
	    			 $("#frdTb tbody").html(result);
	    			 $("#searchf").val(""); // 검색 창 비우기

	    		 },
	    		 error: function(){
	    			 alert("목록 불러오기 실패");
	    		 }

	    	 });
	     }
    


	     
	     function noSchool(){
	    	 alert("대나무숲은 학교인증을 하셔야 이용 가능합니다.")
	     };
	     
	    function msgBlock(){ //메시지 차단 등록
	    	
	    	var blockContent = $("#block-text").val(); //차단 메모
	    	//정보 보내기
			location.href="<%=contextPath%>/msgblock.dm?userNick="+$('#block-name').val()+"&blockContent="+blockContent;	    	
	    }
	    
	     
     	function msgEnroll(){//메시지 보내기
     		
     		$.ajax({
     			url:"insertMsg.dm",
     			data:{
     				//받는회원 닉네임
     				acceptNick:$("#recipient-name").val(),
     				//메시지 내용
     				msgContent:$("#message-text").val()
     			},
     			type:"post",
     			success:function(result){
     				if(result>0){//인서트(작성) 성공
     					alert("메시지를 보냈습니다.");
     					$("#recipient-name").val("");
     					$("#message-text").val("");
     					
     				}else{//인서트 실패or차단 당함
     					alert("차단 당하셨습니다.");
     				}
     			},
     			error:function(){
     				console.log("통신실패");
     			}
     		});
     	}
	    
     </script>

</body>
</html>