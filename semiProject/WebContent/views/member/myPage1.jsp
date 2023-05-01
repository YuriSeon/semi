<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,
    com.kh.bMember.model.*,com.kh.message.model.vo.*,com.kh.common.model.vo.PageInfo"%>
<%
	ArrayList<Message> list = (ArrayList<Message>)request.getAttribute("list");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>마이페이지_쪽지</title>

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
            height: 900px;
            margin-left: -500px;
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

        .message_area{
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .message_box{
        	flex-basis: 32%;
            justify-content: space-between;
            padding: 10px;
            height: 150px;
            cursor: pointer;
            box-sizing: border-box;
            margin-top: 70px;
            box-shadow: 5px 8px 20px 1px grey;
            border-radius: 10px;
            margin-bottom: 10px;
            margin-right: 10px;
        }
        
        .message_box:hover{
        	filter: invert(90%);
        	transform: scale(.9);
        }

        .msg_from{
            margin-left: 80px;
            margin-top: 15px;
            font-size: 18px;
            color: darkgrey;
        }
        .msg_time{
            margin-left: 220px;
            margin-top: -10px;
            color: darkgrey;
            font-size: 11px;
        }

        .msg_content>img{
            width: 70px;
            margin-top: -10px;
        }

        .msg_content>p{
            margin-top: -50px;
            margin-left: 90px;
            color: darkgrey;
        }

        #myModal1{    
            position: fixed;
            width: 600px;
            height: 300px;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            background: #fefefe;
            border: 1px solid #888;
            border-radius: 10px;
            color: #888;
            font-family: 'GmarketSansMedium';
        }

        .modal-header1{
            background-color: deepskyblue;
            color: #fefefe;
        }
        .modal-title{
        	font-size:15px;
        }
        
        #modal-name1{
        	font-size:20x;
        	color:deepskyblue;
        }

        #modal-time1{
            margin: 5px;  
            float: right;
            font-size: 13px;           
        }
        #modal-content1{
            margin-top:20px;
            font-size: 15px;
        }

        .paging{
            position: absolute;
        	bottom: 70px;
        	left: 50%;
            text-align: center;
            transform: translateX(-50%);
        }

        .paging a {
            display: inline-block;
            font-weight: bold;
            text-decoration: none;
            padding: 5px 8px;
            border: 1px solid #ccc;
            color: #000;
            background-color:#fff;
            margin-top: 400px;
        }

        .paging a.select{
            color: #fff;
            background-color: deepskyblue;
        }
        
        .nomsg{
        	font-size : 20px;
        	text-align: center;
        	margin-top: 100px;
        }
        
        .nomsgImg{
        	width:400px;
        	position: absolute;
            left: 50%;
            height: 400px;
            margin-left: -240px;
        }
        
        .modal-footer1{
			margin-top:70px;
			float:right;
			margin-right:10px;
		}
		
		.msgbtn{
			 width: 100px;
            height: 40px;
            background-color: deepskyblue;
            color: white;
            border-radius: 5px;
            border-style: none;
            cursor: pointer;
            font-size: 17px;
            float:right; 
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
        
        
	<%if(list==null||list.isEmpty()){ %>
        	<p class="nomsg">도착한 메세지가 없습니다. ㅠㅠ</p>
        	<img class="nomsgImg" src="resources/메일비었음.jpg" style="width:500px;" alt="">
		<%}else{ %>
		
        	<div class="message_area" id="message_area">
			<%for(Message m : list){ %>
            <div class="message_box" id="msg1">
                <div class="msg_from"><%=m.getUserWriter() %></div>
                <div class="msg_time"><%=m.getMsgSendDate() %></div>
                <div class="msg_content">
                    <img src="resources/로고_투명배경.png" alt="">        
                    <p><%=m.getMsgContent() %></p>
                </div>
            </div>

   		<%} %>
   		<%} %>
        </div>


		<div class="paging">

        	<%if(pi.getMaxPage()>=1){ %>
        	
	        	<%if(pi.getCurrentPage()!=1){ %>
	            	<a href="<%=contextPath%>/list.me?currentPage=<%=pi.getCurrentPage()-1%>">&lt;</a>
	           		
	            <%} %>
	            <%for(int i=pi.getStartPage(); i<=pi.getEndPage(); i++){ %>
	            	<%if(i != pi.getCurrentPage()) {%>
	            		<a href="<%=contextPath%>/list.me?currentPage=<%=i%>";><%=i %></a>
	           		<%}else {%>
	            		<a class="select"><%=i %></a>
	           		<%} %>
				<%} %>
				
				<%if(pi.getCurrentPage()!=pi.getMaxPage()) {%>
            	<a href="<%=contextPath%>/list.me?currentPage=<%=pi.getCurrentPage()+1%>">&gt;</a>
        	<%} %>
        <%} %>    
        </div>
    </div>


    <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModal1Label" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content1">
                <div class="modal-header1">
                    <h4 class="modal-title" id="myModalLabel">브레이크타임_메세지</h4>
                </div>
                <div class="modal-body">
                    <div id="modal-name1">발신자 : 이름</div>
                    <div id="modal-time1">전송 시간 : 10:45 AM</div>
                    <div id="modal-content1">내용 : </div>
                </div>
                <div class="modal-footer1">
                    <button type="button" class="msgbtn" data-dismiss="modal">닫기</button>                    
                </div>
            </div>
        </div>
    </div>



    <script>
        $(document).ready(function(){
        	
        	
            $('#message_area').on('click', '.message_box', function(event){

                var name = $(this).find('.msg_from').text();
                var time = $(this).find('.msg_time').text();
                var content = $(this).find('.msg_content p').html();

                $('#modal-name1').text(name);
                $('#modal-time1').text(time);
                $('#modal-content1').html(content);

                $('#myModal1').modal('show');
        

                $('#myModal1').on('hidden.bs.modal', function (e) {
                    $(this).find('#modal-name1').text('');
                    $(this).find('#modal-time1').text('');
                    $(this).find('#modal-content1').html('');
                    $(this).modal('hide');
        });
    });
});
    
    
        $(document).ready(function() {
            $('.modal-footer1 button').on('click', function() {
                $('#myModal1').modal('hide');
            });
        });
    
    
        
    </script>
    


</body>
</html>