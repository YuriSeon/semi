<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
String alertMsg = (String) request.getSession().getAttribute("alertMsg");
String email = request.getParameter("email");
String code = (String) request.getAttribute("code");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
@font-face {
	font-family: 'GmarketSansMedium';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

body {
	margin: 0px;
	color: #262626;
	box-sizing: border-box;
	font-family: 'GmarketSansMedium';
}

.wrapper {
	position: absolute;
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 800px;
	height: 1000px;
	left: 50%;
	margin-left: -400px;
}

#join_head {
	font-size: 22px;
	text-align: center;
	font-weight: bold;
	color: #262626;
}

#p2 {
	margin-top: -5%;
	margin-bottom: 10%;
	font-size: 15px;
	color: deepskyblue;
}

#join_form {
	width: 500px;
}

.condition {
	color: dimgrey;
	font-size: 10px;
	margin-top: -2px;
}

.login_text {
	float: right;
	width: 300px;
	margin-bottom: 10px;
}

#submit input {
	width: 500px;
	height: 30px;
	background-color: deepskyblue;
	color: white;
	border-radius: 5px;
	border-style: none;
	cursor: pointer;
	font-size: 17px;
	font-family: 'GmarketSansMedium';
}

.form-group button {
	width: 80px;
	height: 25px;
	background-color: deepskyblue;
	color: white;
	border-radius: 5px;
	border-style: none;
	cursor: pointer;
	font-family: 'GmarketSansMedium';
}

