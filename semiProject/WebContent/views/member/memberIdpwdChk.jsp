<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 비밀번호 찾기 페이지</title>
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
            font-family: 'GmarketSansMedium';
        }

        .wrapper{
            position: absolute;
            display: flex;
            flex-direction: column;
            align-items: center;
            left: 50%;
            width: 1000px;
            height: 800px;
            margin-left: -500px;
        }

        .title{
            text-align: center;
            margin-top: 20px;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
            margin-left: -20px;
        }

        .idtext,.pwdtext{
            width: 250px;
            height: 40px;
            margin: 10px 0 10px 0;
            background-color: #FAFAFA;
            border: 1px solid #dbdbdb;
            border-radius: 3px;
        }

        .btn{
            width: 100%;
            height: 33px;
            margin: 20px 10px 5px 0;
            color: white;
            background-color: deepskyblue;
            border-radius: 5px;
            border-style: none;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
        }


        #id_modal,#pwd_modal{
            display: none;
            position: fixed;
            width: 300px;
            height: 150px;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            background: #fefefe;
            border: 1px solid #888;
            border-radius: 10px;
            text-align: center;
        }

        #id_modal .modal_btn,#pwd_modal .modal_btn{
            width: 150px;
            margin-top: 10px;
            height: 30px;
            background-color: deepskyblue;
            border-radius: 5px;
            border-style: none;
            color: white;
            font-weight: bold;
            cursor: pointer;
            font-family: 'GmarketSansMedium';
        }

        .modal_head{
            margin-top: 20px;
            font-size: 15px;
        }
        .modal_result1,.modal_result2{
            margin-top: 10px;
            font-size: 18px;
            color: crimson;
        }

    </style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="wrapper">
        <form action="find.me" method="post" class="form-horizontal" name="pfrm">
            <div class="title">아이디 찾기</div>
            <div class="inputform" id="modal_find">
                <input type="text" id="userName" name="userName" class="idtext" placeholder="이름"><br>
                <input type="email" id="userEmail" name="email" class="idtext" placeholder="이메일">
            </div>
            <div class="inputbtn">
                <input type="button" id="btn-modal1" class="btn" onclick="idSearch();" value="아이디 찾기">
            </div>
            <div class="title">비밀번호 찾기</div>
            <div class="inputform" id="modal_find2">
                <input type="text" id="userName2" name="userName" class="pwdtext" placeholder="이름"><br>
                <input type="text" id="userId" name="userId" class="pwdtext" placeholder="아이디">
            </div>
            <div class="inputbtn">
                <input type="button" id="btn-modal2" class="btn" onclick="pwdSearch();" value="비밀번호 찾기">
            </div>
        </form>
    </div>
    <div id="id_modal" class="modal-overlay">
        <div class="modal_body">
            <div class="modal_head">회원님의 아이디입니다.</div>
            <div class="modal_result1">아이디(뒷부분 *처리)</div> 
            <button class="modal_btn" onclick="login();">로그인 페이지로</button>
        </div>
    </div>
    <div id="pwd_modal" class="modal-overlay">
        <div class="modal_body">
            <div class="modal_head">회원님의 비밀번호입니다.</div>
            <div class="modal_result2">비밀번호(중간 *처리)</div>
            <button class="modal_btn" onclick="login();">로그인 페이지로</button>
        </div>
    </div>
    


    <script>
    
    	function login(){
    		location.href="<%=contextPath%>/login.me"
    	} 

        function idSearch(){//입력 빈칸 없을 때만 작동하게
            
            var userName = document.getElementById("userName").value;
            var userEmail = document.getElementById("userEmail").value;
            

            if(userName == ''){
                alert("이름을 입력해주세요");
                return false;
            }

            if(userEmail == ''){
                alert("이메일 주소를 입력해주세요");
                return false;
            }
            
            $.ajax({
            	type : "POST",
            	url : "find.me",
            	data : {
            		userName : userName,
            		email : userEmail
            	},
            	success : function(response){
            		if(response == ""){
            			alert("조회실패");
            			return;
            		}
            	var userId = response;
            	var idResult = document.querySelector(".modal_result1");
            	idResult.textContent = "아이디 : "+userId.substring(0, 2)+"*".repeat(userId.length-4)+ userId.substring(userId.length - 2);
            	
            	var idModal = document.getElementById("id_modal");
                idModal.style.display = "block";
              },
              error: function() {
                console.log("연결실패");
              }
            });


	            
	        }

        function pwdSearch(){//입력 빈칸 없을 때만 작동하게

            var userName2 = document.getElementById("userName2").value;
            var userId = document.getElementById("userId").value;

            console.log(userName2);
            if(userName2 == ""){
                alert("이름을 입력해주세요");
                return false;
            }

            if(userId == ""){
                alert("아이디를 입력해주세요");
                return false;
            }

            $.ajax({
            	type : "POST",
            	url : "find.me",
            	data : {
            		userName : userName2,
            		userId : userId
            	},
            	success : function(response){
            		if(response == ""){
            			alert("조회실패");
            			return;
            		}
            	var userPwd = response;
            	var pwdResult = document.querySelector(".modal_result2");
            	pwdResult.textContent = "비밀번호 : "+userPwd.substring(0, 2)+"*".repeat(userPwd.length-4)+ userPwd.substring(userPwd.length - 2);
            	
            	var pwd_modal = document.getElementById("pwd_modal");
            	pwd_modal.style.display = "block";
              },
              error: function() {
                console.log("연결실패");
              }
            });
        }

   
    </script>

</body>
</html>