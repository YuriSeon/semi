<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.bMember.model.vo.BMember"%>
<%

	String contextPath = request.getContextPath();

	BMember loginUser = (BMember)session.getAttribute("loginUser");
	
	String alertMsg = (String)session.getAttribute("alertMsg");

%>
<!DOCTYPE html>
<html>
<head>
<title>Break Time[Main]</title>
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

        a{
            text-decoration: none;
            color: #262626;
        }

        .login_wrapper{
            position: absolute;
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 700px;
            height: 500px;
            
            top: 40%;
            left: 50%;
            margin-top: -220px;
            margin-right: 100px;
            margin-left: -260px;

        }

        #login_hi{

            color:#333333;
            font-weight: bold;
            margin-left: -200px;
            margin-top: -40px;
        }

        #p1{
            margin: 100px 0px 30px -100px;
            font-size: 22px;
        }
        #p2{
            margin-top: -30px;
            margin-right: 110px;
            margin-left: -100px;
            font-size: 15px;
            color: deepskyblue;
           
        }



        .login_text{
            width: 100%;
            height: 40px;
            margin: 10px 0 10px 0;
            background-color: #FAFAFA;
            border: 1px solid #dbdbdb;
            border-radius: 3px;
        }

        .login_text:focus{
            outline: 1px solid #a8a8a8;
        }

        .login_text::placeholder{
            color: #8e8e8e;
            
        }

        .login_text::value{
            color: #262626;
            
        }



        .login_bottom{
            
            color:dimgrey;
            font-size: 10px;
            margin-left: 120px;
            
        }

        #login_last{
            font-size: 15px;
            font-weight: bold;
        }
        #login_last>a{
            font-size: 18px;
            color: deepskyblue;
        }

        #login_logo{
            margin-left: -530px;
            margin-top: 30px;
        }
        .login_form{
            /* display: flex; */
            /* flex-direction: column; */
            width: 300px;
            margin-top: -160px;
        }

        .login_btn{
            width: 480px;
            height: 33px;
            margin: 10px 10px 5px 0;
            margin-left: -170px;
            color: white;
            background-color: deepskyblue;
            border-radius: 5px;
            border-style: none;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
        }

        p{
            margin-left: -380px;
        }

    </style>  

</head>
<body>
	<script>
	
		//var msg = "<%=alertMsg %>";
		
		//if(msg != "null"){
			//alert(msg);
			
			//<%session.removeAttribute("alertMsg");%>
		//}
	
	</script>
    <div class="login_wrapper">
    

        <div id="login_hi">
            <p id="p1">브레이크 타임에 오신 것을 환영합니다!</p>
            <p id="p2">우리들의 쉬는 시간, 브레이크 타임</p>
        </div>
        
            <div id="login_logo">
                <img id="logo" src="resources/로고_투명배경.png" width="150px" height="150px" alt="">
            </div>
            <form class="login_form" action="<%=contextPath %>/login.me" method="post">
                <input type="text" id="login_id" class="login_text" name="userId" placeholder="아이디를 입력해주세요" required>
                <input type="password" id="login_pwd" class="login_text" name="userPwd" placeholder="비밀번호를 입력해주세요" required>
            	<button id="login_btn" class="login_btn" type="submit" onclick="login();">로그인</button>
            </form>
            <a class="login_bottom" href="<%=contextPath%>/find.me">아이디 또는 비밀번호를 잊으셨나요?</a>
            <p id="login_last">브레이크타임이 처음이신가요?  <a class="join" href="<%=contextPath%>/enrollForm.me">회원가입</a> </p>
        
    </div>

</body>
</html>