.school button {
	height: 25px;
	background-color: deepskyblue;
	color: white;
	border-radius: 5px;
	border-style: none;
	cursor: pointer;
	font-family: 'GmarketSansMedium';
}
</style>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>
<script>
		//script태그 내에서도 스크립틀릿과 같은 jsp요소를 사용할 수 있다.
		var msg = "<%=alertMsg%>"; //성공적으로 로그인 되었습니다 / null
		if(msg !="null"){
			alert(msg);
			//알람메세지 한번 띄웠으면 지워주기 지우지 않으면 매번 menubar.jsp가 열릴때마다 알림뜸
			<%session.removeAttribute("alertMsg");%>
		}
	</script>
	<div class="wrapper">
		<div id="join_head">
			<p>브레이크타임 신규 회원 가입</p>
			<p id="p2">회원 가입 후 브레이크 타임을 편리하게 이용하세요!</p>
		</div>
		<form action="<%=contextPath%>/insert.me" id="join_form"
			method="post">
			<div class="form-group">
				<label for="userId">아이디 *</label><input type="text" id="userId"
					name="userId" class="login_text"
					style="width: 200px; float: none; margin-left: 135px;" required>
				<button onclick="idCheck();" style="width: 90px;">중복 확인</button>
				<br>
				<p class="condition" id="con1" style="margin-top: -10px;">숫자/영문자
					포함 5~20자</p>
			</div>

			<div class="form-group">
				<label for="userPwd">비밀번호 *</label> <input type="password"
					id="userPwd" name="userPwd" class="login_text" required> <br>
				<p class="condition" id="con2">숫자/영문자,특문 포함 5~20자</p>
			</div>

			<div class="form-group">
				<label for="chkPwd">비밀번호 확인 *</label> <input type="password"
					id="chkPwd" name="chkPwd" class="login_text" required> <br>
				<p class="condition" id="con3" style="color: white;">내용</p>
			</div>

			<div class="form-group">
				<label for="userName">이름 *</label> <input type="text" id="userName"
					name="userName" class="login_text" required> <br>
				<p class="condition" id="con4" style="color: white;">내용</p>
			</div>

			<div class="form-group">
				<label for="phone">휴대전화 *</label> <input type="text" id="phone"
					name="phone" class="login_text" required> <br>
				<p class="condition" id="con5" style="color: white;">내용</p>
			</div>

			<div class="form-group">
				<label for="address">주소 *</label> <input type="address" id="address"
					name="address" class="login_text"
					style="width: 180px; float: none; margin-left: 145px;" required>
				<button type="button" id="addressBtn" onclick="openDaumPostcode();"
					class="" style="width: 110px;">주소 찾기</button>
				<br>
				<p class="condition" id="con6"
					style="color: white; margin-top: -10px;">내용</p>
			</div>

			<div class="form_group">
				<label for="email">이메일 *</label> <input type="email" id="email"
					name="email" class="login_text" required> <br>
				<p class="condition" id="con7">'@'포함하여 입력</p>
			</div>

			<div class="form-group">
				<label for="ssn">주민등록번호 *</label> <input type="text" id="ssn"
					name="ssn" class="login_text" required> <br>
				<p class="condition" id="con8">'-'포함하여 입력</p>
			</div>

			<div class="form-group">
				<label for="userNick">닉네임 *</label> <input type="text" id="userNick"
					name="userNick" class="login_text" required> <br>
				<p class="condition" id="con9" style="color: white;">내용</p>
			</div>

			<br>
			<hr>
			<br> 추가 정보(선택 가능) <br>
			<br>
			<div class="school">
				학교 이름 <select name="schoolNo" id="sName" class="login_text"
					style="text-align: center; font-family: 'GmarketSansMedium';">
					<option value="0">선택안함</option>
					<option value="1">서울대학교</option>
					<option value="2">고려대학교</option>
					<option value="3">연세대학교</option>
					<option value="4">서강대학교</option>
					<option value="5">성균관대학교</option>
					<option value="6">한양대학교</option>
					<option value="7">이화여자대학교</option>
					<option value="8">건국대학교</option>
					<option value="9">중앙대학교</option>
					<option value="10">동국대학교</option>
				</select>
				<p class="condition" id="con10">학교 이름 선택</p>
			</div>
			<div class="school">
				학교 이메일 <input type="email" id="sEmail" class="login_text"
					style="width: 180px; float: none; margin-left: 110px;">
				<button type="button" id="verifyButton" class="validate-btn"
					style="width: 105px;">학교 인증</button>
					
				<p class="condition" id="con11"
					style="margin-top: -10px; color: white;">내용</p>
				<input type="text" id="chkS" class="login_text"
					style="width: 180px; float: none; margin-left: 200px;">
				<button type="button" id="chkSchool" class="chkSchool-btn"
					style="width: 105px;">인증 번호</button>	
			</div>

			<br>
			<br>
			<div id="submit">
				<input type="submit" value="회원가입" onclick="validate();">
			</div>

		</form>

	</div>

	<script>
    
    $("#verifyButton").on("click", function(){//학생 인증 버튼
		var condition11 = document.getElementById("con11");
		var flag = sval();
		
		if(flag){
			sendEmail(event);
          	//condition11.innerHTML = "학교 인증 완료";
            //condition11.style.color = "deepskyblue";
		}
	});
    
    var checkCode;
    
    $("#chkSchool").on("click",function(){
    	var condition11 = document.getElementById("con11");
    	var chkS = document.getElementById("chkS").value.trim();
    	var code = checkCode.trim();
    	
    	if(code == chkS){
    		condition11.innerHTML = "학교 인증 완료";
            condition11.style.color = "deepskyblue";
    	}else{
    		condition11.innerHTML = "인증번호가 일치하지 않습니다.";
            condition11.style.color = "red";
    	}
    });
    
    function sval(){
	    var inputSname = document.getElementById("sName");
	    var inputSemail = document.getElementById("sEmail");
	    var condition10 = document.getElementById("con10");
	    var condition11 = document.getElementById("con11");
	    var inputSsn = document.getElementById("ssn");
	    var validateBtn = document.querySelector(".validate-btn");
	    var ageLimit = 35;
	    var birthYear = '19'+inputSsn.value.substring(0,2);
	    var currentYear = '20'+new Date().getFullYear()% 100;
	    var age = currentYear - birthYear +1;

	    inputSname.addEventListener('blur',()=>{
	      if(inputSname.value = ''){
	        condition10.innerHTML = "올바르지 않은 학교 이름입니다.";
	        condition10.style.color = "red"
	        inputSname.focus();
	      }else{
	        condition10.innerHTML = "✔";
	        condition10.style.color = "deepskyblue";                    
	      }
	    });

	    inputSemail.addEventListener('blur', () => {
	      if (inputSemail.value != '') {
	        var regExp10 = /@naver\.com$/;
	        if (!regExp10.test(inputSemail.value)) {
	          condition11.innerHTML = "올바르지 않은 메일 형식입니다.";
	          condition11.style.color = "red"
	          inputSemail.focus();
	        } else {

	        }
	      }
	    });

	    if (age >= ageLimit) {
	      alert("정말로 학생이신가요..? "+ageLimit+"세 까지만 인증 가능합니다..");
	      document.getElementById("sName").value="0";
	      document.getElementById("sEmail").value="";
	      return false;
	    }

	    return true;
	  }
    
    
    function idCheck(){//아디 중복확인
		
    	var $checkId = $("#join_form input[name=userId]");
    	var condition1 = document.getElementById("con1");
		
		$.ajax({
			type : "GET",
			url : "idCheck.do",
			data : {
				checkId : $checkId.val()
			},
			success : function(result){
				if(result == "NNNNN"){
					alert("이미 존재하거나 탈퇴한 유저의 아이디입니다.");
	                $checkId.val("").focus();
	                $(condition1).html("사용 불가한 아이디입니다.");
	                $(condition1).css("color","red");
	                return;
				}else{
					if(confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")){
						$("#enroll-form button[type=submit]").removeAttr("disabled");
						$checkId.attr("readonly", true);
						$(condition1).html("사용 가능한 아이디입니다.");
						$(condition1).css("color","deepskyblue")
					}else{
						$checkId.val("").focus();
	
					}
				}
			},
			error : function() {
				console.log("요청 실패");
			}
		});
	}

    
        function validate(){//정규표현식

               var inputId = document.getElementById("userId");
                var inputPwd = document.getElementById("userPwd");
                var inputCp = document.getElementById("chkPwd");
                var inputName = document.getElementById("userName");
                var inputPhone = document.getElementById("phone");
                var inputAddress = document.getElementById("address");
                var inputEmail = document.getElementById("email");
                var inputSsn = document.getElementById("ssn");
                var inputNick = document.getElementById("userNick");
                

                var condition1 = document.getElementById("con1");
                var condition2 = document.getElementById("con2");
                var condition3 = document.getElementById("con3");
                var condition4 = document.getElementById("con4");
                var condition5 = document.getElementById("con5");
                var condition6 = document.getElementById("con6");
                var condition7 = document.getElementById("con7");
                var condition8 = document.getElementById("con8");
                var condition9 = document.getElementById("con9");


                inputId.addEventListener('blur',()=>{
                    var regExp1 = /^[a-zA-Z][a-zA-Z0-9]{5,20}$/;
                   
                    if(!regExp1.test(inputId.value)){                  
                    condition1.innerHTML = "아이디 형식이 올바르지 않습니다.";
                    condition1.style.color = "red"
                    inputId.focus();
                }else{
                    condition1.innerHTML = "사용 가능한 아이디입니다!";
                    condition1.style.color = "deepskyblue";
                }
                });

                inputPwd.addEventListener('blur',()=>{
                    var regExp2 = /^[a-zA-Z0-9!@#$%^&*]{5,20}$/;
                   
                    if(!regExp2.test(inputPwd.value)){
                        condition2.innerHTML = "비밀번호 형식이 올바르지 않습니다.";
                        condition2.style.color = "red"
                        //inputPwd.focus();
                    
                    }else{
                        condition2.innerHTML="✔";
                        condition2.style.color = "deepskyblue";
                    }

                });

                inputCp.addEventListener('blur',()=>{
                    
                    if(inputPwd.value!=inputCp.value){
                        condition3.innerHTML = "비밀번호가 일치하지 않습니다.";
                        condition3.style.color = "red"
                        inputCp.focus();
                    }else{
                        condition3.innerHTML="✔";
                        condition3.style.color= "deepskyblue";
                    }
                });


                inputName.addEventListener('blur',()=>{
                    var regExp3 = /^[가-힣]{2,}$/;
                    

                    if(!regExp3.test(inputName.value)){
                        condition4.innerHTML = "2글자 이상 한글로만 작성해주세요";
                        condition4.style.color = "red";
                        inputName.focus();
                    }else{
                        condition4.innerHTML = "멋진 이름이네요!";
                        condition4.style.color = "deepskyblue";
                    }

                });


                inputPhone.addEventListener('blur',()=>{
                    var regExp4 = /^\d{3}\d{3,4}\d{4}$/;
                    

                    if(!regExp4.test(inputPhone.value)){
                        condition5.innerHTML = "숫자로만 입력해주세요";
                        condition5.style.color = "red";
                        inputPhone.focus();
                    }else{
                        condition5.innerHTML = "✔";
                        condition5.style.color = "deepskyblue";
                    }

                });

                inputAddress.addEventListener('blur',()=>{
                    var regExp5 = /^[a-zA-Z0-9가-힣/\s/g ]{2,}$/;
                    

                    if(!regExp5.test(inputAddress.value)){
                        condition6.innerHTML = "전체 주소를 입력해주세요";
                        condition6.style.color = "red";
                        inputAddress.focus();
                        // return false;
                    }else{
                        condition6.innerHTML = "✔";
                        condition6.style.color = "deepskyblue";
                    }

                });

                inputEmail.addEventListener('blur',()=>{
                    var regExp6 = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
                    

                    if(!regExp6.test(inputEmail.value)){
                        condition7.innerHTML = "'@'' 포함하여 입력해주세요";
                        condition7.style.color = "red";
                        inputEmail.focus();

                    }else{
                        condition7.innerHTML = "✔";
                        condition7.style.color = "deepskyblue";
                    }

                });

                inputSsn.addEventListener('blur',()=>{
                    var regExp7 = /^\d{6}-\d{7}$/;
                    

                    if(!regExp7.test(inputSsn.value)){
                        condition8.innerHTML = "'-' 포함하여 입력해주세요";
                        condition8.style.color = "red";
                        inputSsn.focus();

                    }else{
                        condition8.innerHTML = "✔";
                        condition8.style.color = "deepskyblue";
                    }

                });

                inputNick.addEventListener('blur',()=>{
                    var regExp8 = /^[a-zA-Z0-9가-힣]{1,}$/;
                    

                    if(!regExp8.test(inputNick.value)){
                        condition9.innerHTML = "입력을 하셔야 합니다!";
                        condition9.style.color = "red";
                        inputNick.focus();

                    }else{
                        condition9.innerHTML = "✔";
                        condition9.style.color = "deepskyblue";
                    }

                });
               
            }
            validate();//전체 검사 끝
            
            function sendEmail(event){//메일인증 시작
          	  event.preventDefault();
          	  var inputSemail = document.getElementById("sEmail");
          	  var email = inputSemail.value;
          	  var xhttp = new XMLHttpRequest();
          	  xhttp.onreadystatechange = function() {
          	    if (this.readyState == 4 && this.status == 200) {
          	    alert("이메일 전송이 완료되었습니다.");
          	      var code = this.responseText;
          	      checkCode = code;
          	    }
          	  };
          	  xhttp.open("POST", "sendEmail.me", true);
          	  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
          	  xhttp.send("email=" + email);
          	}//메일인증 끝

    function openDaumPostcode(){//주소 찾기

        new daum.Postcode({
            oncomplete: function(data) {

                var fullAddress = "";

                if (data.userSelectedType === 'R') {
                    fullAddress = data.roadAddress;
                } else {
                    fullAddress = data.jibunAddress;
                }


                if(data.userSelectedType === 'R'){

                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        fullAddress += " "+data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        fullAddress += ' ' + data.buildingName;
                    }
                }

                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("address").value = fullAddress;
                
                }

                
        }).open();
        }
    
      
           
    </script>
</body>
</html>