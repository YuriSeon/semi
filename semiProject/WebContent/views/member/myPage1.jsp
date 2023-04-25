<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String alertMsg = (String)session.getAttribute("alertMsg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<title>마이페이지_쪽지</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
    
    @font-face {
        font-family: 'GmarketSansMedium';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }

        body{
            margin: 0px;
            color: #262626;
            box-sizing: border-box;
            font-family: 'GmarketSansMedium';
        }

        .wrapper{
            position: absolute;
            left: 50%;
            width: 1000px;
            height: 900px;
            margin-left: -500px;
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

        .btn{
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

        .btn:hover{
            background-color:#fff;
            color:deepskyblue;
            border: 1px solid deepskyblue;
        }

        .message_area{
            margin-top: 30px;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            margin-left: 10px;

        }

        .message_box{
            display: inline-block;
            width: calc(33.33% - 10px);
            box-sizing: border-box;
            padding: 10px;
            height: 150px;
            cursor: pointer;
            margin-right: 10px;
            margin-bottom: 10px;
            margin-top: 50px;
            box-shadow: 5px 8px 20px 1px grey;
            border-radius: 10px;
        }

        .msg_from{
            /* border: 1px solid red; */
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
            /* border: 1px solid green; */
            width: 70px;
            margin-top: -10px;
        }

        .msg_content>p{
            margin-top: -50px;
            margin-left: 90px;
            color: darkgrey;
        }

        #myModal{    
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
        }

        .modal-header{
            background-color: deepskyblue;
            color: #fefefe;
        }

        #modal-time{
            margin: 5px;  
            float: right;
            font-size: 13px;           
        }
        #modal-content{
            font-size: 15px;
        }

        .paging{
            text-align: center;
        }

        .paging a {
            display: inline-block;
            font-weight: bold;
            text-decoration: none;
            padding: 5px 8px;
            border: 1px solid #ccc;
            color: #000;
            background-color:#fff;
            margin-top: 100px;
        }

        .paging a.select{
            color: #fff;
            background-color: deepskyblue;
        }

   
</style>
<body>
<%
System.out.println(request.getSession().getAttribute("alertMsg"));
%>

    <div class="wrapper">
        <div id="head">마이 페이지</div>
        <hr>
        <div id="button-area">
            <button class="btn" id="message">내 쪽지함</button>
            <button class="btn" id="myinfo">프로필 수정</button>
            <button class="btn" id="like">좋아요</button>
        </div>

        <div class="message_area" id="message_area">
            <div class="message_box" id="msg1">
                <div class="msg_from">이름</div>
                <div class="msg_time">10:56 AM</div>
                <div class="msg_content">
                    <img src="resources/로고_투명배경.png" alt="">        
                    <p>내용</p>
                </div>
            </div>

            <div class="message_box" id="msg2">
                <div class="msg_content">
                    <div class="msg_from">이름</div>
                    <div class="msg_time">10:56 AM</div>
                    <div class="msg_content">
                        <img src="resources/로고_투명배경.png" alt="">        
                        <p>내용</p>
                    </div>
                </div>

            </div>
            <div class="message_box" id="msg3">
                <div class="msg_content">
                    <div class="msg_from">이름</div>
                    <div class="msg_time">10:56 AM</div>
                    <div class="msg_content">
                        <img src="resources/로고_투명배경.png" alt="">        
                        <p>내용</p>
                    </div>
                </div>

            </div>
            <div class="message_box" id="msg4">
                <div class="msg_content">
                    <div class="msg_from">이름</div>
                    <div class="msg_time">10:56 AM</div>
                    <div class="msg_content">
                        <img src="resources/로고_투명배경.png" alt="">        
                        <p>내용</p>
                    </div>
                </div>

            </div>
            <div class="message_box" id="msg5">
                <div class="msg_content">
                    <div class="msg_from">이름</div>
                    <div class="msg_time">10:56 AM</div>
                    <div class="msg_content">
                        <img src="resources/로고_투명배경.png" alt="">        
                        <p>안녕 잘지내지..? 기다릴게..</p>
                    </div>
                </div>

            </div>
            <div class="message_box" id="msg6">
                <div class="msg_content">
                    <div class="msg_from">이름</div>
                    <div class="msg_time">10:56 AM</div>
                    <div class="msg_content">
                        <img src="resources/로고_투명배경.png" alt="">        
                        <p>내용</p>
                    </div>
                </div>

            </div>
        </div>

        <div class="paging">
            <a href="#">&lt;</a>
            <a class="select" href="#">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">5</a>
            <a href="#">&gt;</a>
        </div>
        
    </div>


    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">브레이크타임_메세지</h4>
                </div>
                <div class="modal-body">
                    <div id="modal-name">발신자 : 이름</div>
                    <div id="modal-time">전송 시간 : 10:45 AM</div>
                    <div id="modal-content">내용 : </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>                    
                </div>
            </div>
        </div>
    </div>



    <script>
        $(document).ready(function(){
        	
        	<%if(request.getSession().getAttribute("alertMsg")!=null){%>
        	alert("<%=request.getSession().getAttribute("alertMsg")%>");
        	<%}%>
        	
            $('#message_area').on('click', '.message_box', function(event){

                var name = $(this).find('.msg_from').text();
                var time = $(this).find('.msg_time').text();
                var content = $(this).find('.msg_content p').html();
                console.log(content);

                $('#modal-name').text(name);
                $('#modal-time').text(time);
                $('#modal-content').html(content);

                $('#myModal').modal('show');
        

                $('#myModal').on('hidden.bs.modal', function (e) {
                    $(this).find('#modal-name').text('');
                    $(this).find('#modal-time').text('');
                    $(this).find('#modal-content').html('');
                    $(this).modal('hide');
        });
    });
});
    
    
        $(document).ready(function() {
            $('.modal-footer button').on('click', function() {
                $('#myModal').modal('hide');
            });
        });
    
    
        
    </script>
    





</body>
</html>