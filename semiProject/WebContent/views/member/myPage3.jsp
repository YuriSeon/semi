<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지_포인트</title>
</head>
<style>
 @font-face {
        font-family: 'GmarketSansMedium';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }

        body{
            color: #262626;
            box-sizing: border-box;
            font-family: 'GmarketSansMedium';
        }

        .wrapper{
            position: relative;
            left: 50%;
            width: 1000px;
            height: 600px;
            margin-left: -500px;
            padding-bottom: 50px;
            font-family: 'GmarketSansMedium';
            margin-top : -70px;
        }

        #head{
            text-align: center;
            font-size: 25px;
            font-weight: bold;
            margin-top: 100px;
            margin-bottom: 20px;
        }

        #button-area{
            display: flex;
            flex-direction : row;
            margin-top: 30px;
            margin-left: 50px;
            margin-right: 50px;
            justify-content: space-between;
            flex-wrap: wrap;            
        }

        .btnmenu{
            width: 140px;
            height: 40px;
            margin-top: 20px;
            background-color: deepskyblue;
            color: white;
            border-radius: 5px;
            border-style: none;
            cursor: pointer;
            font-size: 17px;
            font-family: 'GmarketSansMedium';          
        }

        .btnmenu:hover{
            background-color:#fff;
            color:deepskyblue;
            border: 1px solid deepskyblue;
        }
        
           .point_table{
        	border:2px solid deepskyblue;
        	width: 500px;
        	height: 200px;
        	margin:auto;
        	margin-top:100px;
        	border-radius: 10px;
        	box-shadow: 5px 8px 20px 1px grey;
   	
        }

		.rageImg{
			float:left;
			margin-right:20px;
		}
		
		#p1{
			text-align:center;
			font-weight:bold;
			color:deepskyblue;
			margin-top:15px;
			font-size:20px;
		}
		
		#p2{
			text-algin:right;
			margin-left: 20px;
		}
		
    
</style>
<body>
	<%@ include file ="../common/menubar.jsp"%> 
	<div class="wrapper">
        <div id="head">마이 페이지</div>
        <hr>
        <div id="button-area">
            <button class="btnmenu" onclick="location.href='<%=contextPath %>/list.me?currentPage=1'" id="message">내 쪽지함</button>
            <button class="btnmenu" onclick="location.href='<%=contextPath %>/myPage2.me'" id="myinfo">프로필 수정</button>
            <button class="btnmenu" onclick="location.href='<%=contextPath %>/myPage3.me'" id="like">포인트</button>
        </div>

       <div class="point_table">
			<p id="p1"><%=loginUser.getUserNick()%> 님의 현재 포인트 : <%=loginUser.getPoint() %></p>				
			<p id="p2"><%=loginUser.getUserNick()%> 님의 현재 등급 : 
			
				<%
					int point = loginUser.getPoint();
					String name = "";
					String nextName = "";
			        int nextPoint = 0;
			        String img = "";
			        
					if(point>90){
						name = "자칭 요리사";
						nextName = "없음";
						img = "resources/자칭요리사.png";
						
					}else if(point>60){
						name = "맛잘알";
						nextName = "자칭 요리사";
						nextPoint = 90 - point;
						img = "resources/맛잘알.png";
						
					}else if(point>30){
						name = "소소한 입맛";
						nextName = "맛잘알";
						nextPoint = 60 - point;
						img = "resources/소소한입맛.png";
						
					}else if(point >= 0){
						name = "시민";
						nextName = "소소한 입맛";
						nextPoint = 30 - point;
						img = "resources/시민.png";
					}else{
						name = "먹이 사절";
						nextName = "시민";
						nextPoint = 30;
						img = "resources/먹이사절.png";
					}
					out.print(name);
				%>
			<img class="rageImg" src="<%=img %>" style="width:100px;" alt="" >			
			
			</p>
			
			<% if(!nextName.equals("없음")){ %>
			<p>다음 등급까지 (<%=nextName %>) <%=nextPoint %> 점 남았습니다!</p>
			<%} %>
       </div>
       
    </div>
</body>
</html>